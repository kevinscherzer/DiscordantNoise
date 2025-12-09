class_name PauseMenu extends Control


@onready var resume_button: Button = $%ResumeButton
@onready var options_button: Button = $%OptionsButton
@onready var exit_button: Button = $%ExitButton
@onready var margin_container: MarginContainer = $MarginContainer
@onready var options_menu: OptionsMenu = $OptionsMenu as OptionsMenu


func _ready() -> void:
	resume_button.pressed.connect(on_resume_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	exit_button.pressed.connect(on_exit_button_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu_button_pressed)


func on_resume_button_pressed():
	GameEvents.resume()
	queue_free()
	

func on_options_button_pressed():
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true


func on_exit_button_pressed():
	GameEvents.exit_game()
	pass


func on_exit_options_menu_button_pressed():
	exit_options_menu()


func exit_options_menu():
	margin_container.visible = true
	options_menu.visible = false
