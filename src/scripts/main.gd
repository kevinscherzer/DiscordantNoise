class_name Main extends Node

@export var menu_ui: MenuUIController
@onready var player: Player = $Player
@onready var playerSpawn: Marker2D = $PlayerSpawn

func _ready() -> void:
	Conductor.notifier.running = true
	GameEvents.died.connect(on_died)
	add_to_group("main")
	
	player.on_start(playerSpawn.position)


func on_died():
	get_tree().quit()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_menu = get_tree().get_first_node_in_group("pause_menu") as PauseMenu
		if pause_menu == null:
			menu_ui.pause_game()
		else:
			match pause_menu.options_menu.visible:
				true:
					pause_menu.exit_options_menu()
				false:
					pause_menu.queue_free()
					GameEvents.resume()


func _process(delta: float) -> void:
	pass
