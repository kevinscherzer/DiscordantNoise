class_name VideoSettings extends TabBar

@onready var window_mode_options_button: OptionButton = $%WindowModeOptionsButton
@onready var resolution_options_button: OptionButton = $%ResolutionOptionButton
@onready var v_sync_option_button: OptionButton = $%VSyncOptionButton
@onready var frame_rate_option_button: OptionButton = $%FrameRateOptionButton


var index: int


func _ready() -> void:
	connect_signals()


func connect_signals():
	window_mode_options_button.item_selected.connect(on_window_mode_options_item_selected)
	resolution_options_button.item_selected.connect(on_resolution_options_item_selected)


func on_window_mode_options_item_selected(mode):
	match mode:
		# Fullscreen
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			print("fullscreen")
		# Borderless Windowed
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			print("borderless windowed")
		# Windowed
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			print("windowed")


func on_resolution_options_item_selected(resolution):
	match resolution:
		# 1920 x 1080
		0:
			#get_window().set_size(Vector2i(1920, 1080))
			get_window().size = Vector2i(1920, 1080)
		# 1600 x 900
		1:
			#get_window().set_size(Vector2i(1600, 900))
			get_window().size = Vector2i(1600, 900)
		# 1280 x 720
		2:
			#get_window().set_size(Vector2i(1280, 720))
			get_window().size = Vector2i(1280, 720)


func center_window():
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get
