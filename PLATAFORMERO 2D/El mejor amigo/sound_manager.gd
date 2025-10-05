extends Node

# Esta función cambia el volumen del bus "Master" (el audio principal del juego)
func set_master_volume(value_in_db):
	# AudioServer es el gestor principal de audio de Godot
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value_in_db)
