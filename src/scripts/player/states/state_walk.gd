class_name State_Walk extends State

@export var move_speed : float = 100.0

@onready var idle : State = $"../Idle"
@onready var dash : State_Dash = $"../Dash"
@onready var melee_attack : State_Attack = $"../Attack"

# When player enters state
func Enter() -> void:
	#player.UpdateAnimation("walking")
	#print("walk")
	pass
	
# When player enters state
func Exit() -> void:
	pass

# When _process update in this state
func Process(_delta : float) -> State:
	#if player.SetDirection():
		#player.UpdateAnimation("walking")
	return null

# When _physics_process in this state
func Physics(_delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle

	player.velocity = player.direction * move_speed
	player.move_and_slide()
	return null

# When input event in this state
func HandleInput(_event : InputEvent) -> State:
	if (_event.is_action_pressed("dash") && !dash.on_cooldown):
		return dash
	if (_event.is_action_pressed("melee_attack") && !melee_attack.on_cooldown):
		return melee_attack
	return null
