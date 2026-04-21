extends Control

@onready var start_button: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/StartButton
@onready var resume_button: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/ResumeButton
@onready var quit_button: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/QuitButton
@onready var check_box: CheckBox = $CheckBox
@onready var check_box_2: CheckBox = $CheckBox2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SceneTransition.current_level_index == 0:
		resume_button.disabled = true
	start_button.pressed.connect (_start_game )
	resume_button.pressed.connect( _resume_game )
	quit_button.pressed.connect ( _quit_game )
	check_box.toggled.connect(mute_music)
	check_box_2.toggled.connect(mute_sfx)
	check_box.release_focus()
	check_box_2.release_focus()
	check_box.button_pressed = !Audiomanager.music_muted
	check_box_2.button_pressed = !Audiomanager.sfx_muted
	pass # Replace with function body.

func _quit_game () -> void:
	get_tree().quit()
	
func _start_game () -> void:
	SceneTransition.current_level_index=0
	SceneTransition.restart_level()
	pass
	
func _resume_game () -> void:
	SceneTransition.restart_level()
	pass


func mute_music (toggled_on : bool ) -> void:
	if toggled_on:
		Audiomanager.mute_music(false)
	else:
		Audiomanager.mute_music(true)
	check_box.release_focus()
	pass
	
func mute_sfx (toggled_on : bool ) -> void:
	if toggled_on:
		Audiomanager.mute_sfx(false)
	else:
		Audiomanager.mute_sfx(true)
	check_box_2.release_focus()
	pass
	
