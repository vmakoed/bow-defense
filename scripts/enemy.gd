extends Area2D


var starting_position: Vector2
var target_position: Vector2
var velocity: Vector2
var speed := 200.0


func _ready() -> void:
	starting_position = global_position


func _process(delta: float) -> void:
	position += velocity * delta


func move_to(direction: Vector2) -> void:
	target_position = direction
	velocity = speed * target_position


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage()
		print(starting_position)
		var direction := global_position.direction_to(starting_position)
		move_to(direction)
		
