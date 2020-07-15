extends KinematicBody2D
class_name Player 
onready var sprite = $Position2D/gatomansprite256

const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0

const JUMP = -700  
const WALK_SPEED = 250 # pixels/sec
const JUMP_SPEED = 480
const JUMP_VELOCITY = 460
const STOP_JUMP_FORCE = 900.0

const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000
const SHOOT_TIME_SHOW_WEAPON = 0.2

const WALK_ACCEL = 100.0
const WALK_DEACCEL = 800.0
const WALK_MAX_VELOCITY = 200.0
const AIR_ACCEL = 200.0
const AIR_DEACCEL = 200.0


const ACCELERATION = 50
const MAX_SPEED = 100
const GRAVITY = 20
  

var anim = ""
var siding_left = false
var jumping = false  #estado de salto
var stopping_jump = false #parar salto
var shooting = false

var floor_h_velocity = 0.0


var motion = Vector2()
var is_jumping = false
var coyote_time    
var linear_vel = Vector2()




func _ready():
	coyote_time = Timer.new()
	coyote_time.one_shot = true
	coyote_time.wait_time = 1.0
	add_child(coyote_time)



# Increment counters
func _physics_process(delta):
	
	var on_floor = is_on_floor()
	### MOVEMENT ###

	# Apply gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect if we are on floor - only works if called *after* move_and_slide
	
	
	#if Input.is_action_pressed("ui_right"):
	#	motion.x = min(motion.x+ACCELERATION,  MAX_SPEED)
	#elif Input.is_action_pressed("ui_left"):
	#	motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
	#else:
	#	motion.x = 0
	
	
	var target_speed = 0
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		
		target_speed -= 1
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION,  MAX_SPEED)
		target_speed += 1
		
	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

	# Saltar
	if on_floor and Input.is_action_just_pressed("jump"):
		linear_vel.y = -JUMP_SPEED
		

	if coyote_time.is_stopped():
		motion.y += GRAVITY

	if is_on_floor():
		is_jumping = false
		if Input.is_action_just_pressed("ui_up"):
			is_jumping = true
			motion.y = JUMP




	var was_on_floor = is_on_floor()
	motion = move_and_slide(motion, Vector2.UP)
	if not is_on_floor() and was_on_floor and not is_jumping:
		coyote_time.start()
		motion.y = 0
		
		
		
	var new_anim = "gatoman"

	if on_floor:
		if linear_vel.x < -SIDING_CHANGE_SPEED:
			sprite.scale.x = -0.5
			new_anim = "gatocaminando"

		if linear_vel.x > SIDING_CHANGE_SPEED:
			sprite.scale.x = 0.5
			new_anim = "gatocaminando"
	else:
		# We want the character to immediately change facing side when the player
		# tries to change direction, during air control.
		# This allows for example the player to shoot quickly left then right.
		if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			sprite.scale.x = -1
		if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			sprite.scale.x = 1

		if linear_vel.y < 0:
			new_anim = "Salta"
		else:
			new_anim = "Salta"


	if new_anim != anim:
		anim = new_anim
		($Position2D/gatomansprite256/animacion as AnimationPlayer).play(anim)

		
		
