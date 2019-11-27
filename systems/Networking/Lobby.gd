extends Control

class_name Lobby

onready var playerList = $PlayerList

func _ready():
	assert(Network.player)
	
	add_player(Network.player)

func refresh(players : Dictionary):
	playerList.clear()
	for p in players:
		add_player(players[p])

func add_player(player : Player):
	playerList.add_item(player.nick, null, false)
	playerList.set_item_custom_fg_color(playerList.items.size()/3-1, player.color)


func _on_LeaveButton_pressed():
	get_tree().change_scene("res://levels/Connector.tscn")
