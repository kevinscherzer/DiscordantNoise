class_name MainMenu extends Control


var main_scene = preload("res://scenes/main.tscn").instantiate()

@onready var start_button: Button = $%StartButton
@onready var options_button: Button = $%OptionsButton
@onready var exit_button: Button = $%ExitButton
@onready var options_menu: OptionsMenu = $OptionsMenu as OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer


func _ready() -> void:
	Conductor.notifier.running = false
	start_button.pressed.connect(on_start_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	exit_button.pressed.connect(on_exit_button_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu_button_pressed)
	
func on_start_button_pressed():
	get_tree().root.add_child(main_scene)
	queue_free()
	

func on_options_button_pressed():
	options_menu.visible = true
	margin_container.visible = false


func on_exit_button_pressed():
	get_tree().quit()
	
	
func on_exit_options_menu_button_pressed():
	exit_options_menu()


func exit_options_menu():
	margin_container.visible = true
	options_menu.visible = false
