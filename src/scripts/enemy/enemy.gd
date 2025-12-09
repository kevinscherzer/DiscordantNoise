extends Sprite2D

@onready var hitbox: HitboxComponent = $HitBoxComponent
@onready var healthBar: HealthBar = $HealthBar

func _ready() -> void:
	hitbox.on_enemy_hit.connect(on_hit)

func on_hit(damage: float) -> void:
	print("Took " + str(damage) + " damage")
	healthBar.change_hp(damage)
	
	if healthBar.hp == 0:
		queue_free()
