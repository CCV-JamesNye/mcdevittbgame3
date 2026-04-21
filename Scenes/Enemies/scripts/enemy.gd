extends CharacterBody2D


@export var patrol_speed : float = 25.0
@export var chase_speed_multiplier : float = 2
@export var gravity : float = 980.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var floor_detector: RayCast2D = $FloorDetector
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_detector: Area2D = $PlayerDetector
@onready var chase_timer: Timer = $ChaseTimer
@onready var idle_timer: Timer = $IdleTimer



var direction : Vector2 = Vector2.RIGHT

enum STATE {IDLE, PATROL, CHASE}

var current_state : STATE = STATE.IDLE

func _ready() -> void:
	player_detector.body_entered.connect( _check_for_player)
	player_detector.body_exited.connect( _player_left)
	chase_timer.timeout.connect( _stop_chasing)
	idle_timer.timeout.connect( _start_patrol)
	idle_timer.start()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	match current_state:
		STATE.IDLE:
			handle_idle()
		STATE.PATROL:
			handle_patrol()
		STATE.CHASE:
			handle_chase()

	move_and_slide()
	if is_on_wall():
		turn_around()
	elif !floor_detector.is_colliding():
		turn_around()

func turn_around() -> void:
	if direction == Vector2.RIGHT:
		direction = Vector2.LEFT
		floor_detector.position.x = -6
		sprite_2d.flip_h = true
	else:
		direction = Vector2.RIGHT
		floor_detector.position.x = 6
		sprite_2d.flip_h = false
	
func handle_idle() -> void:
	velocity.x=0
	animation_player.play("idle")
	pass
	
func handle_patrol() -> void:
	animation_player.play("walk")
	velocity.x=direction.x*patrol_speed
	pass
	
func handle_chase () -> void:
	animation_player.play("walk")
	velocity.x=direction.x*(patrol_speed * chase_speed_multiplier)
	pass
	
func _check_for_player ( body : Node2D ) -> void:
	if body is Player:
		idle_timer.stop()
		chase_timer.stop()
		current_state = STATE.CHASE
		
func _player_left(body: Node2D) -> void:
	if body is Player and is_instance_valid(chase_timer) and chase_timer.is_inside_tree():
		chase_timer.start()
		
func _stop_chasing () -> void:
	current_state = STATE.IDLE
	idle_timer.start()
	
func _start_patrol () -> void:
	current_state = STATE.PATROL
	
