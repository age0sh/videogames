extends CharacterBody2D

# --- Variables de Comportamiento ---
@export var speed = 50.0
@export var direction = -1 # -1 para izquierda, 1 para derecha

# --- Referencias a Nodos ---
@onready var animated_sprite = $AnimatedSprite2D
@onready var ledge_detector = $LedgeDetector # El "sensor" para no caerse

# Obtenemos la gravedad desde la configuración del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# --- GRAVEDAD ---
	# Aplica gravedad si el enemigo no está en el suelo.
	if not is_on_floor():
		velocity.y += gravity * delta

	# --- LÓGICA DE GIRO (La parte nueva) ---
	# Primero, revisamos si el enemigo debe darse la vuelta.
	if is_on_floor():
		# Condición 1: Si el sensor de delante no detecta suelo.
		if not ledge_detector.is_colliding():
			direction *= -1 # Invierte la dirección

		# Condición 2: Si choca contra una pared.
		if get_slide_collision_count() > 0:
			if get_slide_collision(0).get_normal().x != 0:
				direction *= -1 # Invierte la dirección

	# --- ACTUALIZAR DIRECCIÓN VISUAL ---
	# Mueve el sensor y voltea el sprite según la dirección.
	if direction > 0: # Yendo a la derecha
		animated_sprite.flip_h = false
		ledge_detector.position.x = abs(ledge_detector.position.x)
	else: # Yendo a la izquierda
		animated_sprite.flip_h = true
		ledge_detector.position.x = -abs(ledge_detector.position.x)

	# --- APLICAR MOVIMIENTO ---
	velocity.x = speed * direction
	move_and_slide()
	
	# Reproducir la animación de caminar
	animated_sprite.play("walk")


# --- SEÑAL DE DAÑO AL JUGADOR ---
# Esta función se ejecuta cuando el cuerpo del jugador entra en el área de daño del enemigo.
func _on_damage_box_body_entered(body):
	# Comprueba si el cuerpo que entró pertenece al grupo "player".
	if body.is_in_group("player"):
		# Si es el jugador, reinicia el nivel.
		print("¡Jugador dañado por el enemigo!")
		get_tree().reload_current_scene()
