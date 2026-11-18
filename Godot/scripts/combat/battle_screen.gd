
extends Control

var battle_manager: BattleManager
var player_data: PlayerData
var enemy_data: EnemyData

var enemy_hp_bar: ProgressBar
var player_hp_bar: ProgressBar
var player_mana_bar: ProgressBar
var battle_log: Label

var attack_button: Button
var spell_button: Button


func _ready() -> void:
	_build_interface()
	_start_battle()


func _build_interface() -> void:
	# Background
	var background := ColorRect.new()
	background.color = Color("#171b2b")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	# Enemy name
	var enemy_label := Label.new()
	enemy_label.text = "GOBLIN"
	enemy_label.position = Vector2(260, 35)
	enemy_label.add_theme_font_size_override("font_size", 24)
	add_child(enemy_label)

	# Enemy HP
	enemy_hp_bar = _create_bar(
		Vector2(230, 75), Vector2(180, 18), 20, "#d94b4b"
	)

	# Goblin placeholder
	var goblin := Label.new()
	goblin.text = "G"
	goblin.position = Vector2(285, 95)
	goblin.add_theme_font_size_override("font_size", 80)
	add_child(goblin)

	# Player status
	var player_label := Label.new()
	player_label.text = "ADVENTURER LV 1"
	player_label.position = Vector2(35, 220)
	player_label.add_theme_font_size_override("font_size", 18)
	add_child(player_label)

	player_hp_bar = _create_bar(
		Vector2(35, 255), Vector2(220, 18), 150, "#d94b4b"
	)

	player_mana_bar = _create_bar(
		Vector2(35, 285), Vector2(220, 18), 50, "#4b8bd9"
	)

	# Battle message
	battle_log = Label.new()
	battle_log.text = "A wild Goblin appeared!"
	battle_log.position = Vector2(300, 220)
	battle_log.size = Vector2(310, 50)
	battle_log.autowrap_mode = TextServer.AUTOWRAP_WORD
	add_child(battle_log)

	# Attack button
	attack_button = _create_button(
		"ATTACK", Vector2(300, 290)
	)
	attack_button.pressed.connect(_on_attack_pressed)

	# Spell button
	spell_button = _create_button(
		"SPELL", Vector2(455, 290)
	)
	spell_button.pressed.connect(_on_spell_pressed)


func _create_bar(
	pos: Vector2,
	bar_size: Vector2,
	maximum: float,
	fill_color: String
) -> ProgressBar:
	var bar := ProgressBar.new()
	bar.position = pos
	bar.size = bar_size
	bar.max_value = maximum
	bar.value = maximum
	bar.show_percentage = false

	var fill := StyleBoxFlat.new()
	fill.bg_color = Color(fill_color)
	bar.add_theme_stylebox_override("fill", fill)

	var empty := StyleBoxFlat.new()
	empty.bg_color = Color("#111522")
	bar.add_theme_stylebox_override("background", empty)

	add_child(bar)
	return bar


func _create_button(
	button_text: String,
	pos: Vector2
) -> Button:
	var button := Button.new()
	button.text = button_text
	button.position = pos
	button.size = Vector2(135, 40)
	button.z_index = 10
	button.add_theme_font_size_override("font_size", 18)

	add_child(button)
	return button


func _start_battle() -> void:
	player_data = PlayerData.new()
	player_data.setup("Adventurer", "Warrior")

	enemy_data = EnemyData.new()
	enemy_data.enemy_name = "Goblin"
	enemy_data.hp = 20
	enemy_data.max_hp = 20
	enemy_data.attack_damage = 5

	battle_manager = BattleManager.new()
	add_child(battle_manager)

	battle_manager.message_logged.connect(_on_message_logged)
	battle_manager.state_updated.connect(_refresh_interface)

	battle_manager.start_battle(player_data, enemy_data)
	_refresh_interface()


func _refresh_interface() -> void:
	enemy_hp_bar.value = battle_manager.enemy.hp
	player_hp_bar.value = player_data.hp
	player_mana_bar.value = player_data.mana

	attack_button.disabled = not battle_manager.battle_active
	spell_button.disabled = not battle_manager.battle_active


func _on_attack_pressed() -> void:
	battle_manager.player_attack()


func _on_spell_pressed() -> void:
	battle_manager.player_cast_spell()


func _on_message_logged(message: String) -> void:
	battle_log.text = message
