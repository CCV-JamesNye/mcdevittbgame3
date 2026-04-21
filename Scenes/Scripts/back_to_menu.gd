extends CanvasLayer

@onready var menubutton: Button = $Control/MarginContainer/VBoxContainer/menubutton
@export var reset_progress_on_menu: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menubutton.pressed.connect( _menu )
	pass # Replace with function body.


func _menu () -> void:
	if reset_progress_on_menu:
		SceneTransition.current_level_index = 0
	SceneTransition.load_scene("res://Scenes/UI/mainmenu.tscn")
