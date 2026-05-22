class_name Player
extends CharacterBody2D


signal damaged(amount: float, position: Vector2)
signal destroyed
signal healed(amount: float, position: Vector2)


var alive = true


@onready var health_component: HealthComponent = %HealthComponent


func _ready() -> void:
	health_component.health_changed.connect(_on_health_changed)
	health_component.max_health = GameConfig.max_player_health
	health_component.health = GameConfig.max_player_health


func heal(amount: float) -> void:
	health_component.heal(amount)
	healed.emit(amount, %HealthChangeMarker.global_position)
	

func _on_health_changed(new_value: float) -> void:
	GameUIBridge.player_health_changed.emit(new_value)

func _on_health_component_damaged(value: Damage) -> void:
	damaged.emit(value.amount, %HealthChangeMarker.global_position)


func _on_health_component_health_below_minimum() -> void:
	if not alive: return
	alive = false
	destroyed.emit()

