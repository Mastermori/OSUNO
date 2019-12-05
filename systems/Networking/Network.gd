# Typical lobby implementation; imagine this being in /root/lobby.

extends Node

# Connect all functions

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	self.pause_mode = Node.PAUSE_MODE_PROCESS

# Player info, associate ID to data
var players = {}
var playersDone = {}
# Info we send to other players
var player : Player

func host(player : Player, port : int, max_players : int):
	self.player = player
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, max_players)
	get_tree().set_network_peer(peer)
	players[get_tree().get_network_unique_id()] = player

func join(player : Player, ip : String, port : int):
	self.player = player
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)
	players[get_tree().get_network_unique_id()] = player

func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_player", player.to_dict())

func _player_disconnected(id):
	players.erase(id) # Erase player from info.
	var lobby = $"/root/Lobby"
	if lobby:
		lobby.refresh(players)

func _connected_to_server():
	pass # Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	pass # Server kicked us; show error and abort.

func _connected_fail():
	pass # Could not even connect to server; abort.

remote func register_player(info : Dictionary):
	# Get the id of the RPC sender.
	var id = get_tree().get_rpc_sender_id()
	print(info)
	var player = Player.new(info.nick, Color(info.color))
	# Store the info
	players[id] = player
	# Call function to update lobby UI here
	var lobby = $"/root/Lobby"
	if lobby:
		lobby.refresh(players)

func start_game():
	if !is_hosting():
		return
	rpc("configure_game")

remotesync func configure_game():
	get_tree().set_pause(true)
	rpc_id(1, "done_config", get_tree().get_network_unique_id())

remote func post_configure_game():
	get_tree().set_pause(false)

remote func done_configure(who):
	assert(get_tree().is_network_server())
	assert(who in players)
	assert(not who in playersDone)
	
	playersDone.append(who)
	
	if playersDone.size() == players.size():
		rpc("post_configure_game")


func is_hosting() -> bool:
	return get_tree().get_network_unique_id() == 1
