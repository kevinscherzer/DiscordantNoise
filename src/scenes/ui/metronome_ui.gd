extends Control

@export var beat_color := Color.WHITE
@export var sub_color  := Color(0.7, 0.7, 0.7)
@export var cursor_color := Color(1, 0.2, 0.2)
@export var line_width := 4.0


func _ready() -> void:
	print(Conductor.get_attributes().bpm)
	pass

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var attrs = Conductor.get_attributes()
	
	var beats_per_bar = attrs.time_signature.top
	var sec_per_beat: float = Conductor.get_note_length()
	var bar_length: float = beats_per_bar * sec_per_beat

	var eighth_interval = Conductor.get_interval(8)

	var subdivisions_per_beat = max(1, int(round(1.0 / eighth_interval)))
	var total_divisions = beats_per_bar * subdivisions_per_beat
	
	var width = size.x
	var height = size.y

	# Draw ticks
	for i in range(total_divisions + 1):
		var x = width * float(i) / float(total_divisions)
		var strong = (i % subdivisions_per_beat) == 0

		draw_line(
			Vector2(x, height),
			Vector2(x, height - (height if strong else height * 0.5)),
			beat_color if strong else sub_color,
			line_width
		)
		
	#

	# Draw playhead
	var t = Conductor.get_current_position()
	var phase = fmod(t, bar_length) / bar_length
	var cx = phase * width

	draw_line(Vector2(cx, 0), Vector2(cx, height), cursor_color, line_width)
