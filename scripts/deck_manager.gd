extends Node
var draw_pile: Array[CardResource]
var hand: Array[CardResource]
var discard_pile: Array[CardResource]
func _init() -> void:
	_build_starter_deck()
func _build_starter_deck() -> void:
	var strike = preload("res://resources/cards/strike.tres")
	var defend = preload("res://resources/cards/block.tres")
	var inflame = preload("res://resources/cards/inflame.tres")
	var vulnerability = preload("res://resources/cards/vulnerability.tres")
	for i in 5:
		draw_pile.append(strike)
		draw_pile.append(defend)
	draw_pile.append(inflame)
	draw_pile.append(vulnerability)
	shuffle()
func shuffle() -> void:
	draw_pile.shuffle()
func draw_card(count: int = 1) -> Array[CardResource]:
	var drawn: Array[CardResource] = []
	for i in range(count):
		if draw_pile.is_empty():
			if discard_pile.is_empty():
				break
			while not discard_pile.is_empty():
				draw_pile.append(discard_pile.pop_back())
			draw_pile.shuffle()
		drawn.append(draw_pile.pop_back())
		hand.append(drawn[-1])
	return drawn
func discard_hand() -> void:
	for card in hand:
		discard_pile.append(card)
	hand.clear()
func reset_deck() -> void:
	for card in hand:
		draw_pile.append(card)
	for card in discard_pile:
		draw_pile.append(card)
	hand.clear()
	discard_pile.clear()
	shuffle()
