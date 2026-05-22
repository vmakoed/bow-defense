class_name Bow
extends Node2D


signal arrow_fired
signal arrow_damaged(arrow_position: Vector2, area: HurtboxComponent, impact_velocity: Vector2)
signal arrow_exploded(arrow_position: Vector2, explosive_damage: float)
signal arrow_healed(amount: float)
signal trajectory_changed(points: Array[Vector2])


const ARROW_START_POSITION = Vector2.ZERO
const TRAJECTORY_COLORS: Dictionary[bool, Color] = {
	true: Color.GRAY,
	false: Color.DIM_GRAY,
}


enum Facing { LEFT, RIGHT }


@export var arrow_speed_baseline := 900.0
@export var arrow_gravity_modifier := 800.0
@export var charge_bar: ProgressBar
@export var charge_duration = 0.5
@export var max_charge = 1.0
@export var trajectory_points := 200
@export var trajectory_precision := 25.0


var arrow_scene: Resource
var arrow_velocity: Vector2
var charging: bool
var charge: float: set = _set_charge
var gravity_vector


@onready var charged_audio_player: AudioStreamPlayer2D = %ChargedAudioPlayer
@onready var pull_audio_player: AudioStreamPlayer2D = %PullAudioPlayer
@onready var release_audio_player: AudioStreamPlayer2D = %ReleaseAudioPlayer


func _ready() -> void:
	arrow_scene = preload("res://scenes/arrow.tscn")
	gravity_vector = Vector2(0.0, arrow_gravity_modifier)


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
	release_audio_player.play(0.25)
	_shoot_arrow()
	_reset()


func _reset() -> void:
	arrow_velocity = Vector2.ZERO
	charging = false


func _set_charge(new_value: float) -> void:
	if charge == new_value: return
	charge = new_value
	GameUIBridge.charge_bar_value_changed.emit(charge / max_charge * 100.0)
	if charge == max_charge: 
		charged_audio_player.play()
		# %ChargedRect.show()
	# else:
		# %ChargedRect.hide()


func _clear_trajectory() -> void:
	trajectory_changed.emit(Array([], TYPE_VECTOR2, "", null))


func _draw_trajectory():
	trajectory_changed.emit(_get_trajectory_points())


func _get_trajectory_points() -> Array[Vector2]:
	return Array(range(trajectory_points).map(func(step: int):
		var time_offset: float = step / trajectory_precision
		return ARROW_START_POSITION + \
			(arrow_velocity * time_offset) + \
			(0.5 * gravity_vector * (time_offset)**2)
	), TYPE_VECTOR2, "", null)


func _shoot_arrow() -> void:
	var arrow := arrow_scene.instantiate() as Arrow
	arrow.damage_modifier = charge
	arrow.velocity = arrow_velocity
	arrow.gravity_modifier = arrow_gravity_modifier
	arrow.global_position = ARROW_START_POSITION

	for upgrade in PlayerStats.get_arrow_strategies(): upgrade.apply_strategy(arrow)

	arrow.arrow_damaged.connect(_on_arrow_damaged)
	arrow.exploded.connect(_on_arrow_exploded)
	arrow.healed.connect(_on_arrow_healed)
	
	add_child(arrow)
	arrow_fired.emit()


func _on_arrow_exploded(arrow_position: Vector2, explosive_damage: float) -> void:
	arrow_exploded.emit(arrow_position, explosive_damage)


func _on_arrow_damaged(arrow_position: Vector2, area: HurtboxComponent, impact_velocity: Vector2) -> void:
	arrow_damaged.emit(arrow_position, area, impact_velocity)


func _on_arrow_healed(amount: float) -> void:
	arrow_healed.emit(amount)
