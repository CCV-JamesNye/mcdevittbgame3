extends CanvasLayer

@onready var menubutton: Button = $Control/MarginContainer/VBoxContainer/menubutton
@onready var try_again_button: Button = get_node_or_null("Control/MarginContainer/VBoxContainer/tryagainbutton") as Button

@export var reset_progress_on_menu: bool = false

func _ready() -> void:
	menubutton.pressed.connect(_menu)

	if try_again_button != null:
		try_again_button.pressed.connect(_try_again)

func _menu() -> void:
	if reset_progress_on_menu:
		SceneTransition.current_level_index = 0

	SceneTransition.load_scene("res://Scenes/UI/mainmenu.tscn")

func _try_again() -> void:
	SceneTransition.restart_level()
