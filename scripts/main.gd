extends Node2D


var mouse_start: Vector2 = Vector2.ZERO
var mouse_end: Vector2 = Vector2.ZERO
var arrow_scene: Resource


@onready var player: CharacterBody2D = %Player


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_start = event.position
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			mouse_end = event.position
			_shoot_arrow(mouse_end)


func _shoot_arrow(target: Vector2) -> void:
	print("mouse dragged between ", mouse_start, " and ", mouse_end)
	var arrow = arrow_scene.instantiate()
	var player_position = player.global_position
	var direction = (target - player_position).normalized()
	arrow.direction = direction
	arrow.global_position = player_position
	add_child(arrow)

