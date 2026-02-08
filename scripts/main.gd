extends Node2D


var arrow_scene: Resource


@onready var player: CharacterBody2D = %Player


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")


func _input(event: InputEvent) -> void:
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

