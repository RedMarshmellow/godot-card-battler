extends PanelContainer
@export var card_data: CardResource
@onready var icon_rect: TextureRect = $VBoxContainer/Icon
@onready var name_label: Label = $VBoxContainer/CardName
@onready var desc_label: Label = $VBoxContainer/Description
@onready var cost_label: Label = $VBoxContainer/Cost

signal card_clicked(card_node: PanelContainer)

func _ready() -> void:
	if card_data:
		icon_rect.texture = card_data.icon
		name_label.text = card_data.card_name
		desc_label.text = card_data.description
		cost_label.text = str(card_data.cost)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		card_clicked.emit(self)
