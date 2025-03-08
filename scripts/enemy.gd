extends CharacterBody3D

@onready var aggro_box: Area3D = $Area3D
@onready var timer: Timer = $Timer
@onready var bullet = preload("res://scenes/bullet.tscn")
@export var material: Material
const SPEED = 6.0
const JUMP_VELOCITY = 4.5
var target: Area3D = null
var chase := false
var worth: float = 5

var health_script = preload("res://scripts/health.gd")
var Health = health_script.new()

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var guide: Node3D = get_parent().get_parent().find_child("EnemyTarget")

func _ready() -> void:
	animation.play("float")
	var start_time = randi_range(0, animation.current_animation_length)
	animation.seek(start_time)
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if global_position.distance_to(target.global_position) <12 :
		var my_pos = global_transform
		get_parent().remove_child(self)
		guide.add_child(self)
		global_transform = my_pos
		chase = false
		set_physics_process(false)

	elif chase == true:
		velocity = global_position.direction_to(target.global_position)*SPEED
		move_and_slide()

func hit(damage):
	animation.play("damage")
	Health.damage(damage)

	if Health.current_health <= 0:
		Globals.currency += worth
		print(Globals.currency)
		self.queue_free()

func _on_area_3d_area_entered(area:Area3D) -> void:
	if area.is_in_group("engine"):
		set_physics_process(true)
		target = area
		chase = true
		look_at(target.global_position)
		aggro_box.queue_free()
		timer.start()

func _on_timer_timeout() -> void:
	if get_parent() == guide:
		var new_bullet = bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.global_position = global_position
