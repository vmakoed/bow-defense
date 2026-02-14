extends Node2D


const LEFT_BOW_POSITION = 520.0
const RIGHT_BOW_POSITION = 632.0


@export var arrow_speed_baseline := 1200.0
@export var arrow_gravity_modifier := 800
@export var power_baseline := 600.0


var arrow_scene: Resource
var aiming: bool = false


@onready var player: CharacterBody2D = %Player
@onready var bow: Bow = %Bow
@onready var aim_indicator: Line2D = %AimIndicator
@onready var enemies: Node2D = %Enemies


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")
	_start_enemy_movement()


func _input(event: InputEvent) -> void:
	if !is_instance_valid(player):
		aim_indicator.clear_points()
		return
			
	if event is InputEventMouseButton: _perform_bow_action(event)
	if event is InputEventMouseMotion and aiming: 
		_refresh_aim_indicator(event) 
		bow.refresh_trajectory(event.position)


func _start_enemy_movement() -> void:
	for enemy: Enemy in enemies.get_children():
		var direction := enemy.global_position.direction_to(player.global_position)
		enemy.move_to(direction)


func _perform_bow_action(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		aiming = true
		bow.pull(event.position)
	elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
		aiming = false
		aim_indicator.clear_points()
		bow.release()


func _refresh_aim_indicator(event: InputEventMouseMotion) -> void:
	aim_indicator.clear_points()
	aim_indicator.add_point(bow.pull_position)
	aim_indicator.add_point(event.position)


func _on_bow_facing_changed(facing: Bow.Facing) -> void:
	if facing == Bow.Facing.LEFT:
		bow.position.x = LEFT_BOW_POSITION
	else:
		bow.position.x = RIGHT_BOW_POSITION
