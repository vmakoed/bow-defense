extends Area2D
class_name Arrow


const MAX_POWER = 600.0


var direction: Vector2 = Vector2.RIGHT
var speed := 1200.0
var gravity_modifier := 800
var drag_factor := 0.98
var power := 0.0
var velocity: Vector2


func _ready() -> void:
	velocity = speed * (power / MAX_POWER) * direction


func _process(delta: float) -> void:
	velocity.y += gravity_modifier * delta
	velocity *= drag_factor
	rotation = velocity.angle()
	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage()
		queue_free()

	