extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_zona_mortal_body_entered(body):
	# Es una buena práctica usar grupos o class_name para identificar al jugador.
	# Si tu nodo de jugador se llama "Jugador", esto funciona.
	if body.name == "Jugador":
		print("GAME OVER")
		# Esto recarga la escena actual. Es la forma más simple de reiniciar.
		get_tree().reload_current_scene()
