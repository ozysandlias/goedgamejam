extends Node3D

@onready var enemy_node: Node = get_tree().root.get_node("Game/Enemies")

var height_above_player: float = 5
var dist_from_player: float = 20

var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = Globals.enemy_spawn_speed
	timer.one_shot = false
	timer.timeout.connect(_on_timeout)
	timer.start()

func _on_timeout():
	var enemy = Globals.golem_enemy.instantiate()
	enemy_node.add_child(enemy)
	enemy.global_position = choose_random_position()

func choose_random_position():
	var angle = randf() * 2 * PI
	var random_radius = randf_range(0, dist_from_player)

	var x = cos(angle) * random_radius
	var z = sin(angle) * random_radius
	var y = height_above_player + randf_range(0, dist_from_player)

	var random_offset = Vector3(x, y, z)
	return global_transform.origin + random_offset