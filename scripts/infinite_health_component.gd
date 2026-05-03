extends HealthComponent 


func damage(value: Damage) -> void:
    value.amount = 0.0
    damaged.emit(value)
