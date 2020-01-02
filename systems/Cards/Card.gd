extends Node2D

class_name Card

signal card_clicked(card)

var types : Array
var color : Color

var inHand : bool

onready var background = $Background
onready var tween = $Tween
onready var discard = $"../..".discard
onready var cardSize = $"../..".cardSize

func init(types : Array, color : Color):
	self.types = types
	self.color = color
	background.color = color

func move_to(pos : Vector2):
	var rot = (randi() % 4) * 20 - 30
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rot, .6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(self, "position", position, pos, .6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func _on_Background_gui_input(event): #TODO: replace with Area2D (with MOUSE_FILTER_IGNORE)
	if inHand and event.is_action_pressed("game_click"):
		emit_signal("card_clicked")

func _on_Highlight_gui_input(event): #TODO: replace with Area2D (with MOUSE_FILTER_IGNORE)
	_on_Background_gui_input(event)

func _on_Tween_tween_completed(object, key):
	$"../../".draw_cards(1)
	get_parent().remove_child(self)
	position = Vector2(0,0)   #Vector2((randi() % 5) * 0, (randi() % 5) * 1) - cardSize/2
	discard.add_child(self)
	#TODO: Remove this debug helper
	
