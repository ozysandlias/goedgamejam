extends Area3D

var damage: float = 10

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area):
	if area.is_in_group("engine"):
		area.hit(damage)