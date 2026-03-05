extends Area2D
class_name HurtboxComponent


@export var health_component: HealthComponent


func damage(value: Damage):
	health_component.damage(value)
