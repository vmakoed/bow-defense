class_name Enemy
extends BaseEnemy


signal moved


enum State { NULL, FLYING_IN, HOVERING, ATTACKING, RETREATING }
enum AttackDirection { LEFT, RIGHT }


const ACCELERATION = 4.0
const ATTACK_DIRECTION_VECTORS: Dictionary[AttackDirection, Vector2] = {
	AttackDirection.LEFT: Vector2.LEFT,
	AttackDirection.RIGHT: Vector2.RIGHT
}
const MAX_HOVER_DISTANCE = 50.0
const MAX_OVERSHOOT_DISTANCE = 3.0
const HOVERING_SPEED = 50.0



@export var initial_state: State
@export var area_shield_scene := preload("res://scenes/enemy_area_shield.tscn")


var area_shield: Area2D
var attack_target_position: Vector2: set = _set_attack_target_position
var attack_direction: AttackDirection
var attacking_speed: float
var damage_amount: float
var home_position: Vector2
var hover_direction = Vector2.UP
var move_target_position := Vector2.DOWN
var moving_towards_target := false
var self_destruct := false
var state: State = State.NULL: set = _set_state
var target_speed: float
var velocity: Vector2


@onready var attacking_timer: Timer = %AttackingTimer
@onready var color_rect: ColorRect = %ColorRect


func _ready() -> void:
	super()
	attacking_speed = enemy_stats.attacking_speed
	attacking_timer.wait_time = enemy_stats.attack_cooldown
	color_rect.color = enemy_stats.color
	damage_amount = enemy_stats.damage
	scale = enemy_stats.scale
	if not enemy_stats.shield: %Shield.queue_free()
	state = initial_state
	
	var direction = _target_direction_vector()
	var shield_center: Vector2 = global_position + (direction * 50.0)
	%Shield.global_position = shield_center
	%Shield.rotation = direction.angle() + PI / 2


func _process(delta: float) -> void:
	var position_change: Vector2 = velocity * delta
	position += position_change
	if not position_change == Vector2.ZERO: moved.emit()
	_move_towards_target(delta)


func add_area_shield(shielder: Enemy) -> void:
	area_shield = area_shield_scene.instantiate() as HurtboxComponent
	area_shield.scale = enemy_stats.scale * 1.2
	shielder.killed.connect(remove_area_shield)
	add_child(area_shield)


func remove_area_shield() -> void:
	area_shield.queue_free()


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
	velocity = velocity.lerp(direction * attacking_speed, ACCELERATION * delta)	# TODO: target speed replaced with attacking speed


func _move_in_attack_direction() -> void:
	_start_moving_towards(
		attack_target_position,
		attacking_speed
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
	damage.source_global_position = global_position
	return damage


func _on_flying_in_state_entered() -> void:
	_start_moving_towards(
		home_position,
		attacking_speed
	)


func _on_hovering_state_entered() -> void:
	_move_to_hover_point()
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


func _on_hover_point_reached() -> void:
	_refresh_hover_direction()
	_move_to_hover_point()


func _on_attacking_timer_timeout() -> void:
	state = State.ATTACKING


func _on_target_reached() -> void:
	self_destruct = true
	health_component.health = 0


func _on_health_component_health_below_minimum() -> void:
	if not self_destruct: killed.emit()
	died.emit()


func _on_area_entered(area: Area2D) -> void:
	if area is not HurtboxComponent: return
	if state != State.ATTACKING: return

	area.damage(_get_damage())
	_on_target_reached()


func _on_health_component_damaged(damage: Damage) -> void:
	velocity += damage.knockback / enemy_stats.weight
	damaged.emit(damage)
