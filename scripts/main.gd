extends Node2D


var arrow_scene: Resource
var pull_position: Vector2
var aiming: bool = false


@onready var player: CharacterBody2D = %Player
@onready var aim_indicator: Line2D = %AimIndicator
@onready var enemies: Node2D = %Enemies


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")


func _input(event: InputEvent) -> void:
	if !is_instance_valid(player):
		aim_indicator.clear_points()
		return
			
	if event is InputEventMouseButton: _perform_bow_action(event)
	if event is InputEventMouseMotion and aiming: _refresh_aim_indicator(event)
		

func _perform_bow_action(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_pull_bow(event)
	elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
		_release_bow(event)


func _refresh_aim_indicator(event: InputEventMouseMotion) -> void:
	aim_indicator.clear_points()
	aim_indicator.add_point(pull_position)
	aim_indicator.add_point(event.position)


func _pull_bow(event: InputEventMouseButton) -> void:
	aiming = true
	pull_position = event.position


func _release_bow(event: InputEventMouseButton) -> void:
	aim_indicator.clear_points()
	aiming = false
	_shoot_arrow(event.position)


func _shoot_arrow(release_position: Vector2) -> void:
	var arrow := arrow_scene.instantiate() as Arrow
	var drag_direction : Vector2 = (pull_position - release_position)
	var direction = drag_direction.normalized()
	var power = drag_direction.length()

	arrow.power = power
	arrow.direction = direction
	arrow.global_position = player.global_position

	add_child(arrow)
