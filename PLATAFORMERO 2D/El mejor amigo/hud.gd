extends CanvasLayer

@onready var coin_label = $MarginContainer/Label

func _ready():
	# Conecta la señal
	GlobalState.connect("coins_updated", _on_coins_updated)
	# Llama a la función de actualización al inicio
	update_text(GlobalState.coins)

func _on_coins_updated(new_coin_count):
	# Cuando se recibe la señal, llama a la función de actualización
	update_text(new_coin_count)

# --- FUNCIÓN DE DIAGNÓSTICO ---
func update_text(count):
	print("--- Iniciando actualización del HUD ---")
	
	# Comprobamos si la variable coin_label apunta a un nodo válido
	if is_instance_valid(coin_label):
		print("1. El nodo Label es VÁLIDO.")
		print("2. El texto ANTES de actualizar era: '", coin_label.text, "'")
		print("3. La visibilidad ANTES de actualizar era: ", coin_label.visible)
		
		# La línea que actualiza el texto
		coin_label.text = "x " + str(count)
		
		print("4. El texto DESPUÉS de actualizar es: '", coin_label.text, "'")
		print("5. La visibilidad DESPUÉS de actualizar es: ", coin_label.visible)
		print("--- Fin de la actualización ---")
	else:
		print("¡ERROR FATAL! La variable coin_label NO es válida al intentar actualizar.")
