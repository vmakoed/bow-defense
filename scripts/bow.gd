class_name Bow
extends Node2D


signal facing_changed


const ARROW_START_POSITION = Vector2.ZERO


enum Facing { LEFT, RIGHT }


@export var arrow_speed_baseline := 800.0
@export var arrow_gravity_modifier := 800.0
@export var trajectory_points := 40
@export var trajectory_precision := 20.0


var arrow_scene: Resource
var arrow_velocity: Vector2
var facing: Facing = Facing.LEFT: set = _set_facing


@onready var trajectory: Line2D = %Trajectory
@onready var pull_audio_player: AudioStreamPlayer2D = %PullAudioPlayer
@onready var release_audio_player: AudioStreamPlayer2D = %ReleaseAudioPlayer


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")


func pull() -> void:
	pull_audio_player.play(0.1)


func aim(direction: Vector2, power: float):	
	_refresh_facing(direction)
	arrow_velocity = arrow_speed_baseline * power * direction
	_redraw_trajectory()


func release() -> void:
	pull_audio_player.stop()
	release_audio_player.play(0.25)
	trajectory.clear_points()
	_shoot_arrow()


func _set_facing(new_value: Facing) -> void:
	if facing != new_value:
		facing = new_value
		facing_changed.emit(facing)


func _refresh_facing(direction: Vector2):
	if direction.x > 0:
		facing = Facing.RIGHT
	else:
		facing = Facing.LEFT


func _redraw_trajectory():
	var gravity_vector := Vector2(0.0, arrow_gravity_modifier)
	trajectory.clear_points()
	trajectory.add_point(ARROW_START_POSITION)

	for step in range(trajectory_points):
		var time_offset := step / trajectory_precision
		trajectory.add_point(
			ARROW_START_POSITION + \
			(arrow_velocity * time_offset) + \
			(0.5 * gravity_vector * (time_offset)**2)
		)


func _shoot_arrow() -> void:
	var arrow := arrow_scene.instantiate() as Arrow
	arrow.velocity = arrow_velocity
	arrow.gravity_modifier = arrow_gravity_modifier
	arrow.global_position = ARROW_START_POSITION

	add_child(arrow)

	arrow_velocity = Vector2.ZERO
