extends Node2D

@export var time_limit: float = 30.0

var time_left: float
var game_over := false
@onready var timer_label: Label = $Timer/TimerLabel



func _ready() -> void:
	time_left = time_limit
	update_timer()

func _process(delta: float) -> void:
	if game_over:
		return
	
	time_left -= delta
	
	if time_left <= 0:
		time_left = 0
		update_timer()
		end_game()
		return
	
	update_timer()

func update_timer() -> void:
	timer_label.text = "Time: %.2f" % time_left

func end_game() -> void:
	game_over = true
	SceneTransition.load_scene("res://Scenes/too_slow.tscn")
