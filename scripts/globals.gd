extends Node

# Game States
var enemy_spawn_speed: float = 1

# Player Stats
var player_health: float = 100
var currency: int = 0

# Preloading cart prefab for later instantiations
# TODO: preload all types of carts
var new_cart = preload("res://scenes/Cart.tscn")

var golem_enemy = preload("res://scenes/enemy.tscn")

# train_engine is the beginning of the train, this should not change during the game except for the startup
var train_engine: PathFollow3D = null

# train_end is the last cart on the train, if there is no cart it will be the engine
var train_end: PathFollow3D = null

# Specifies what track the train should change to next
var next_track: Path3D = null

# Setter for next_track
func set_next_track(track):
	next_track = track

# Setter for train_end
func set_train_end(cart):
	train_end = cart
