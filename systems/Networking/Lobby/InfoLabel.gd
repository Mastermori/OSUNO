extends Label

onready var timer = $Timer

func show_info(text : String, time := 3, color := Color.red):
	self.text = text
	self.modulate = color
	self.visible = true
	timer.start(time)


func _on_Timer_timeout():
	self.visible = false
