extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer
@export var levels : Array[PackedScene]

var current_level_index : int = 0

func fade_to_black () -> bool: 
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	return true
	
func fade_in () -> bool:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	return true

func load_scene ( new_scene : String ) -> void:
	get_tree().paused=true
	await fade_to_black()
	get_tree().change_scene_to_file( new_scene )
	await fade_in()
	get_tree().paused=false
	
func go_to_next_level () -> void:
	if current_level_index < levels.size()-1: 
		current_level_index+=1
		var next_scene = levels[current_level_index].resource_path
		load_scene(next_scene)
	
	else:
		load_scene("res://Scenes/victory_screen.tscn")
	pass
	
func restart_level () -> void:
	var next_scene = levels[current_level_index].resource_path
	load_scene(next_scene)
	pass
