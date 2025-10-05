extends Control

# Esta función se ejecuta automáticamente cuando el Timer termina.
func _on_timer_timeout():
	# Cambia la escena de vuelta al menú principal
	get_tree().change_scene_to_file("res://menu_principal.tscn")
