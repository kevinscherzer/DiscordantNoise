extends CanvasLayer

@onready var currentHpLabel: Label = $Hitpoints/CurrentHp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.hp_changed.connect(on_hp_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_hp_changed(hp: int):
	currentHpLabel.text = str(hp)
