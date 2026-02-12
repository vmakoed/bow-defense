extends Node2D


var arrow_scene: Resource


@onready var player: CharacterBody2D = %Player
@onready var aim_indicator: Line2D = %AimIndicator
@onready var enemies: Node2D = %Enemies


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")
	for enemy: Enemy in enemies.get_children():
		var direction := enemy.global_position.direction_to(player.global_position)
		enemy.move_to(direction)

func _input(event: InputEvent) -> void:
	if !is_instance_valid(player):
		aim_indicator.clear_points()
		return

	if event is InputEventMouseMotion:
		aim_indicator.clear_points()
		aim_indicator.add_point(player.global_position)
		aim_indicator.add_point(event.position)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			var mouse_position = event.position
			_shoot_arrow(mouse_position)


func _shoot_arrow(target: Vector2) -> void:
	var arrow = arrow_scene.instantiate()
	var player_position = player.global_position
	var direction = (target - player_position).normalized()
	arrow.direction = direction
	arrow.global_position = player_position
	add_child(arrow)
