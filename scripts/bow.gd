extends Node2D
class_name Bow


const ARROW_START_POSITION = Vector2.ZERO


enum Facing { LEFT, RIGHT }


signal facing_changed


@export var arrow_speed_baseline := 1200.0
@export var arrow_gravity_modifier := 800
@export var power_baseline := 600.0


var arrow_scene: Resource
var pull_position: Vector2
var arrow_velocity: Vector2


var facing: Facing = Facing.LEFT: set = _set_facing


@onready var trajectory: Line2D = %Trajectory


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")


func pull(hand_position: Vector2) -> void:
	pull_position = hand_position


func release() -> void:
	trajectory.clear_points()
	_shoot_arrow()


func refresh_trajectory(hand_position: Vector2) -> void:
	var drag_direction: Vector2 = (pull_position - hand_position)
	
	if drag_direction.x > 0:
		facing = Facing.RIGHT
	else:
		facing = Facing.LEFT

	var gravity_vector := Vector2(0.0, arrow_gravity_modifier)

	trajectory.clear_points()
	trajectory.add_point(ARROW_START_POSITION)
	arrow_velocity = arrow_speed_baseline * (drag_direction.length() / power_baseline) * drag_direction.normalized()

	for step in range(20):
		var time_offset := step / 10.0
		var point_position: Vector2 = ARROW_START_POSITION + (arrow_velocity * time_offset) + (0.5 * gravity_vector * (time_offset)**2)
		trajectory.add_point(point_position)


func _set_facing(new_value: Facing) -> void:
	if facing != new_value:
		facing = new_value
		facing_changed.emit(facing)
		


func _shoot_arrow() -> void:
	var arrow := arrow_scene.instantiate() as Arrow
	arrow.velocity = arrow_velocity
	arrow.gravity_modifier = arrow_gravity_modifier
	arrow.global_position = ARROW_START_POSITION

	add_child(arrow)

	pull_position = Vector2.ZERO
	arrow_velocity = Vector2.ZERO
