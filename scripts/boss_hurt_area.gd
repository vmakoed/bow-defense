class_name BossHurtArea
extends Area2D


signal destroyed


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


func _on_health_component_health_below_minimum() -> void:
	destroyed.emit()
	queue_free()
