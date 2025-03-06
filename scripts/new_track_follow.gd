extends PathFollow3D

var speed: float = 5.0

var current_track: Path3D = null
var next_track: Path3D = null
var follow_cart: PathFollow3D = null
@onready var area: Area3D = $Area3D
@onready var crossover: PathFollow3D = get_parent().find_child("Crossover")

func _ready():
	# Gets starting track when game starts
	current_track = get_parent()
	progress_ratio = .6

func _physics_process(delta):
	if area.top_level == false:
		progress += speed * delta
	elif area.global_position.distance_to(global_position) == 0: 
		area.top_level = false
		area.global_transform = global_transform
	else:
		area.global_position = area.global_position.move_toward(global_position, speed * delta)
		area.global_basis = lerp(area.global_basis.orthonormalized(), global_basis.orthonormalized(), 0.05)


# Switches the cart/area to a new track
func switch_track(new_track):
	#save the engines position and set it top level so it doesn't snap
	var engine_pos = area.global_transform

	#Set cart/area's new track
	current_track = new_track

	#Remove from old track and place under new track
	get_parent().remove_child(self)
	area.top_level = true
	new_track.add_child(self)
	area.global_transform = engine_pos

	#Loop track until new on specified
	crossover = get_parent().find_child("Crossover")
	progress_ratio = crossover.progress_ratio
	loop = true


#func _process(delta):
	#pass
	#if self != Globals.train_engine:
		#next_track = follow_cart.current_track
	#else:
		#next_track = Globals.next_track
		
	## If we aren't on the new track
	#if next_track != null and current_track != next_track:
		## Don't want to loop again if changing tracks
		#loop = false

		## Waits until current track is done for a smooth transition to new track
		#if progress_ratio >= 1:
			#switch_track(next_track)
