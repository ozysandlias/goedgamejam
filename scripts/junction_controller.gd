extends Node3D

@export var tracks: Array[Path3D] = []
@export var on_skin: Material
@export var off_skin: Material
var queued_track_index: int = 0
@onready var model: MeshInstance3D = $MeshInstance3D

func _process(delta):
	if self.get_parent() == Globals.train_engine.get_parent():
		Globals.set_next_track(tracks[queued_track_index])

func switch_route():
	queued_track_index = (queued_track_index + 1) % tracks.size()
	if queued_track_index != 0:
		model.set_surface_override_material(0, on_skin)
	else:
		model.set_surface_override_material(0, off_skin)
