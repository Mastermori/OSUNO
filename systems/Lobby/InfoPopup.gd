extends PopupPanel

onready var timer = $Timer
onready var label = $InfoLabel

func show_info(text : String, time := 3.5, color := Color.red):
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
