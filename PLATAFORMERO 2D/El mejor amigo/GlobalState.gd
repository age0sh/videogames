extends Node

# Señal que avisará al HUD cuando las monedas cambien
signal coins_updated

var coins = 0

# Función para añadir una moneda y avisar del cambio
func add_coin():
	coins += 1
	emit_signal("coins_updated", coins)

# Función para reiniciar el contador (útil para un nuevo juego)
func reset():
	coins = 0
	emit_signal("coins_updated", coins)
