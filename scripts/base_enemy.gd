extends CharacterBody3D

@export var material: Material

@onready var guide: Node3D = get_tree().root.get_node("Game/EnemyTarget")
@onready var aggro_box: Area3D = $Area3D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_health: float
var current_health: float
var attack_damage: float
var move_speed: float 
var resource_value: int
var chase_distance: float
var bullet: PackedScene

var target: Area3D = null
var chase: bool = false

func _init(health, damage, speed, worth, dist):
	max_health = health
	current_health = health
	attack_damage = damage
	move_speed = speed
	resource_value = worth
	chase_distance = dist

func _ready():
	set_physics_process(false)
	start_idle_anim(animation_player)

func _physics_process(delta):
	if self.global_position.distance_to(target.global_position) < chase_distance:
		var my_pos = global_transform
		get_parent().remove_child(self)
		guide.add_child(self)
		global_transform = my_pos
		chase = false
		set_physics_process(false)

	elif chase == true:
		self.velocity = global_position.direction_to(target.global_position) * move_speed
		self.move_and_slide()

func hit(hit_damage):
	animation_player.play("damage")
	var alive = damage(hit_damage)

	if !alive:
		Globals.currency += resource_value
		self.queue_free()

func start_idle_anim(animation_player):
	animation_player.play("idle")
	var start_time  = randi_range(0, animation_player.current_animation_length)
	animation_player.seek(start_time)

func _on_area_3d_area_entered(area):
	if area.is_in_group("engine"):
		set_physics_process(true)
		target = area
		chase = true
		look_at(target.global_position)
		aggro_box.queue_free()
		timer.start()

func damage(amount):
	current_health -= amount

	if current_health <= 0:
		return false
	return true

func heal(amount):
	current_health += amount
