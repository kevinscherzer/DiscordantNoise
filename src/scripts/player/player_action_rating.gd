extends Node2D

var rating_to_message: Dictionary[PlayerNote.Note_Score, String]= {
	PlayerNote.Note_Score.PERFECT: "PERFECT!",
	PlayerNote.Note_Score.GOOD: "Good",
	PlayerNote.Note_Score.BAD: "Bad",
	PlayerNote.Note_Score.MISS: "MISS",
}


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func on_action(rating: PlayerNote.Note_Score) -> void:
	var label = Label.new()
	label.text = rating_to_message[rating]
	label.add_theme_font_size_override("font_size", 48)
	label.modulate = Color(1, 0.2, 0.2)
	
	add_child(label)
	label.set_as_top_level(true)
	label.global_position = global_position + Vector2(60, -30)
	
	var tween = create_tween()
	tween.tween_property(label, "position:y", label.position.y - 40, 0.6)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.parallel().tween_property(label, "modulate:a", 0.0, 0.6)
	
	tween.tween_callback(label.queue_free)
	
