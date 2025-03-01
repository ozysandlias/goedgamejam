extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var model = $MeshInstance3D
@export var material: Material

# Camera Variables
@onready var spring_arm = $SpringArm3D
var mouse_sensitivity = .3

func _ready() -> void:
	var track_nodes = get_tree().get_nodes_in_group("tracks")
	for node in track_nodes:
		node.connect("on_track", handle_on_track)
	#var track_node = get_parent().get_node("Track")
	#track_node.on_track.connect(handle_on_track)

func handle_on_track(track_direction):
	print(track_direction)
	velocity = track_direction * SPEED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		var look_direction = Vector2(velocity.z, velocity.x)
		model.rotation.y = lerp_angle(model.rotation.y, look_direction.angle(), .3)
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)




	move_and_slide()



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		spring_arm.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -90.0, 30.0)
	
		spring_arm.rotation_degrees.y -= event.relative.x * mouse_sensitivity
		spring_arm.rotation_degrees.y = wrapf(spring_arm.rotation_degrees.y, 0.0, 360.0)	
