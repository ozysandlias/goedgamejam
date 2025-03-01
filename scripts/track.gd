extends Area3D

signal on_track(track_direction)
@onready var player = get_parent().get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("tracks")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body:Node3D) -> void:
	if body == player:
		emit_signal("on_track", -basis.z)
