class_name Player
extends CharacterBody2D


signal damaged(amount: float, position: Vector2)
signal destroyed
signal healed(amount: float, position: Vector2)


@export var health_bar: ProgressBar


@onready var health_component: HealthComponent = %HealthComponent


func _ready() -> void:
	health_component.health_bar = health_bar


func heal(amount: float) -> void:
	health_component.heal(amount)
	healed.emit(amount, %HealthChangeMarker.global_position)


func _on_health_component_damaged(value: Damage) -> void:
	damaged.emit(value.amount, %HealthChangeMarker.global_position)


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()
