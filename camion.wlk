import cosas.*

object camion {
	const property carga = #{}
	const tara = 1000
	const pesoMaximo = 2500

	method descargar(){
		carga.clear()
	}

	method carga(){
		//"carga" es la misma colección, alguien externo podría alterarla!!!, 
		//copy es menos performanete (memoria lentitud) pero asegura que nadie altere su colección.
		return carga.copy() 
		//return carga 
	}
	method cargar(cosa) {
		self.validarCargar(cosa)
		carga.add(cosa)
	}

	method descargar(cosa) {
		self.validarDescargar(cosa)
		carga.remove(cosa)
	}

	method validarCargar(cosa){
		if(self.tieneCargada(cosa)) self.error("Ya tiene cargada la cosa!")
	}

	method validarDescargar(cosa){
		if(not self.tieneCargada(cosa)) self.error("Te juro que no tengo esa cosa!")
	}

	method tieneCargada(cosa) = carga.contains(cosa)

	method peso(){
		return tara + self.pesoCarga()
	}

	method pesoCarga(){
		return carga.sum({ cosa => cosa.peso()})
	}

	method todoPesoPar() = carga.all({ cosa => cosa.peso().even()}) //carga.all({ cosa => cosa.pesoPar()}) //method pesoPar() = self.peso().even()

	method tieneAlgoQuePesa(peso) = carga.any({ cosa => cosa.peso()  == peso })
	
	method excedidoDePeso() = self.peso() > pesoMaximo

	method elDePeligrosidad(nivel) = carga.find({ cosa => cosa.peligrosidad() == nivel }) // cosa => cosa.esPeligrosidad(nivel)

	method masPeligrosos(nivel) = carga.filter({ cosa => cosa.peligrosidad() > nivel })

	method masPeligrososQue(cosa) = self.masPeligrosos(cosa.peligrosidad())

	method puedeCircular(nivel) = not self.excedidoDePeso() and self.seguro(nivel)

	method seguro(nivel) = self.masPeligrosos(nivel).isEmpty() // not carga.any({ cosa => cosa.peligrosiada() > nivel}) 

	method tieneAlgoQuePesaEntre(min, max) = carga.any({ cosa => cosa.peso().between(min, max) })

	method masPesada() = carga.max({ cosa => cosa.peso() }) //Si está vacío va a fallar.

	method pesos() = carga.map({ cosa => cosa.peso() }).asSet() //No interes el orden ni repetidos, map siempre devuelve una lista.

	method totalBultos() = carga.sum({ cosa => cosa.bultos() })

	method sufrirAccidente(){
		carga.forEach({ cosa => cosa.serImpactado() })
	}
}
