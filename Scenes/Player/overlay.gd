extends CanvasLayer

@onready var flash: ColorRect = $Flash


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flash.modulate=Color(1,1,1,0)
	pass # Replace with function body.


func screen_flash () -> void:
	var tween = create_tween()
	tween.tween_property(flash, "modulate", Color(1,1,1,1) , 0.1)
	await tween.finished
	var tween2 = create_tween()
	tween2.tween_property(flash, "modulate", Color(1,1,1,0) , 0.3)
	await tween2.finished
	
