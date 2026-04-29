extends Node


@export var bow: Bow
@export var healing_strategy: BaseArrowStrategy


func _on_heal_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		bow.upgrades.append(healing_strategy)
		%HealButton.disabled = true
