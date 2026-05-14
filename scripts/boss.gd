extends Area2D


signal enemy_spawning(spawn_position: Vector2)
signal destroyed
signal took_damage(damage: Damage)


@export var hurt_area_packed: PackedScene


var hurt_areas := 0
var vulnerable = false


@onready var spawn_markers = %ProjectileSpawnMarkers


func _spawn_enemies() -> void:
	vulnerable = true
	hurt_areas = spawn_markers.get_child_count()

	for marker: Marker2D in spawn_markers.get_children():
		var hurt_area_position := marker.global_position
		_spawn_hurt_area(hurt_area_position)
		enemy_spawning.emit(hurt_area_position)


func _spawn_hurt_area(area_position: Vector2) -> void:
	var hurt_area_scene = hurt_area_packed.instantiate() as BossHurtArea
	add_child(hurt_area_scene)
	hurt_area_scene.destroyed.connect(_on_hurt_area_destroyed)
	hurt_area_scene.vanished.connect(_on_hurt_area_vanished)
	hurt_area_scene.global_position = area_position


func _take_damage() -> void:
	var damage = Damage.new()
	damage.amount = 10
	took_damage.emit(damage)


func _on_projectile_spawn_timer_timeout() -> void:
	_spawn_enemies()


func _on_first_attack_timer_timeout() -> void:
	_spawn_enemies()
	%ProjectileSpawnTimer.start()


func _on_hurt_area_destroyed() -> void:
	hurt_areas -= 1
	if hurt_areas <= 0 and vulnerable:
		_take_damage()
		vulnerable = false


func _on_hurt_area_vanished() -> void:
	vulnerable = false
	hurt_areas -= 1


func _on_area_entered(area: Area2D) -> void:
	if area is Arrow:
		area.invert()


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()
	queue_free()
