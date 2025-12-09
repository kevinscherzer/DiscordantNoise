class_name HitboxComponent extends Area2D

signal on_enemy_hit(damage: float)

func on_hit(damage: float):
	on_enemy_hit.emit(damage)
