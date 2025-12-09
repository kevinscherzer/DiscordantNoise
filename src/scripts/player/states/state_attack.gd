class_name State_Attack extends State

signal attack(rating: PlayerNote.Note_Score)

@onready var walk : State_Walk = $"../Walk"
@onready var idle : State_Idle = $"../Idle"

@onready var our_note : PlayerNote = $"PlayerNote"

@export_group("Attack Attributes")
var attack_duration : float = 0.1

var on_cooldown : bool = false

func _ready() -> void:
	pass

# When player enters state
func Enter() -> void:
	var rating = our_note.give_note_rating() 
	attack.emit(rating)
	
	on_cooldown = true
	attack_duration = Conductor.get_note_length() * Conductor.get_interval(8)
	
	if (rating == PlayerNote.Note_Score.MISS || rating == PlayerNote.Note_Score.MISS):
		attack_duration *= 2
	
	get_tree().create_timer(attack_duration).timeout.connect(func():
		on_cooldown = false
		)
	
# When player exits state
func Exit() -> void:
	pass

# When _process update in this state
func Process(_delta : float) -> State:
	if (on_cooldown):
		return null
		
	return _exit_state()

# When _physics_process in this state
func Physics(_delta : float) -> State:
	player.velocity = player.direction * walk.move_speed
	player.move_and_slide()
	return null

# When input event in this state
func HandleInput(_event : InputEvent) -> State:
	return null
	
func _exit_state() -> State:
	if (player.direction.is_zero_approx()):
		return idle
	else:
		return walk
