extends Area3D

@onready var train_controller: MeshInstance3D = $MeshInstance3D

var MAX_HEALTH = 20
var ATTACK_DAMAGE = 1
var MOVE_SPEED = 10

var cart_cost: int = 20

var current_health: float

func _init():
	current_health = MAX_HEALTH

func _process(delta):
	if Globals.currency != 0 and Globals.currency % 20 == 0:
		Globals.currency -= cart_cost
		train_controller.spawn_cart()

func hit(hit_damage):
	var alive = damage(hit_damage)
	
	if !alive:
		get_tree().change_scene_to_file.call_deferred("res://scenes/game.tscn")

	Globals.player_health = current_health

func damage(amount):
	current_health -= amount

	if current_health <= 0:
		return false
	return true

func heal(amount):
	current_health += amount
