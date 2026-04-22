class_name HurtboxComponent
extends Area2D


@export var health_component: HealthComponent


func damage(value: Damage):
	health_component.damage(value)
