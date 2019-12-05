extends Control

class_name Lobby

onready var playerList = $PlayerList

func _ready():
	assert(Network.player)
	
	if Network.is_hosting():
		$StartButton.disabled = false
	
	_add_player(Network.player)

func refresh(players : Dictionary):
	playerList.clear()
	for p in players:
		_add_player(players[p])

func _add_player(player : Player):
	playerList.add_item(player.nick, null, false)
	playerList.set_item_custom_fg_color(playerList.items.size()/3-1, player.color)


func _on_LeaveButton_pressed():
	var conn = load("res://levels/Connector.tscn").instance()
	conn.get_node("InfoPopup").show_info("You disconnected!")
	Global.change_scene(conn)


func _on_StartButton_pressed():
	Network.start_game()
