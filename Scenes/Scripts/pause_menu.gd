extends CanvasLayer

@onready var pause_button: Button = $PauseButton
@onready var menubutton: Button = $menubutton


func _ready() -> void:
	visible = false
	pause_button.pressed.connect(_hide_menu)
	menubutton.pressed.connect( _menu )    
	pass # Replace with function body.


func _menu() -> void:
	_hide_menu()  # unpause + hide pause menu first
	SceneTransition.load_scene("res://Scenes/UI/mainmenu.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			_hide_menu()
		else:
			_show_menu()

func _show_menu() -> void:
	visible = true
	get_tree().paused = true

func _hide_menu() -> void:
	visible = false
	get_tree().paused = false
