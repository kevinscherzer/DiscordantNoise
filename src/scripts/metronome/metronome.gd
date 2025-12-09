class_name Metronome extends Node

@onready var attributes : SongAttributes = $SongAttributes
@onready var notifier : RhythmNotifier = $RhythmNotifier

signal beat_occured
signal changed_time_sig(sig: TimeSignature)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_attributes(null)
	activate_notifier()
	pass

#emit different beat signals for each note denomination
	
func get_attributes() -> SongAttributes:
	return attributes
	
#set SongAttribtues i.e, bpm and timesig based on a resource
func set_attributes(att : SongAttributesResource) -> void:
	if (att == null):
		att = load("res://assets/resources/SongAttributes/default.tres")
	attributes.apply_preset(att)
	changed_time_sig.emit(attributes.time_signature)
	pass
	
#set SongAttributes based on a name
func set_attributes_name(att_name : String) -> void:
	var att = load(str("res://assets/resources/SongAttributes/", att_name, ".tres"))
	set_attributes(att)
	pass
	
func activate_notifier() -> void:
	notifier.bpm = attributes.bpm

	#var b = notifier.beats(1)
	#b.connect(func(count): print("Hello from note %d!" % (count)))
	var a = notifier.beats(1)
	a.connect(func(count): 
		beat_occured.emit()
		)
	notifier.beats(attributes.time_signature.top).connect(func(count): print("Hello from measure %d!" % (count)))
	notifier.running = true
	
	pass
	
func get_note_length() -> float:
	return notifier.beat_length
	
		
func get_rhythm(interval: float, offset: float = 0.0, once: bool = false) -> Signal:
	return notifier.beats(interval, !once, offset)
	
func get_interval(beat_value: float = 1.0) -> float:
	# Convert note’s beat_value into metronome subdivision
	# beat_value is denominator-style (quarter=4, eighth=8, etc.)
	# Conductor.time_sig.bottom tells us what "1 beat" is.
	#
	# Example: if beat_value=4 and time_sig.bottom=4 → 1 beat
	#          if beat_value=8 and time_sig.bottom=4 → 0.5 beat
	#          if beat_value=2 and time_sig.bottom=4 → 2 beats
	#
	return attributes.time_signature.bottom / beat_value

func get_current_position() -> float:
	return notifier.current_position
