extends PathFollow3D

var current_track: Path3D = null

func _ready():
	current_track = get_parent()

func _physics_process(delta):
	progress += 10 * delta

	if Globals.next_track != null and current_track != Globals.next_track:
		loop = false

		if progress_ratio >= 1:
			switch_track(Globals.next_track)

func switch_track(new_track):
	get_parent().remove_child(self)
	new_track.add_child(self)
	progress_ratio = 0
	loop = true
	current_track = Globals.next_track
