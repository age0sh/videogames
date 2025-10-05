extends Node

signal monedas_actualizadas(cantidad_monedas)

var monedas: int = 0:
	set(valor):
		monedas = valor
		monedas_actualizadas.emit(monedas)

func reiniciar():
	self.monedas = 0
