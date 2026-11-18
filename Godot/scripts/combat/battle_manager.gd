
class_name BattleManager
extends Node

signal state_updated
signal message_logged(message: String)
signal battle_ended(victory: bool)

const ATTACK_DAMAGE: int = 10
const SPELL_DAMAGE: int = 15
const SPELL_MANA_COST: int = 10

var player: PlayerData
var enemy: EnemyData
var battle_active: bool = false


func start_battle(player_data: PlayerData, enemy_data: EnemyData) -> void:
	player = player_data
	enemy = enemy_data.duplicate() as EnemyData

	battle_active = true

	message_logged.emit("A wild %s appeared!" % enemy.enemy_name)
	state_updated.emit()


func player_attack() -> void:
	if not battle_active:
		return

	enemy.take_damage(ATTACK_DAMAGE)

	message_logged.emit(
		"You attacked %s for %d damage!" % [
			enemy.enemy_name,
			ATTACK_DAMAGE
		]
	)

	state_updated.emit()

	if enemy.is_defeated():
		win_battle()
	else:
		enemy_turn()


func player_cast_spell() -> void:
	if not battle_active:
		return

	if not player.use_mana(SPELL_MANA_COST):
		message_logged.emit("Not enough mana!")
		return

	enemy.take_damage(SPELL_DAMAGE)

	message_logged.emit(
		"You cast a spell on %s for %d damage!" % [
			enemy.enemy_name,
			SPELL_DAMAGE
		]
	)

	state_updated.emit()

	if enemy.is_defeated():
		win_battle()
	else:
		enemy_turn()


func enemy_turn() -> void:
	if not battle_active:
		return

	player.take_damage(enemy.attack_damage)

	message_logged.emit(
		"%s attacked you for %d damage!" % [
			enemy.enemy_name,
			enemy.attack_damage
		]
	)

	state_updated.emit()

	if player.hp <= 0:
		lose_battle()


func win_battle() -> void:
	battle_active = false

	player.gold += enemy.gold_reward
	player.experience += enemy.exp_reward

	message_logged.emit(
		"You defeated %s! Earned %d gold and %d EXP!" % [
			enemy.enemy_name,
			enemy.gold_reward,
			enemy.exp_reward
		]
	)

	state_updated.emit()
	battle_ended.emit(true)


func lose_battle() -> void:
	battle_active = false

	message_logged.emit("You have been defeated...")
	battle_ended.emit(false)
