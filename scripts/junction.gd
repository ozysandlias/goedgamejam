extends Area3D
@export var track_1: Path3D
@export var track_2: Path3D
@export var texture_1: Material
@export var texture_2: Material
@onready var selected_track: Path3D = track_1
@onready var model: MeshInstance3D = $Switch/MeshInstance3D

func swap():
	if selected_track == track_1:
		selected_track = track_2
		model.set_surface_override_material(0, texture_2)
	else:
		selected_track = track_1
		model.set_surface_override_material(0, texture_1)

func _on_area_entered(area:Area3D) -> void:
	if area.is_in_group("cart_collider"):
		var rail_guide = area.get_parent()
		if rail_guide.current_track != selected_track:
			rail_guide.switch_track(selected_track)
