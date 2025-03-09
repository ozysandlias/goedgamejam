extends "res://scripts/base_enemy.gd"

var MAX_HEALTH = 4
var ATTACK_DAMAGE = 10
var MOVE_SPEED = 6
var RESOURCE_VALUE = 5
var CHASE_DISTANCE = 12
var BULLET_SPEED = 15

func _init():
	super._init(MAX_HEALTH, ATTACK_DAMAGE, MOVE_SPEED, RESOURCE_VALUE, CHASE_DISTANCE)

func _ready():
	super._ready()
	bullet = preload("res://scenes/bullet.tscn")

func _on_timer_timeout():
	if get_parent() == guide:
		var new_bullet = bullet.instantiate()
		new_bullet.initialize(attack_damage, BULLET_SPEED)
		get_parent().add_child(new_bullet)
		new_bullet.global_position = self.global_position
