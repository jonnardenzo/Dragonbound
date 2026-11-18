
class_name EnemyData
extends Resource

@export var enemy_name: String = "Goblin"
@export var enemy_type: String = "Monster"

@export var level: int = 1

@export var hp: int = 20
@export var max_hp: int = 20

@export var attack_damage: int = 5

@export var gold_reward: int = 10
@export var exp_reward: int = 10


func take_damage(amount: int) -> void:
	hp = maxi(0, hp - maxi(amount, 0))


func is_defeated() -> bool:
	return hp <= 0
