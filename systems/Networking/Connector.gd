extends Control


func _on_HostButton_pressed():
	Network.host(Player.new($"Inputs/NickInput".text, $"Inputs/ColorPicker".color), 6000, 2)
	get_tree().change_scene("res://levels/Lobby.tscn")


func _on_ConnectButton_pressed():
	Network.join(Player.new($"Inputs/NickInput".text, $"Inputs/ColorPicker".color), $"Inputs/IPInput".text, 6000)
	get_tree().change_scene("res://levels/Lobby.tscn")
