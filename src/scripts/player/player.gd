class_name Player extends CharacterBody2D

signal hit

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

#@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
#@onready var sprite: AnimatedSprite2D = $PlayerSprite

#@export var speed = 200 # How fast the player will move (pixels/sec).

var invincible : bool = false

@onready var state_machine : PlayerStateMachine = $StateMachine

#might use
enum CHAR_FACING {LEFT, RIGHT, UP, DOWN}
var facing = CHAR_FACING.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_movement(delta);
	pass

func _movement(delta: float) -> void:
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = direction.normalized()
	_turn_char(direction)


func _turn_char(dir: Vector2) -> void:
	if (!dir.is_zero_approx()): 
		rotation = dir.angle()
	

func on_start(pos: Vector2):
	position = pos
	show()
	state_machine.Initialize(self)
