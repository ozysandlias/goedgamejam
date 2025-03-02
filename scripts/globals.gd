extends Node

var train_engine: PathFollow3D = null
var train_end: PathFollow3D = null
var next_track: Node3D = null

func set_next_track(track):
	next_track = track

func set_train_end(cart):
	train_end = cart