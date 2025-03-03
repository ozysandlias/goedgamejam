extends Node3D

func _ready():
	# Setting train engine when game starts
	Globals.train_engine = get_parent()
	Globals.train_end = get_parent()

func _process(delta):
	pass

# Spawns in a new cart at the end of the train
# TODO: parameter to specify what type of cart is spawned in
func spawn_cart():
	var cart_instance = Globals.new_cart.instantiate()
	var last_cart = Globals.train_end

	# Add new cart to the track of the last cart on train
	last_cart.get_parent().add_child(cart_instance)

	# Space new cart out from the last cart
	cart_instance.progress_ratio = last_cart.progress_ratio - 0.05 if last_cart.progress_ratio - 0.05 >= 0 else 1 + (last_cart.progress_ratio - 0.05)
	cart_instance.follow_cart = last_cart

	# New cart is now the end of the train
	Globals.set_train_end(cart_instance)