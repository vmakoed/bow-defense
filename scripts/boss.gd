extends Node2D


signal enemy_spawning(spawn_position: Vector2)
signal destroyed
signal damaged(damage: Damage)


@export var hurt_area_packed: PackedScene


var hurt_areas := 0
var idle := true: set = _set_idle
var vulnerable := true: set = _set_vulnerable


@onready var spawn_markers = %ProjectileSpawnMarkers


func _set_idle(value: bool) -> void:
	if value == idle: return
	idle = value
	if not idle: vulnerable = false


func _set_vulnerable(value: bool) -> void:
	if value == vulnerable: return
	vulnerable = value
	if vulnerable:
		%HurtboxComponent.show()
		%HurtboxCollisionShape.set_deferred("disabled", false)
	else:
		%HurtboxComponent.hide()
		%HurtboxCollisionShape.set_deferred("disabled", true)
		%SpawnTimer.start()


func _spawn_enemies() -> void:
	hurt_areas = spawn_markers.get_child_count()

	for marker: Marker2D in spawn_markers.get_children():
		var hurt_area_position := marker.global_position
		_spawn_hurt_area(hurt_area_position)
		enemy_spawning.emit(hurt_area_position)


func _spawn_hurt_area(area_position: Vector2) -> void:
	var hurt_area_scene = hurt_area_packed.instantiate() as BossHurtArea
	%HurtAreas.add_child.call_deferred(hurt_area_scene)
	hurt_area_scene.set_deferred("global_position", area_position)
	hurt_area_scene.destroyed.connect(_on_hurt_area_destroyed)
	# hurt_area_scene.vanished.connect(_on_hurt_area_vanished)


func _take_damage() -> void:
	pass
	# var damage = Damage.new()
	# damage.amount = 5
	# took_damage.emit(damage)


func _on_projectile_spawn_timer_timeout() -> void:
	pass
	# _spawn_enemies()


func _on_first_attack_timer_timeout() -> void:
	pass
	# _spawn_enemies()
	# %ProjectileSpawnTimer.start()


func _on_hurt_area_destroyed() -> void:
	hurt_areas -= 1
	if hurt_areas <= 0:
		vulnerable = true
		%HurtAreasTimer.stop()
		%VulnerableTimer.start()
		# _take_damage()


func _on_hurt_area_vanished() -> void:
	pass
	# vulnerable = false
	# hurt_areas -= 1


# func _on_area_entered(area: Area2D) -> void:
# 	if area is Arrow:
# 		area.invert()


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()
	queue_free()


func _on_health_component_damaged(value: Damage) -> void:
	damaged.emit(value)
	idle = false
	%VulnerableTimer.stop()
	vulnerable = false


func _on_debug_timer_timeout() -> void:
	pass
	# print(%HurtAreas.visible)
	# print(%HurtAreas.get_children())
	# for child in %HurtAreas.get_children():
	# 	print(child.get_children())


func _on_spawn_timer_timeout() -> void:
	_spawn_enemies()
	%HurtAreasTimer.start()



func _on_hurt_areas_timer_timeout() -> void:
	vulnerable = false
	for hurt_area in %HurtAreas.get_children():
		hurt_area.queue_free()

	%SpawnTimer.start()


func _on_vulnerable_timer_timeout() -> void:
	vulnerable = false
