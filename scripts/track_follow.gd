extends PathFollow3D

var speed: float = 5.0

var current_track: Path3D = null
var next_track: Path3D = null
var follow_cart: PathFollow3D = null

func _ready():
	# Gets starting track when game starts
	current_track = get_parent()

func _physics_process(delta):
	progress += speed * delta

func _process(delta):
	if self != Globals.train_engine:
		next_track = follow_cart.current_track
	else:
		next_track = Globals.next_track
		
	# If we aren't on the new track
	if next_track != null and current_track != next_track:
		# Don't want to loop again if changing tracks
		loop = false

		# Waits until current track is done for a smooth transition to new track
		if progress_ratio >= 1:
			switch_track(next_track)

# Switches the cart/engine to a new track
func switch_track(new_track):
	# Remove from old track and place under new track
	get_parent().remove_child(self)
	new_track.add_child(self)

	# Progress ratio = 0 so cart starts at beginning of new track
	progress_ratio = 0

	# Loop track until new one specified
	loop = true

	# Set cart/engine's new track
	current_track = new_track
