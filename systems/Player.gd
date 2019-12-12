extends Node

class_name Player

var nick : String
var color : Color

var cards : Array

var cardSize : Vector2

onready var hand = $HandCards

export var maxWidthPercent := .75

func _ready():
	hand.position.x = -OS.get_window_size().x*maxWidthPercent/2;
	cardSize = $HandCards/NumCard/Border.rect_size * $HandCards/NumCard.scale
	print(cardSize)
	$HandCards/NumCard.queue_free()
	draw_cards(3)

func order_cards():
	for i in range(cards.size()):
		cards[i].position.x = get_appropriate_width()/cards.size()*i
	pass

func get_appropriate_width():
	var width = cardSize.x
	width *= 1.1 #margin percent
	width *= cards.size()
	return (width if width < OS.get_window_size().x*maxWidthPercent else OS.get_window_size().x*maxWidthPercent)

func draw_card():
	var card = Global.cards["num"].instance()
	card.set_num(randi() % 10)
	add_card(card)

func add_card(card):
	cards.append(card)
	hand.add_child(card)

func draw_cards(amount : int):
	for i in range(amount):
		draw_card()
	order_cards()

func init(nick : String, color : Color):
	self.nick = nick
	self.color = color
	return self

func to_dict():
	return {nick = nick, color = color.to_html()}
