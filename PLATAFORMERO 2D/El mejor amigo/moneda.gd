extends Area2D

func _on_body_entered(body):
	# Si el que entra es el jugador
	if body.is_in_group("player"):
		# Llama a la función en nuestro script global
		GlobalState.add_coin()
		# Desaparece
		queue_free()
