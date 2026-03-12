extends Node
class_name HealthComponent


signal health_below_minimum
signal damaged


const MIN_HEALTH = 0.0


@export var max_health: float: set = _set_max_health
@export var health_bar: ProgressBar: set = _set_health_bar


var health: float: set = _set_health


func _ready() -> void:
    health = max_health


func damage(value: Damage) -> void:
    damaged.emit(value)
    health -= value.amount


func _set_max_health(value: float) -> void:
    if value == max_health: return
    max_health = value
    if health_bar: health_bar.max_value = max_health


func _set_health(value: float) -> void:
    if value == health: return
    health = value
    if health_bar: health_bar.value = health
    if health <= MIN_HEALTH: health_below_minimum.emit()


func _set_health_bar(value: ProgressBar) -> void:
    if value == health_bar: return
    health_bar = value
    health_bar.max_value = max_health
    health_bar.value = health
