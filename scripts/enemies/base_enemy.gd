class_name BaseEnemy
extends Area2D


signal damaged(damage: Damage)
signal died
signal killed


@export var enemy_stats: EnemyStats


@onready var health_component: HealthComponent = %HealthComponent


func _ready() -> void:
	health_component.max_health = enemy_stats.max_health
	health_component.health = enemy_stats.max_health


func is_alive() -> float:
	return health_component.is_alive()
