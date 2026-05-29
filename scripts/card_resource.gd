class_name CardResource
extends Resource

enum CardType { ATTACK, SKILL, POWER }
@export var card_name: String
@export var cost: int
@export var type: CardType
@export var damage: int
@export var block: int
@export var description: String
@export var icon: Texture2D
@export var strength_gain: int
@export var vulnerable_applied: int
