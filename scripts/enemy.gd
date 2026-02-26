class_name Enemy
extends Area2D


enum State { HOVERING, ATTACKING, RETREATING }


const MAX_OVERSHOOT_DISTANCE = 1.0
const MAX_HOVER_DISTANCE = 50.0


var state: set = _set_state
var home_position: Vector2
var attack_target_position: Vector2
var moving_towards_target := false
var move_target_position: Vector2
var velocity: Vector2
var attacking_speed := 125.0
var hovering_speed := 25.0


@onready var hover_point_timer: Timer = %HoverPointTimer
@onready var attacking_timer: Timer = %AttackingTimer


func _ready() -> void:
	home_position = global_position
	state = State.HOVERING


func _process(delta: float) -> void:
	position += velocity * delta

	if moving_towards_target && _at_move_target_position():
		match state:
			State.HOVERING:
				print("reached")
				_stop_moving()
				hover_point_timer.start()
			State.ATTACKING:
				_stop_moving()
				state = State.RETREATING
			State.RETREATING:
				_stop_moving()
				state = State.HOVERING


func _at_move_target_position() -> bool:
	return global_position.distance_to(move_target_position) <= MAX_OVERSHOOT_DISTANCE


func _start_moving_towards(target_global_position: Vector2, speed: float) -> void:
	print("started moving")
	moving_towards_target = true
	move_target_position = target_global_position
	velocity = speed * global_position.direction_to(move_target_position)


func _stop_moving() -> void:
	velocity = Vector2.ZERO
	moving_towards_target = false


func _set_state(new_value = State) -> void:
	if state == new_value:
		return

	if state == State.HOVERING:
		_on_hovering_state_exited()

	match new_value:
		State.HOVERING: _on_hovering_state_entered()
		State.ATTACKING: _on_attacking_state_entered()
		State.RETREATING: _on_retreating_state_entered()

	state = new_value


func _on_hovering_state_entered() -> void:
	hover_point_timer.start()
	attacking_timer.start()


func _on_attacking_state_entered() -> void:
	_start_moving_towards(
		attack_target_position,
		attacking_speed
	)


func _on_retreating_state_entered() -> void:
	_start_moving_towards(
		home_position,
		attacking_speed
	)


func _on_hovering_state_exited() -> void:
	hover_point_timer.stop()
	velocity = Vector2.ZERO
		

func _move_to_hover_point() -> void:
	var direction = Vector2.from_angle(randf() * 2 * PI).normalized()
	var distance = randf() * MAX_HOVER_DISTANCE
	var offset: Vector2 = direction * distance
	var hover_point: Vector2 = home_position + offset

	_start_moving_towards(
		hover_point,
		hovering_speed
	)


func _on_hover_point_timer_timeout() -> void:
	_move_to_hover_point()


func _on_attacking_timer_timeout() -> void:
	state = State.ATTACKING
