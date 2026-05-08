class_name ExplosiveArrowStrategy
extends BaseArrowStrategy


func apply_strategy(arrow: Arrow) -> void:
    arrow.explosive_damage = GameConfig.explosive_damage
