extends PanelContainer

var hp: int = 12
var max_hp: int = 12
var damage: int = 6
var strength: int = 0
var vulnerable_turns: int = 0

signal do_damage(damage: int)

@onready var hp_label: Label = $VBoxContainer/HP
@onready var strength_label: Label = $VBoxContainer/Strength
@onready var vuln_label: Label = $VBoxContainer/Vulnerable
@onready var intent_label: Label = $VBoxContainer/Intent

func _ready() -> void:
	hp_label.text = str(hp) + " / " + str(max_hp)
	update_intent()
	update_status_display()

func take_damage(amount: int) -> void:
	hp -= amount
	hp_label.text = str(hp) + " / " + str(max_hp)
	if hp <= 0:
		queue_free()

func act() -> void:
	var total_damage = damage + strength
	do_damage.emit(total_damage)
	update_status_display()
	update_intent()

func update_intent() -> void:
	intent_label.text = "Intent: Attack " + str(damage + strength)

func update_status_display() -> void:
	strength_label.text = "Str: " + str(strength)
	vuln_label.text = "Vuln: " + str(vulnerable_turns)
