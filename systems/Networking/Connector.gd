extends Control


func _on_HostButton_pressed():
	$"/root/Global".change_scene(load('res://levels/MainMenu.tscn').instance())
