extends Node2D

func _process(_delta) -> void:
	if get_tree().paused == true:
			show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_close_buton_pressed() -> void:
	hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
