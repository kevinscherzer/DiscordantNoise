extends Node2D

@export var base_damage: float = 10.0

@onready var attackAnim: AnimationPlayer = $PlayerAttackAnimation
@onready var attackSprite: Sprite2D = $PlayerAttackSprite
@onready var attackHitbox: Area2D = $PlayerAttackHitbox
@onready var attackCollision: CollisionShape2D = $PlayerAttackHitbox/CollisionShape2D

var current_damage: float = 0.0

func _ready() -> void:
	attackSprite.modulate.a = 0
	attackCollision.disabled = true
	attackHitbox.connect("area_entered", _on_hitbox_entered)

func on_attack(rating: PlayerNote.Note_Score) -> void:
	# Perfect is 0, Miss is 3
	current_damage = base_damage * (PlayerNote.Note_Score.MISS - rating)
	attackAnim.play("player_attack_animation")

func _on_hitbox_entered(enemy: Area2D) -> void:
	print("Attacking " + enemy.get_parent().name + " for " + str(current_damage) + " damage")
	if enemy.has_method("on_hit"):
		enemy.on_hit(current_damage * -1)
