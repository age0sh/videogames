extends Area2D
signal hit

@export var speed = 400 
var screen_size 

var shield_active: bool = false
var shield_timer: Timer

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
	shield_timer = Timer.new()
	shield_timer.one_shot = true
	shield_timer.wait_time = 3.0 
	add_child(shield_timer)
	shield_timer.timeout.connect(_on_shield_timeout)
	
	$Shield.hide()



func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	if Input.is_action_just_pressed("shield") and not shield_active:
		activate_shield()


func _on_body_entered(_body):
	if shield_active:
		return
	
	hide() 
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func activate_shield():
	shield_active = true
	$Shield.show()      
	shield_timer.start() 


func _on_shield_timeout():
	shield_active = false
	$Shield.hide()
