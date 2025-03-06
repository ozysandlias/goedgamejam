extends CharacterBody3D

@onready var model: MeshInstance3D = $MeshInstance3D
@export var material: Material
const SPEED = 5.0
const JUMP_VELOCITY = 4.5



func damage():
	model.set_surface_override_material(0, material)
