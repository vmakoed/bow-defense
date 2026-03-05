extends StaticBody2D


@export var health_bar: ProgressBar


@onready var health_component: HealthComponent = %HealthComponent


func _ready() -> void:
	health_component.health_bar = health_bar
