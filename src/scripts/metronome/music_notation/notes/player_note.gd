class_name PlayerNote extends Node

#enum Notes {WHOLE_NOTE,HALF_NOTE,QUARTER_NOTE, EIGHTH_NOTE, SIXTEENTH_NOTE}

#var playable_on : Notes = Notes.EIGHTH_NOTE
var playable_on : BaseNote
var offset : float
var _time_since_last_note : float


#value from 0 to 10 determining the ranges at which something is considered a hit or not
@export var timing_difficulty : float = 6.5

enum Note_Score {PERFECT, GOOD, BAD, MISS}

#milliseconds 
@export var perfect_range : float = (80 - 6 * timing_difficulty) * .001
@export var good_range : float = (140 - 8 * timing_difficulty) * .001
@export var bad_range : float = (200 - 10 * timing_difficulty) * .001

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(true)
	_time_since_last_note = 99999
	#TODO: rework this temp fix
	playable_on = get_child(0)
	
#TODO, calculate note rating depending on how close to how off the input is from the beat/playable beat
func give_note_rating() -> Note_Score:
	var error_dist : float = _error_from_valid_note()
	if (error_dist < perfect_range):
		return Note_Score.PERFECT
	if (error_dist < good_range):
		return Note_Score.GOOD
	if (error_dist < bad_range):
		return Note_Score.BAD
	return Note_Score.MISS
	
	
func _process(delta: float) -> void:
	_time_since_last_note += delta
	pass

func on_note_triggered(note: BaseNote, count: int) -> void:
	_time_since_last_note = 0
	pass

# TODO, if the bpm is too high, the ranges might go outside the beat timings
# at least make it so that they have to be within the range of the beat
func _recalculate_ranges() -> void:
	pass
	
# TODO, get the absolute distance from a playable note. Only positive values, no negative
func _error_from_valid_note() -> float:
	var bottom_time_sig: int = Conductor.get_attributes().time_signature.bottom
	
	var note_length : float = playable_on.get_beat_duration()
	
	var error_diffs : Array[float] = [
		_time_since_last_note,
		abs(note_length - _time_since_last_note)
	]
		
	return error_diffs.min()
