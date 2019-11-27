# Typical lobby implementation; imagine this being in /root/lobby.

extends Node

# Connect all functions

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

# Player info, associate ID to data
var players = {}
# Info we send to other players
var player : Player = Player.new("Mastermori", Color.red)

func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_player", player)

func _player_disconnected(id):
	players.erase(id) # Erase player from info.

func _connected_to_server():
	pass # Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	pass # Server kicked us; show error and abort.

func _connected_fail():
	pass # Could not even connect to server; abort.

remote func register_player(info):
	# Get the id of the RPC sender.
	var id = get_tree().get_rpc_sender_id()
	# Store the info
	players[id] = info
	# Call function to update lobby UI here

remote func configure_game():
	get_tree().set_pause(true)
	rpc_id(1, "done_config", get_tree().get_network_unique_id())
