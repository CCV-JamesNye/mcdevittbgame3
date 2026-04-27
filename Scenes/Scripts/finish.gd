extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect( _check_for_win )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _check_for_win (body : Node2D) -> void:
	if body is Player:
		set_deferred("monitoring", false)
		body.can_move = false
		body.velocity = Vector2.ZERO
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		SceneTransition.go_to_next_level()
	
