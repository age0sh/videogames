extends CanvasLayer

@onready var etiqueta_monedas = $Label

func _ready():
	# Conecta el HUD a la señal del script global
	JuegoEstado.monedas_actualizadas.connect(actualizar_texto_monedas)
	# Actualiza el texto inicial
	actualizar_texto_monedas(JuegoEstado.monedas)

func actualizar_texto_monedas(cantidad):
	etiqueta_monedas.text = "Monedas: " + str(cantidad)
