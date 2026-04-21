class_name HurtBox extends Area2D
#the area that can receive damage


signal take_damage (int)

#identify the source
#find the dmg amount
#apply it to the parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect( _take_damage )
	pass
	
func _take_damage( _area : Area2D) -> void:
	if _area is hitbox :
		take_damage.emit( _area.damage )
	
	
	
