extends Area2D
class_name Arrow


var gravity_modifier: float
var velocity: Vector2


func _process(delta: float) -> void:
	velocity.y += gravity_modifier * delta
	rotation = velocity.angle()
	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage()
		queue_free()

	