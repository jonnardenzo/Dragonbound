
class_name PlayerData
extends Resource

@export var character_name: String = "Adventurer"
@export_enum("Warrior", "Mage", "Rogue")
var character_class: String = "Warrior"

@export var level: int = 1
@export var experience: int = 0

@export var hp: int = 150
@export var max_hp: int = 150

@export var mana: int = 50
@export var max_mana: int = 50

@export var gold: int = 100
@export var weapon: String = "Iron Sword"

@export var inventory: Array[String] = []


func setup(new_name: String, new_class: String) -> void:
	character_name = new_name
	character_class = new_class

	level = 1
	gold = 100
	inventory.clear()

	match character_class:
		"Warrior":
			weapon = "Iron Sword"
			max_hp = 150
			max_mana = 50

		"Mage":
			weapon = "Battle Staff"
			max_hp = 100
			max_mana = 100

		"Rogue":
			weapon = "Iron Daggers"
			max_hp = 100
			max_mana = 70

		_:
			push_error("Invalid character class!")
			return

	hp = max_hp
	mana = max_mana

	inventory.append(weapon)
	inventory.append("Health Potion")


func take_damage(amount: int) -> void:
	hp = maxi(0, hp - maxi(amount, 0))


func heal(amount: int) -> void:
	hp = mini(max_hp, hp + maxi(amount, 0))


func restore_mana(amount: int) -> void:
	mana = mini(max_mana, mana + maxi(amount, 0))


func use_mana(amount: int) -> bool:
	if amount < 0 or mana < amount:
		return false

	mana -= amount
	return true
