extends Node3D

var new_cart = preload("res://scenes/Cart.tscn")
var timer: float = 0.0

func _ready():
	Globals.train_engine = get_parent()
	Globals.train_end = get_parent()

func _process(delta):
	pass

func spawn_cart():
	var cart_instance = new_cart.instantiate()
	var last_cart = Globals.train_end
	last_cart.get_parent().add_child(cart_instance)
	cart_instance.progress_ratio = last_cart.progress_ratio - 0.05 if last_cart.progress_ratio - 0.05 >= 0 else 1 + (last_cart.progress_ratio - 0.05)
	Globals.set_train_end(cart_instance)