extends Node2D

func _ready():
	$Players/Player.queue_free()
	var node = load("res://systems/Player.tscn").instance()
	$Players/Bottom.add_child(Network.player)
	$Players/Top.add_child(Network.players[Network.players.keys()[1]])
