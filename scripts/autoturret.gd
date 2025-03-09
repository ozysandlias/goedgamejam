extends Area3D

var shoot_speed: float = 1
var shoot_damage: float = 1

var target: Node3D = null
var target_distance: float = INF
var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = shoot_speed
	timer.one_shot = false
	timer.timeout.connect(_on_timeout)
	timer.start()

func _process(delta):
	if target == null:
		var possible_targets = get_tree().get_nodes_in_group("destructibles")

		for pt in possible_targets:
			var dist = self.global_position.distance_to(pt.global_position)
			
			if target_distance == null or dist < target_distance:
				target_distance = dist
				target = pt

func _on_timeout():
	if target != null:
		target.hit(shoot_damage)
