extends PopupPanel

onready var timer = $Timer
onready var label = $InfoLabel

onready var ready = true

var text : String
var color : Color
var time : float

func _ready():
	if text:
		call_deferred("show_popup")

func show_info(text : String, time := 3.5, color := Color.red):
	self.text = text
	self.time = time
	self.color = color
	if ready:
		show_popup()

func show_popup():
	label.text = text
	label.modulate = color
	popup_centered()
	anchor_top -= .4
	anchor_bottom -= .4
	timer.start(time)

func _on_Timer_timeout():
	hide()

func _on_InfoPopup_popup_hide():
	anchor_top = 0
	anchor_bottom = 0
