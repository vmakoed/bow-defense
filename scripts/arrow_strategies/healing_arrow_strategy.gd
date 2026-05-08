class_name HealingArrowStrategy
extends BaseArrowStrategy


func apply_strategy(arrow: Arrow) -> void:
    arrow.healing_amount = GameConfig.healing_amount
