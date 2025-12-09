class_name MenuUIController extends CanvasLayer

var pause_menu_scene = preload("res://scenes/ui/menu/pause_menu.tscn")


func pause_game():
	var pause_menu_instance = pause_menu_scene.instantiate()
	pause_menu_instance.add_to_group("pause_menu")
	GameEvents.pause()
	add_child(pause_menu_instance)
