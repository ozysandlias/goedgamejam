extends PathFollow3D

var speed := 5

var current_track: Path3D = null
var current_cross: PathFollow3D = null
var next_track: Path3D = null
var follow_cart: PathFollow3D = null
@onready var area: Area3D = $Area3D
func _ready():
	# Gets starting track when game starts
	current_track = get_parent()

func _physics_process(delta):
	if area.top_level == false:
		progress += speed * delta
	elif area.global_position.distance_to(global_position) == 0: 
		area.top_level = false
		area.global_transform = global_transform
	else:
		area.global_position = area.global_position.move_toward(global_position, speed * delta)
		area.global_basis = lerp(area.global_basis.orthonormalized(), global_basis.orthonormalized(), 0.08)


# Switches the cart/area to a new track
func switch_track(new_track, new_cross):
	if new_track != null and new_cross != null:
		current_track = new_track
		current_cross = new_cross	
		#save the carts position and set it top level so it doesn't snap
		var cart_pos = area.global_transform

		
		#Remove from old track and place under new track
		get_parent().remove_child(self)
		area.top_level = true
		current_track.add_child(self)
		area.global_transform = cart_pos

		#Loop track until new on specified
		progress_ratio = new_cross.progress_ratio
		loop = true
