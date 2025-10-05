extends CharacterBody2D

# --- Variables de Movimiento ---
@export var SPEED = 100.0
@export var JUMP_VELOCITY = -200.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# --- Referencias a Nodos Hijos ---
@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox_shape = $Hitbox/CollisionShape2D # Referencia al collision shape del hitbox

# --- Estado del Jugador ---
var is_attacking = false # Para saber si el jugador está atacando


func _physics_process(delta):
	# --- LÓGICA DE MOVIMIENTO ---
	# Solo permite que el jugador se mueva si no está en medio de un ataque.
	if not is_attacking:
		# Gravedad
		if not is_on_floor():
			velocity.y += gravity * delta

		# Salto
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Movimiento Horizontal
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		# Si está atacando, frena al personaje para que no se deslice.
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# --- INPUT DE ATAQUE ---
	# Comprueba si se presiona la tecla de ataque.
	if Input.is_action_just_pressed("attack") and not is_attacking and is_on_floor():
		attack()

	# Aplica el movimiento y las colisiones
	move_and_slide()
	
	# Actualiza la animación de movimiento solo si no está atacando.
	if not is_attacking:
		update_animation()


# --- FUNCIÓN DE ATAQUE ---
func attack():
	is_attacking = true
	animated_sprite.play("punch") # ¡Usa el nombre de tu animación de golpe!
	
	# Activa el hitbox para que pueda detectar enemigos.
	hitbox_shape.disabled = false
	
	# Espera a que la animación de golpe termine.
	await animated_sprite.animation_finished
	
	# Desactiva el hitbox de nuevo para que no siga golpeando.
	hitbox_shape.disabled = true
	
	is_attacking = false


# --- FUNCIÓN DE ANIMACIÓN ---
func update_animation():
	# Animación de salto
	if not is_on_floor():
		animated_sprite.play("jump")
	else:
		# Animación de caminar o estar quieto
		if velocity.x != 0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")

	# Voltear el sprite según la dirección
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0


# --- FUNCIÓN DE SEÑAL DEL HITBOX ---
# Esta función se ejecuta automáticamente cuando algo entra en el Area2D del Hitbox.
func _on_hitbox_body_entered(body):
	# Si el objeto que entró pertenece al grupo "enemigo"
	if body.is_in_group("enemigo"):
		print("¡Golpe conectado!")
		body.queue_free() # Elimina al enemigo
