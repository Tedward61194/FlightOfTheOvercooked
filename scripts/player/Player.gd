extends CharacterBody3D

# constants
const SPEED := 5.0

# config
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# ref
@onready var pick_up_position := $BodyMesh/Hand/PickUpPosition
@onready var hand_reach_ray := $BodyMesh/HandsReach
@onready var feet_reach_ray := $BodyMesh/FeetReach

# logic
var obj_in_hands : int = -1 # -1 is empty
var hand_looking_at

func _ready() -> void:
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta) -> void:
	process_movement(delta)

func _process(_delta):
	pass
	#check_hand_reach_ray()
	
func _input(_event):
	if Input.is_action_just_pressed("PickUp"):
		pass
		#pick_up_put_down()
	elif Input.is_action_pressed("Interact"):
		pass
		#start_interact()
	elif Input.is_action_just_released("Interact"):
		pass
		#end_interact()

func process_movement(delta) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
