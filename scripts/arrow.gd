extends Area2D


var direction: Vector2 = Vector2.RIGHT
var speed := 1200.0
var gravity_modifier := 800
var drag_factor := 0.98
var velocity: Vector2


func _ready() -> void:
	velocity = speed * direction


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

	