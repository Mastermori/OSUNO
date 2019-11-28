extends Control


func _on_HostButton_pressed():
	var nick = $"Inputs/NickInput".text
	if nick != "":
		Network.host(Player.new(nick, $"Inputs/ColorPicker".color), 6000, 2)
		get_tree().change_scene("res://levels/Lobby.tscn")
	else:
		$InfoLabel.show_info("Please enter a nickname")


func _on_ConnectButton_pressed():
	Network.join(Player.new($"Inputs/NickInput".text, $"Inputs/ColorPicker".color), $"Inputs/IPInput".text, 6000)
	get_tree().change_scene("res://levels/Lobby.tscn")
