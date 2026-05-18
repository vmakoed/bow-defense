class_name BossHurtArea
extends Area2D


signal destroyed


@export var arrow_scene: Resource
@export var attack_target: Node


func _ready() -> void:
	pass
	# var tween = create_tween()
	# tween.tween_property(
	# 	self,
	# 	"modulate",
	# 	Color(0, 0, 0, 0.0),
	# 	8.0
	# ).from_current()
	# tween.tween_callback(func(): 
	# 	vanished.emit()
	# 	queue_free()
	# )


func _shoot_arrow() -> void:
	var arrow := arrow_scene.instantiate() as EnemyArrow
	arrow.damage_modifier = 1.0
	var direction := global_position.direction_to(attack_target.global_position)
	arrow.velocity = 900.0 * direction
	arrow.gravity_modifier = 0.0
	arrow.global_position = Vector2(0, 0)
	
	add_child(arrow)


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()
	queue_free()


func _on_shoot_timer_timeout() -> void:
	_shoot_arrow()
