extends StaticBody3D

var speed := 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position = position.move_toward(Vector3.ZERO, speed * delta)
	if position == Vector3.ZERO:
		queue_free()