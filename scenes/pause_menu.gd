extends Node2D

@onready var crosshair: Label = get_parent().get_node("Crosshair")

func _process(_delta) -> void:
	if get_tree().paused == true:
			show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			crosshair.hide()

func _on_close_buton_pressed() -> void:
	hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	crosshair.show()

