extends Area2D

func _on_body_entered(body):
	# Comprueba si es el jugador
	if body.is_in_group("player"):
		# Cambia a la escena de créditos que vamos a crear ahora
		get_tree().change_scene_to_file("res://creditos.tscn")
