extends Area3D
@export var cross_1: PathFollow3D
@export var cross_2: PathFollow3D
@onready var track_1: Path3D = cross_1.get_parent()
@onready var track_2: Path3D = cross_2.get_parent()
@export var texture_1: Material
@export var texture_2: Material
@onready var selected_cross: PathFollow3D = cross_1
@onready var model: MeshInstance3D = $Switch/MeshInstance3D

func swap():
	if selected_cross == cross_1:
		selected_cross = cross_2
		model.set_surface_override_material(0, texture_2)
	else:
		selected_cross = cross_1
		model.set_surface_override_material(0, texture_1)

func _on_area_entered(area:Area3D) -> void:
	if area.is_in_group("cart_collider"):
		var rail_guide = area.get_parent()
		var selected_track = null
		if selected_cross != null:
			selected_track = selected_cross.get_parent()
		if rail_guide != Globals.train_engine:
			selected_track = rail_guide.follow_cart.current_track
			selected_cross = rail_guide.follow_cart.current_cross
		if rail_guide.current_track != selected_track:
			rail_guide.switch_track(selected_track, selected_cross)
