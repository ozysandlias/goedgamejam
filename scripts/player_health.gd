extends Node

var health_script = preload("res://scripts/health.gd")
var Health = health_script.new()

func _ready():
	connect("area_entered", _on_area_entered)
	Health.current_health = 20

func hit(damage):
	Health.damage(damage)
	Globals.player_health = Health.current_health

	if Health.current_health <= 0:
		print("Game Lost.")
		get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_area_entered(area):
	if area.is_in_group("EnemyBullet"):
		self.hit(area.damage)
