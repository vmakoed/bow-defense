class_name Player
extends CharacterBody2D


@export var health_bar: ProgressBar


func _ready() -> void:
    %HealthComponent.health_bar = health_bar
