extends Card

export var number := 0

func _ready():
	init([Global.CardType.NORMAL], Color.red)
	$Number.text = str(number)

func set_num(num : int):
	number = num
	return self
