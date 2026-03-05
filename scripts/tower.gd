extends StaticBody2D


signal destroyed


@export var health_bar: ProgressBar


@onready var health_component: HealthComponent = %HealthComponent
@onready var hit_sound_player: AudioStreamPlayer2D = %HitSoundPlayer


func _ready() -> void:
	health_component.health_bar = health_bar


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()


func _on_health_component_damaged() -> void:
	hit_sound_player.play()
