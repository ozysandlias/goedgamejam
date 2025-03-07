extends Node3D

# Sensitivity of the mouse movement
var mouse_sensitivity := 0.1
# Rotation angles
var yaw := 0.0
var pitch := 0.0
var atk := 1
@onready var raycast: RayCast3D = $RayCast3D
@onready var train_controller: MeshInstance3D = get_parent().get_node("MeshInstance3D")
@onready var mount = get_parent().get_node("mount")
@onready var cannon = get_parent().get_node("cannon")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide the mouse cursor and capture it
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# This function is called when a mouse motion event occurs
func _input(event):
	if event is InputEventMouseMotion:
		# Update yaw and pitch based on mouse movement
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		
		# Clamp the pitch to prevent flipping
		pitch = clamp(pitch, -89, 89)
		yaw = wrapf(yaw, 0, 360)

		# Apply the rotation to the Node3D (the parent of the Camera3D)
		rotation_degrees.x = pitch
		rotation_degrees.y = yaw
		cannon.basis = Basis(-basis.x, basis.y, -basis.z) / 7
		mount.rotation.y = rotation.y

	#pause
	if event is InputEventKey and Input.is_action_just_pressed("pause"):
		get_tree().paused = true

	#spawn cart with jump -- need to change based on leveling system
	if event is InputEventKey and Input.is_action_just_pressed("jump"):
		train_controller.spawn_cart()

	#fire the main cannon
	if event is InputEventMouseButton and Input.is_action_just_pressed("shoot"):
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var target = raycast.get_collider()
			if target.is_in_group("destructibles"):
				target.hit(atk)
			elif target.name == "Switch":
				target.get_parent().swap()