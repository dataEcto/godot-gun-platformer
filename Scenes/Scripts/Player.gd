extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

# Within the Tutorial I'm watching,
# He does not use Static Typing. I'm trying to do so
# Just to get the hang of it.
const GRAVITY: int = 1000
const SPEED: float = 300

enum PlayerState { Idle, Run }

var currentState: PlayerState

func _ready():
	currentState = PlayerState.Idle

# we use _physics_process over process 
# Since we are using physics every frame.
func _physics_process(delta):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	
	move_and_slide()
	
	player_animation()

func player_falling(delta):
	# is_on_floor() is a method specific to CharacterBody2D
	if !(is_on_floor()):
		velocity.y = GRAVITY * delta

func player_idle(delta):
	if is_on_floor():
		currentState = PlayerState.Idle

func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		# This is what stops the player
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# If we are running aka direction has a value other than 0
		# We play the run animation
	if direction != 0:
		currentState = PlayerState.Run
		# The below is a Ternary Statement!
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_animation():
	# Probaby going to be a lot of if statements...
	# But I bet this will be fixed up within the State Machine Tutorial
	if currentState == PlayerState.Idle:
	
		animated_sprite_2d.play("idle")
	elif currentState == PlayerState.Run:

		animated_sprite_2d.play("run")
