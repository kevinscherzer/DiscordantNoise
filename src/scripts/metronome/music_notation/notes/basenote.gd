class_name BaseNote extends Node

var beat_value: float = 1.0  # subdivision length assuming whole note (quarters=4, eighths=8, etc.)

var _curr_connection : Signal

func _init():
	pass
	
	
func _ready():
	_connect_to_rhythm()
	Conductor.changed_time_sig.connect(_on_time_sig_changed)

func _connect_to_rhythm():
	var interval = Conductor.get_interval(beat_value)
	_curr_connection = Conductor.get_rhythm(interval)
	_curr_connection.connect(_on_beat)

func _on_time_sig_changed(new_sig):
	# clean up old connection
	if _curr_connection and _curr_connection.is_connected(_on_beat):
		_curr_connection.disconnect(_on_beat)
	# reconnect with new interval
	_connect_to_rhythm()

func _on_beat(count: int) -> void:
	# Default behavior: tell parent we triggered
	if get_parent().has_method("on_note_triggered"):
		get_parent().on_note_triggered(self, count)
	
# returns duration of the beat
func get_beat_duration() -> float:
	return Conductor.get_note_length() * Conductor.get_interval(beat_value)


func _exit_tree():
	if _curr_connection and _curr_connection.is_connected(_on_beat):
		_curr_connection.disconnect(_on_beat)
	Conductor.changed_time_sig.disconnect(_on_time_sig_changed)
