extends Node3D

@export var tracks: Array[Path3D] = []
var queued_track_index: int = 0

func _process(delta):
	if self.get_parent() == Globals.train_engine.get_parent():
		Globals.set_next_track(tracks[queued_track_index])

func switch_route():
	queued_track_index = (queued_track_index + 1) % tracks.size()