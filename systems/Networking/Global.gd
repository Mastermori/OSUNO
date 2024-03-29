extends Node

enum CardType {
	NORMAL,
	DRAWTWO,
	SKIP,
	REVERSE,
	WILD,
	WILDFOUR,
}

var cards := {
	num = preload("res://systems/Cards/NumCard.tscn"),
}

func _ready():
	self.pause_mode = Node.PAUSE_MODE_PROCESS

func create_player(name : String, color: Color):
	return load("res://systems/Player.tscn").instance().init(name, color)

func change_scene(new_scene : Node):
	var root = get_tree().get_root()
	var level = get_tree().current_scene
	root.remove_child(level)
	level.call_deferred("free")
	root.add_child(new_scene)
	# Optional, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(new_scene)

