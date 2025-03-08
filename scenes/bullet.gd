extends RigidBody3D

var speed := 4

func _physics_process(delta: float) -> void:
	position = position.move_toward(Vector3.ZERO, speed * delta)
	if position == Vector3.ZERO:
		queue_free()