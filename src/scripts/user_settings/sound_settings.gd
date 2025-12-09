class_name SoundSettings extends TabBar

@onready var master_volume_slider: HSlider = $%MasterVolumeSlider
@onready var master_volume_value: Label = $%MasterVolumeValue
@onready var music_volume_slider: HSlider = $%MusicVolumeSlider
@onready var music_volume_value: Label = $%MusicVolumeValue
@onready var effects_volume_slider: HSlider = $%EffectsVolumeSlider
@onready var effects_volume_value: Label = $%EffectsVolumeValue
@onready var ui_volume_slider: HSlider = $%UIVolumeSlider
@onready var ui_volume_value: Label = $%UIVolumeValue


func _ready() -> void:
	connect_signals()
	setup_volume_sliders()


func connect_signals():
	master_volume_slider.value_changed.connect(on_master_volume_slider_value_changed)
	music_volume_slider.value_changed.connect(on_music_volume_slider_value_changed)
	effects_volume_slider.value_changed.connect(on_effects_volume_slider_value_changed)
	ui_volume_slider.value_changed.connect(on_ui_volume_slider_value_changed)


func setup_volume_sliders():
	master_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	master_volume_value.text = str(master_volume_slider.value * 100) + "%"
	music_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	music_volume_value.text = str(music_volume_slider.value * 100) + "%"
	effects_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	effects_volume_value.text = str(effects_volume_slider.value * 100) + "%"
	ui_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(3))
	ui_volume_value.text = str(ui_volume_slider.value * 100) + "%"


func on_master_volume_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(0, linear_to_db(master_volume_slider.value))
	master_volume_value.text = str(master_volume_slider.value * 100) + "%"


func on_music_volume_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(1, linear_to_db(music_volume_slider.value))
	music_volume_value.text = str(music_volume_slider.value * 100) + "%"


func on_effects_volume_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(2, linear_to_db(effects_volume_slider.value))
	effects_volume_value.text = str(effects_volume_slider.value * 100) + "%"


func on_ui_volume_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(3, linear_to_db(ui_volume_slider.value))
	ui_volume_value.text = str(ui_volume_slider.value * 100) + "%"
