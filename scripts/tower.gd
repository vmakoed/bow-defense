extends StaticBody2D


signal destroyed


@export var health_bar: ProgressBar


@onready var health_component: HealthComponent = %HealthComponent
@onready var damaged_sound_player: AudioStreamPlayer2D = %DamagedSoundPlayer


func _ready() -> void:
	health_component.health_bar = health_bar


func _emit_particles(particles: CPUParticles2D, instance_position: Vector2, color: Color) -> void:
	particles.modulate = color
	particles.one_shot = true
	particles.emitting = true
	add_child(particles)
	particles.global_position = instance_position


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()


func _on_health_component_damaged(_damage: Damage) -> void:
	pass
	# damaged.emit()
	# damaged_sound_player.play()

	# var particles_scene: Resource = preload("res://scenes/tower_damaged_particles.tscn")
	# var particles := particles_scene.instantiate() as CPUParticles2D

	# var particle_position = damage.source_global_position
	# if particle_position.x > global_position.x:
	# 	particle_position.x = global_position.x + color_rect.offset_right
	# else:
	# 	particle_position.x = global_position.x + color_rect.offset_left

	# _emit_particles(particles, particle_position, Color(0.61, 0.61, 0.61, 1.0))
