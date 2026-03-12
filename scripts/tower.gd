extends StaticBody2D


signal damaged
signal destroyed


@export var health_bar: ProgressBar


@onready var health_component: HealthComponent = %HealthComponent
@onready var damaged_sound_player: AudioStreamPlayer2D = %DamagedSoundPlayer


func _ready() -> void:
	health_component.health_bar = health_bar


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()


func _on_health_component_damaged(_damage: Damage) -> void:
	damaged.emit()
	damaged_sound_player.play()
