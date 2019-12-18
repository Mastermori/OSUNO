extends Node2D

class_name Card

signal card_clicked(card)

var types : Array
var color : Color

var inHand : bool

onready var background = $Background
onready var tween = $Tween

func init(types : Array, color : Color):
	self.types = types
	self.color = color
	background.color = color

func move_to(pos : Vector2):
	tween.interpolate_property(self, "position", position, pos, .6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func _on_Background_gui_input(event): #TODO: replace with Area2D (with MOUSE_FILTER_IGNORE)
	if inHand and event.is_action_pressed("game_click"):
		emit_signal("card_clicked")

func _on_Highlight_gui_input(event): #TODO: replace with Area2D (with MOUSE_FILTER_IGNORE)
	_on_Background_gui_input(event)
