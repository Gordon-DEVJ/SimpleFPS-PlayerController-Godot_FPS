extends CharacterBody3D

#===============================================================================
# Movement insipired in Half Life games ( VALVE )
#===============================================================================

# Walk and Speed variables
var SPEED = BASE_SPEED					# Movement Speed
var DIRECTION = Vector3.ZERO			# Direction
const LERP_SPEED = 10.0					# Adjust this value to control the smoothness transitions.
@export var BASE_SPEED = 5.0			# Default = 5		The default movement speed, used when not in the "walk" mode.
@export var WALK_SPEED = 2.5			# Default = 2.5		The speed of movement when walking, used when in "walk" mode.
@export var CROUCH_SPEED = 2.0			# Default = 2

#Jump variables
var JUMPS_REMAINING = 1					# For Double Jump
@export var JUMP_VELOCITY = 4.5			# Default = 4.5

# Crouch Variables 
var crouch_depth = -0.5
@onready var raycast = $RayCast3D
@onready var std_collision = $std_collision
@onready var crh_collision = $crh_collision

# Camera look and mouse variables
var mouse_input : bool = false 			# Check mouse movement
var rotation_input : float				# Rotation in X
var tilt_input : float					# Rotation in Y
	# Rotation Variables
var mouse_rotation : Vector3
var player_rotation : Vector3
var camera_rotation : Vector3
	# Export Variables
@export var MOUSE_SENSITIVITY = 0.5					# Mouse sensitivity
@export var TILT_UPPER_LIMIT = deg_to_rad(90)		# Upper tilt limit
@export var TILT_LOWER_LIMIT = deg_to_rad(-90.0)	# Lower tilt limit
@export var CAMERA_CONTROLLER = Camera3D			# Assigned camera

# Gravity for physics
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#===============================================================================

func _unhandled_input(event):

	# If both conditions are met, which means that the input event is a mouse movement and the mouse mode is captured.
	mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	
	if mouse_input:
		rotation_input = -event.relative.x * MOUSE_SENSITIVITY		# Rotation in X
		tilt_input = -event.relative.y * MOUSE_SENSITIVITY			# Rotation in Y

func _input(event):

	# Exit Option
	if event.is_action_pressed("exit"):
		get_tree().quit()

func _update_camera(delta):

	# Rotate Camera using euler rotation
	mouse_rotation.x += tilt_input*delta
	mouse_rotation.x = clamp(mouse_rotation.x,TILT_LOWER_LIMIT,TILT_UPPER_LIMIT)
	mouse_rotation.y += rotation_input*delta

	# Player Rotation
	player_rotation = Vector3(0.0, mouse_rotation.y, 0.0)
	camera_rotation = Vector3(mouse_rotation.x, 0.0, 0.0)

	# Camera Transform
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(camera_rotation)
	global_transform.basis = Basis.from_euler(player_rotation)

	CAMERA_CONTROLLER.rotation.z = 0.0

	# Restart input of rotation and tilt
	rotation_input = 0.0
	tilt_input = 0.0

func _ready():

	# Get mouse input mode
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _walk():

	# Handle Walk mode
	if Input.is_action_pressed("walk") and is_on_floor():
		SPEED = WALK_SPEED
	else:
		SPEED = BASE_SPEED

func _jump():

# Handle Double Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or JUMPS_REMAINING > 0):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY * 0.8
			JUMPS_REMAINING -= 1
	if is_on_floor():
		JUMPS_REMAINING = 0			# Set in 0 for disable double jump

func _crouch(delta): 

# Handle crouch
	if is_on_floor():
		if Input.is_action_pressed("crouch") or raycast.is_colliding():
			SPEED=CROUCH_SPEED
			CAMERA_CONTROLLER.position.y = lerp(CAMERA_CONTROLLER.position.y,1.8 + crouch_depth,delta*LERP_SPEED)
			std_collision.disabled=true
			crh_collision.disabled=false
		else:
			CAMERA_CONTROLLER.position.y=lerp(CAMERA_CONTROLLER.position.y,1.8,delta*LERP_SPEED)
			std_collision.disabled=false
			crh_collision.disabled=true

func _physics_process(delta):
	
	# Camera update
	_update_camera(delta)

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	_walk()					# Walk Function
	_crouch(delta)			# Crouch function
	_jump() 				# Jump function

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	# Get the directional input from the user (left, right, forward, backward)
	var input_dir = Input.get_vector("left", "right", "forward", "backward")

	# Transform the input direction into the local space of the node (ignoring the y-axis)
	DIRECTION = lerp(DIRECTION,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*LERP_SPEED)

	# Movement Basic
	if DIRECTION:
		velocity.x = DIRECTION.x * SPEED
		velocity.z = DIRECTION.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

#===============================================================================
# Developed by Gordon-DevJ.
# Credits to StayAtHomeDev and Lucky-nl for inspiration and contributions to this code.
# Version 1.0.0
#===============================================================================
