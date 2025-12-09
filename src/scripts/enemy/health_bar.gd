class_name HealthBar extends Node2D

@export var max_hp: float = 100.0
@onready var fill: ColorRect = $Fill

var hp: float = max_hp

func _ready() -> void:
	_update_fill()

func change_hp(change: float) -> void:
	hp = clamp(hp + change, 0, max_hp)
	_update_fill()
	
func _update_fill() -> void:
	if max_hp <= 0:
		fill.scale.x = 0.0
		return
	
	fill.scale.x = hp / max_hp
