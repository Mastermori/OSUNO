extends Node

class_name Player

var nick : String
var color : Color

var cards : Array

var cardSize : Vector2

onready var hand = $HandCards
onready var discard = $"/root/1v1/DiscardPile"

export var maxWidthPercent := .75

func _ready():
	hand.position.x = -OS.get_window_size().x*maxWidthPercent/2;
	cardSize = $HandCards/NumCard/Border.rect_size * $HandCards/NumCard.scale
	print(cardSize)
	$HandCards/NumCard.queue_free()
	draw_cards(3)

func order_cards():
	cards.sort_custom(self, "compare_numcards")
	for i in range(cards.size()):
		cards[i].position.x = get_appropriate_width()/cards.size()*i
	pass

func compare_numcards(a : NumCard, b : NumCard):
	if typeof(a) != typeof(b):
		return false
	else:
		return a.number < b.number

func get_appropriate_width():
	var width = cardSize.x
	width *= 1.1 #margin percent
	width *= cards.size()
	print("appropriate width:")
	print(width < OS.get_window_size().x*maxWidthPercent)
	return (width if width < OS.get_window_size().x*maxWidthPercent else OS.get_window_size().x*maxWidthPercent)

func draw_card():
	var card = Global.cards["num"].instance()
	card.set_num(randi() % 10)
	card.inHand = true
	add_card(card)

func add_card(card):
	cards.append(card)
	hand.add_child(card)
	card.connect("card_clicked", self, "_on_card_clicked", [card])

func _on_card_clicked(card : Card):
	var pos = -hand.position + discard.position - get_parent().position
	print(pos)
	cards.erase(card)
	card.inHand = false
	card.move_to(pos)

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
