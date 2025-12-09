extends Node

signal died
signal hp_changed(hp: int)

func on_death():
	died.emit()

func update_hp(hp: int):
	hp_changed.emit(hp)

func pause():
	get_tree().paused = true


func resume():
	get_tree().paused = false


func exit_game():
	get_tree().quit()
