class_name HealingArrowStrategy
extends BaseArrowStrategy


@export var healing_amount := 25.0


func apply_strategy(arrow: Arrow) -> void:
    arrow.healing_amount = healing_amount
