extends Node

class_name Player

var nick : String
var color : Color

func init(nick : String, color : Color):
	self.nick = nick
	self.color = color
	$ColorRect.color = color
	return self

func to_dict():
	return {nick = nick, color = color.to_html()}
