# Este es el script del corazón (Area2D)

extends Area2D

func _on_body_entered(body):
	# Comprobamos si lo que entró es el jugador
	if body.is_in_group("player"):
		# Cambiamos a la escena de victoria
		# ¡RECUERDA CREAR ESTA ESCENA Y PONER LA RUTA CORRECTA!
		get_tree().change_scene_to_file("res://nivel_2.tscn")
		
		# Hacemos que el corazón desaparezca
		queue_free()
