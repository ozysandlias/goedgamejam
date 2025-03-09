extends RigidBody3D

@onready var hit_box: Area3D = $Area3D

var damage: float
var speed: float

func _ready():
	freeze = true
	hit_box.area_entered.connect(_on_area_entered)

func initialize(attack_damage, move_speed):
	damage = attack_damage
	speed = move_speed

func _physics_process(delta: float):
	self.global_position = self.global_position.move_toward(Globals.train_engine.global_position, speed * delta)
	
	if self.global_position.distance_to(Globals.train_engine.global_position) < 0.5:
		self.queue_free()

func _on_area_entered(area):
	if area.is_in_group("engine"):
		area.hit(damage)
