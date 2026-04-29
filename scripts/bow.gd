class_name Bow
extends Node2D


signal arrow_damaged
signal arrow_healed(amount: float)
signal charge_changed


const ARROW_START_POSITION = Vector2.ZERO
const TRAJECTORY_COLORS: Dictionary[bool, Color] = {
	true: Color.GRAY,
	false: Color.DIM_GRAY,
}


enum Facing { LEFT, RIGHT }


@export var arrow_speed_baseline := 900.0
@export var arrow_gravity_modifier := 800.0
@export var charge_duration = 0.5
@export var max_charge = 1.0
@export var trajectory_points := 200
@export var trajectory_precision := 20.0


var arrow_scene: Resource
var arrow_velocity: Vector2
var charging: bool
var charge: float: set = _set_charge
var upgrades: Array[BaseArrowStrategy]


@onready var trajectory: Line2D = %Trajectory
@onready var charged_audio_player: AudioStreamPlayer2D = %ChargedAudioPlayer
@onready var pull_audio_player: AudioStreamPlayer2D = %PullAudioPlayer
@onready var release_audio_player: AudioStreamPlayer2D = %ReleaseAudioPlayer


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")


func _process(delta: float) -> void:
	if charging:
		var charge_increase: float = delta / charge_duration
		charge = clamp(charge + charge_increase, 0, max_charge)
	else:
		charge = 0


func pull() -> void:
	charging = true
	pull_audio_player.play(0.1)


func aim(direction: Vector2, power: float):	
	arrow_velocity = arrow_speed_baseline * power * direction
	_draw_trajectory()


func release() -> void:
	pull_audio_player.stop()
	_clear_trajectory()
	_release_bow()


func _release_bow() -> void:
	release_audio_player.play(0.25)
	_shoot_arrow()
	charging = false


func _clear_trajectory() -> void:
	trajectory.clear_points()

func _set_charge(new_value: float) -> void:
	if charge == new_value: return
	charge = new_value
	charge_changed.emit(charge, max_charge)
	if charge == max_charge: charged_audio_player.play()


func _draw_trajectory():
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
	arrow.damage_modifier = charge
	arrow.velocity = arrow_velocity
	arrow.gravity_modifier = arrow_gravity_modifier
	arrow.global_position = ARROW_START_POSITION
	for upgrade in upgrades: upgrade.apply_strategy(arrow)
	arrow.arrow_damaged.connect(_on_arrow_damaged)
	arrow.healed.connect(_on_arrow_healed)

	add_child(arrow)

	arrow_velocity = Vector2.ZERO


func _on_arrow_damaged(arrow_position: Vector2, area: HurtboxComponent, impact_velocity: Vector2) -> void:
	arrow_damaged.emit(arrow_position, area, impact_velocity)


func _on_arrow_healed(amount: float) -> void:
	arrow_healed.emit(amount)
