class_name PiercingArrowStrategy
extends BaseArrowStrategy


@export var piercing_amount := 1000


func apply_strategy(arrow: Arrow) -> void:
    arrow.piercing_amount = piercing_amount
