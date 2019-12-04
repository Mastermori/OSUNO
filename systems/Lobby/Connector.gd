extends Control


func _on_HostButton_pressed():
	_start_net(true)


func _on_ConnectButton_pressed():
	_start_net(false)

func _start_net(hosting : bool):
	var nick = $"Inputs/NickInput".text
	if nick != "":
		if hosting:
			Network.host(Player.new(nick, $"Inputs/ColorPicker".color), 6000, 2)
		else:
			Network.join(Player.new(nick, $"Inputs/ColorPicker".color), $"Inputs/IPInput".text, 6000)
		get_tree().change_scene("res://levels/Lobby.tscn")
	else:
		$InfoPopup.show_info("Please enter a nickname")
