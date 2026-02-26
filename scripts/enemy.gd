class_name Enemy
extends Area2D


enum State { NULL, HOVERING, ATTACKING, RETREATING }


const MAX_OVERSHOOT_DISTANCE = 3.0
const MAX_HOVER_DISTANCE = 50.0
const ATTACKING_SPEED = 350.0
const ACCELERATION = 8.0
const HOVERING_SPEED = 25.0


@export var initial_state: State


var state: State = State.NULL: set = _set_state
var home_position: Vector2
var attack_target_position: Vector2
var moving_towards_target := false
var move_target_position := Vector2.DOWN
var target_speed: float
var velocity: Vector2
var hover_direction = Vector2.UP


@onready var attacking_timer: Timer = %AttackingTimer


func _ready() -> void:
	home_position = global_position
	state = initial_state


func _process(delta: float) -> void:
	position += velocity * delta

	if not moving_towards_target: return

	if _is_reached(move_target_position):
		_on_target_reached()
	else:
		_update_moving_speed(delta)


func _set_state(new_value = State) -> void:
	if state == new_value: return

	match new_value:
		State.HOVERING: _on_hovering_state_entered()
		State.ATTACKING: _on_attacking_state_entered()
		State.RETREATING: _on_retreating_state_entered()

	state = new_value


func _is_reached(target_position: Vector2) -> bool:
	return global_position.distance_to(target_position) <= MAX_OVERSHOOT_DISTANCE


func _start_moving_towards(target_global_position: Vector2, speed: float) -> void:
	moving_towards_target = true
	move_target_position = target_global_position
	target_speed = speed


func _stop_moving() -> void:
	velocity = Vector2.ZERO
	moving_towards_target = false


func _move_to_hover_point() -> void:
	_start_moving_towards(
		home_position + hover_direction * MAX_HOVER_DISTANCE, 
		HOVERING_SPEED
	)


func _refresh_hover_direction() -> void:
	if not _is_reached(home_position):
		hover_direction = hover_direction * Vector2.UP


func _update_moving_speed(delta) -> void:
	var direction := global_position.direction_to(move_target_position)
	velocity = velocity.lerp(direction * target_speed, 1 - exp(-ACCELERATION * delta))


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		area.damage()


func _on_hovering_state_entered() -> void:
	_move_to_hover_point()
	attacking_timer.start()


func _on_attacking_state_entered() -> void:
	_start_moving_towards(
		attack_target_position,
		ATTACKING_SPEED
	)


func _on_retreating_state_entered() -> void:
	_start_moving_towards(
		home_position,
		ATTACKING_SPEED
	)


func _on_hover_point_reached() -> void:
	_refresh_hover_direction()
	_move_to_hover_point()


func _on_attacking_timer_timeout() -> void:
	state = State.ATTACKING


func _on_target_reached() -> void:
	match state:
		State.HOVERING:
			_on_hover_point_reached()
		State.ATTACKING:
			global_position = move_target_position
			_stop_moving()
			state = State.RETREATING
		State.RETREATING:
			global_position = move_target_position
			_stop_moving()
			state = State.HOVERING
