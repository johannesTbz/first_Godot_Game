extends CharacterBody2D


const SPEED =130.0
const JUMP_VELOCITY = -300.0

# get gravity from the project settings to be synced with RigidBody nodes. DETTA HAR JAG LAGT TILL EFTERSOM DET VAR I VIDEON
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# ändrat efter videons kod
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#get input direction -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	#flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction <0:
		animated_sprite.flip_h = true
		
	#play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
			
	if velocity.y == JUMP_VELOCITY:
		animated_sprite.play("jump")
		
	if velocity.y >0:
		animated_sprite.play("fall")
		
	
	#apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
