extends Area2D
class_name Enemy


var target_position: Vector2
var velocity: Vector2
var speed := 150.0


func _process(delta: float) -> void:
	position += velocity * delta


func move_to(direction: Vector2) -> void:
	target_position = direction
	velocity = speed * target_position


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage()
		queue_free()
		
