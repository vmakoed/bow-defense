class_name Enemy
extends Area2D


signal died


enum State { NULL, FLYING_IN, HOVERING, ATTACKING, RETREATING }
enum AttackDirection { LEFT, RIGHT }


const MAX_OVERSHOOT_DISTANCE = 3.0
const MAX_HOVER_DISTANCE = 50.0
const ATTACKING_SPEED = 350.0
const ACCELERATION = 4.0
const HOVERING_SPEED = 50.0
const ATTACK_DIRECTION_VECTORS: Dictionary[AttackDirection, Vector2] = {
	AttackDirection.LEFT: Vector2.LEFT,
	AttackDirection.RIGHT: Vector2.RIGHT
}


@export var initial_state: State
@export var damage_amount := 45.0


var state: State = State.NULL: set = _set_state
var home_position: Vector2
var attack_target_position: Vector2: set = _set_attack_target_position
var attack_direction: AttackDirection
var moving_towards_target := false
var move_target_position := Vector2.DOWN
var target_speed: float
var velocity: Vector2
var hover_direction = Vector2.UP


@onready var attacking_timer: Timer = %AttackingTimer


func _ready() -> void:
	state = initial_state


func _process(delta: float) -> void:
	position += velocity * delta

	match state:
		State.ATTACKING: _move_in_attack_direction(delta)
		_: _move_towards_target(delta)


func _set_state(new_value: State) -> void:
	if state == new_value: return

	match new_value:
		State.FLYING_IN: _on_flying_in_state_entered()
		State.HOVERING: _on_hovering_state_entered()
		State.ATTACKING: _on_attacking_state_entered()
		State.RETREATING: _on_retreating_state_entered()

	state = new_value


func _set_attack_target_position(new_value: Vector2) -> void:
	if attack_target_position == new_value: return
	attack_target_position = new_value
	
	if attack_target_position.x > home_position.x:
		attack_direction = AttackDirection.RIGHT
	else:
		attack_direction = AttackDirection.LEFT


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


func _target_direction_vector() -> Vector2:
	return global_position.direction_to(move_target_position)


func _move_in_direction(direction: Vector2, delta: float) -> void:
	velocity = velocity.lerp(direction * target_speed, ACCELERATION * delta)


func _move_in_attack_direction(delta) -> void:
	_move_in_direction(
		 ATTACK_DIRECTION_VECTORS.get(attack_direction, Vector2.ZERO),
		 delta
	)


func _move_towards_target(delta) -> void:
	if not moving_towards_target: return

	if _is_reached(move_target_position):
		_on_target_reached()
	else:
		_move_in_direction(
			_target_direction_vector(),
			delta
		)


func _get_damage() -> Damage:
	var damage = Damage.new()
	damage.amount = damage_amount
	return damage


func _on_flying_in_state_entered() -> void:
	_start_moving_towards(
		home_position,
		ATTACKING_SPEED
	)


func _on_hovering_state_entered() -> void:
	_move_to_hover_point()
	attacking_timer.start()


func _on_attacking_state_entered() -> void:
	target_speed = ATTACKING_SPEED


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
		State.FLYING_IN, State.RETREATING:
			global_position = move_target_position
			_stop_moving()
			state = State.HOVERING
		State.HOVERING:
			_on_hover_point_reached()
		State.ATTACKING:
			_stop_moving()
			state = State.RETREATING


func _on_health_component_health_below_minimum() -> void:
	died.emit()
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is not HurtboxComponent: return
	if state != State.ATTACKING: return

	area.damage(_get_damage())
	_on_target_reached()


func _on_health_component_damaged(damage: Damage) -> void:
	velocity += damage.knockback
