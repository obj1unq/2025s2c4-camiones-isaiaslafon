
// De las cosas que puede transportar el camión nos interesa el peso y la peligrosidad: Éstas son algunas de las cosas:
//     Bumblebee: pesa 800 kilos y su nivel de peligrosidad es 15 si está transformado en auto o 30 si está como robot.
//     Paquete de ladrillos: cada ladrillo pesa 2 kilos, la cantidad de ladrillos que tiene puede variar. La peligrosidad es 2.
//     Batería antiaérea: el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está con los misiles y 0 en otro caso.
//     Residuos radiactivos: el peso es variable y su peligrosidad es 200.


object knightRider {
	method peso() { return 500 }
	
	method peligrosidad() { return 10 }

	method bultos() = 1

	method serImpactado(){
		//NO HACE NADA, por eso va vacío!
	}
}

object arenaGranel {
	var property peso = 0

	method peligrosidad() { return 1 }

	method bultos() = 1

	method serImpactado(){
		peso += 20
	}
}


object bumblebee {
	var modo = auto
	
	method modo() = modo

	method transformar(){
		modo = modo.siguiente()
	}

    method serImpactado(){
		self.transformar()
	}

	method peso() { return 800 }

	method peligrosidad() { 
		return modo.peligrosidad() 
		//return if(enAuto) 15 else 30	
		//return if(not enAuto) 30 else 15
	}

	method bultos() = 2
}

object paqueteLadrillos{
	const pesoLadrillo = 2
	var property cantidad = 0

	method peso() = cantidad * pesoLadrillo

	method peligrosidad() = 2

	method bultos() {
		return if(self.hasta(100)) 1 
				else if(self.hasta(300)) 2 
					else 3
	}

	method hasta(unidades) = cantidad <= unidades

	method serImpactado(){
		cantidad = 0.max(cantidad - 12)
	}
}

object bateriaAntiaerea{
	var tieneMisiles = false

	method cargarMisiles(){
		tieneMisiles = true
	}

	method descargarMisiles(){
		tieneMisiles = false
	}
	
	method peso() = if(tieneMisiles)  300 else 200

	method peligrosidad() = if(tieneMisiles)  100 else 0

	method bultos() = if(tieneMisiles)  2 else 1

	method serImpactado(){
		self.descargarMisiles()
	}
}

object residuosRadiactivos{
	var property peso = 0

	method peligrosidad() = 200

	method bultos() = 1

	method serImpactado(){
		peso += 15
	}
}

//Se podría resovler con un booleano
object auto{
	const property siguiente = robot
	
	method peligrosidad() = 15
}

//Se podría resovler con un booleano
object robot{
	const property siguiente = auto

	method peligrosidad() = 30
}

object contenedor{
	const cosas = #{}
	const pesoBase = 100
	const bultosBase = 1

	method almacenar(cosa){
		cosas.add(cosa)
	}

	method peso() = pesoBase + self.pesoCosas()

	method pesoCosas() = cosas.sum({ cosa => cosa.peso() })

	method peligrosidad()= if(self.estaVacio()) 0 else self.cosaMasPeligrosa().peligrosidad()
	
	method estaVacio() = cosas.isEmpty()

	method cosaMasPeligrosa() = cosas.max({ cosa => cosa.peligrosidad() })

	method serImpactado(){
		cosas.forEach({ cosa => cosa.serImpactado()})
	}

	method bultos() = bultosBase + self.bultosCosas()

	method bultosCosas() = cosas.sum({ cosa => cosa.bultos() })

	method vaciar(){
		cosas.clear()
	}
}

  object embalaje{
	var cosaEnvuelta = null

	method embalar(cosa){
		cosaEnvuelta = cosa
	}

	method peso() = cosaEnvuelta.peso()  //si no embaló nada va a fallar

	method peligrosidad() = cosaEnvuelta.peligrosidad() / 2 //si no embaló nada va a fallar

	method bultos() = 2

	method serImpactado(){
		//TAMPOCO HACE NADA
	}
  }
  
