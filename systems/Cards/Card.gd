extends Node2D

class_name Card

var types : Array
var color : Color

func init(types : Array, color : Color):
	self.types = types
	self.color = color
	$Background.color = color
