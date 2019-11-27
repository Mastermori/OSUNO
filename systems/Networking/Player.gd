extends Node

class_name Player

var nick : String
var color : Color

func _init(nick : String, color : Color):
	self.nick = nick
	self.color = color

func to_dict():
	return {nick = nick, color = color.to_html()}
