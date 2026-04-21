class_name Player extends CharacterBody2D

signal health_update (int)

var speed : float = 100
@export var gravity : float = 980.0
@export var jump_force : float = -275
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var effect_player: AnimationPlayer = $EffectPlayer
@onready var hurtbox: Area2D = $hurtbox
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound
@onready var charge_jump_sound: AudioStreamPlayer2D = $ChargeJumpSound
@onready var overlay: CanvasLayer = $Overlay



var is_charging_jump : bool = false 
var charge_time : float = 0.0
var max_charge_time : float = 0.4
var crouch_time := 0.12
var health : int = 2
var max_health : int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtbox.take_damage.connect ( _take_damage )
	pass

func _take_damage ( damage: int) -> void:
	health -= damage
	printerr (health)
	overlay.screen_flash()
	effect_player.play("hurt")
	health_update.emit ( health )
	if health <= 0:
		die()
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	# Physics 
	# build the jump
	# set the crouch
	# increase the charge time until max time reached
	if is_charging_jump:
		charge_time += delta
		charge_time = min(charge_time, max_charge_time)
		# after a brief crouch, show charge_up while holding
		if charge_time >= crouch_time and effect_player.current_animation != "charge_up":
			effect_player.play("charge_up")
		
		
	# Store Direction
	var direction : Vector2 = Vector2.ZERO 
	

	# Read Input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if direction != Vector2.ZERO:
		animation_player.play("walk")
		if direction.x <0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
	elif !is_charging_jump:
		animation_player.play("idle")
	
	
	
	velocity.x = direction.normalized().x * speed
	move_and_slide()


	
func _unhandled_input(event: InputEvent) -> void:
	# input
# If the jump is pressed
# check to see when jump is released
	
	if event.is_action_pressed("jump") and is_on_floor():
		# start charging jump
		is_charging_jump = true
		charge_time = 0.0
		animation_player.play("crouch")
		effect_player.play("chargejump")
	
		
		
	if event.is_action_released("jump") and is_charging_jump:
		# release jump
		var charge_ratio = charge_time / max_charge_time
		charge_ratio = 0.5 if charge_ratio < 0.5 else charge_ratio
		velocity.y = jump_force * charge_ratio
		is_charging_jump = false
		effect_player.stop()
		animation_player.play("jump")
		jump_sound.play()
		
		
		
func die () -> void:
	await SceneTransition.load_scene("res://Scenes/game_over.tscn")
	
