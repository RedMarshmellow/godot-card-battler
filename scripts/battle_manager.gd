extends Control

enum TurnState { PLAYER_TURN, ENEMY_TURN, VICTORY, DEFEAT }
var current_state: TurnState
var energy: int = 0
var max_energy: int = 3
var player_block: int = 0
var strength: int = 0
var vulnerable_turns: int = 0

@onready var energy_label: Label = $Energy
@onready var health_label: Label = $Health
@onready var strength_label: Label = $PlayerStrength
@onready var vuln_label: Label = $PlayerVulnerable

func _ready() -> void:
	$Enemy.do_damage.connect(take_damage)
	update_energy_display()
	update_health_display()
	start_player_turn()
	
func start_player_turn() -> void:
	player_block = 0
	vulnerable_turns = max(0, vulnerable_turns - 1)
	$Enemy.vulnerable_turns = max(0, $Enemy.vulnerable_turns - 1)
	$VBoxContainer/HBoxContainer/Block.text = "Block: " + str(player_block)
	current_state = TurnState.PLAYER_TURN
	energy = max_energy
	update_energy_display()
	update_status_display()
	for child in $VBoxContainer/Hand.get_children():
		child.queue_free()
	CustomDeckManager.draw_card(5)
	print("Hand size: ", $VBoxContainer/Hand.size)
	for card in CustomDeckManager.hand:
		var card_instance = preload("res://scenes/card.tscn").instantiate()
		card_instance.card_data = card
		$VBoxContainer/Hand.add_child(card_instance)
		card_instance.card_clicked.connect(_on_card_played)
		print("Added card: ", card.card_name)
	print("Player turn — Energy: ", energy)
	
func end_player_turn() -> void:
	current_state = TurnState.ENEMY_TURN
	CustomDeckManager.discard_hand()
	print("Enemy turn")
	await get_tree().create_timer(0.5).timeout
	$Enemy.act()
	await get_tree().create_timer(0.5).timeout
	start_player_turn()

func take_damage(damage: int) -> void:
	if vulnerable_turns > 0:
		damage = int(damage * 1.5)
	var blocked = min(player_block, damage)
	player_block -= blocked
	damage -= blocked
	GameManager.player_hp -= damage
	$VBoxContainer/HBoxContainer/Block.text = "Block: " + str(player_block)
	update_health_display()
	check_battle_end()
	
func _on_card_played(card_node: PanelContainer) -> void:
	var card = card_node.card_data
	if current_state != TurnState.PLAYER_TURN or energy < card.cost:
		return
	energy -= card.cost
	update_energy_display()
	match card.type:
		CardResource.CardType.ATTACK:
			var total_damage = card.damage + strength
			if $Enemy.vulnerable_turns > 0:
				total_damage = int(total_damage * 1.5)
			$Enemy.take_damage(total_damage)
		CardResource.CardType.SKILL:
			if card.strength_gain > 0:
				strength += card.strength_gain
			elif card.vulnerable_applied > 0:
				$Enemy.vulnerable_turns += card.vulnerable_applied
				$Enemy.update_status_display()
			else:
				player_block += card.block
				$VBoxContainer/HBoxContainer/Block.text = "Block: " + str(player_block)
	card_node.queue_free()
	update_status_display()
	check_battle_end()

func update_energy_display() -> void:
	energy_label.text = "Energy: " + str(energy) + " / " + str(max_energy)
	
func update_health_display() -> void:
	health_label.text = "Health: " + str(GameManager.player_hp) + " / " + str(GameManager.max_hp)

func update_status_display() -> void:
	strength_label.text = "Str: " + str(strength)
	vuln_label.text = "Vuln: " + str(vulnerable_turns)
	
func check_battle_end() -> void:
	if GameManager.player_hp <= 0:
		print("Defeat!")
		end_battle()
	elif $Enemy.hp <= 0:
		print("Victory!")
		end_battle()

func end_battle() -> void:
	current_state = TurnState.ENEMY_TURN
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	CustomDeckManager.reset_deck()
