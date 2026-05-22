class_name Arrow
extends Area2D


signal arrow_damaged
signal exploded(global_position: Vector2, explosive_damage: float)
signal healed


@export var hit_sound_stream: AudioStream
@export var knockback_factor := 0.5
@export var max_damage_amount := 50.0


var damage_modifier := 1.0
var explosive_damage := 0.0
var gravity_modifier: float
var healing_amount := 0.0
var piercing_amount := 0
var velocity: Vector2


@onready var clear_timer: Timer = %ClearTimer
@onready var collision_shape: CollisionShape2D = %CollisionShape2D


func _process(delta: float) -> void:
	velocity.y += gravity_modifier * delta
	rotation = velocity.angle()
	position += velocity * delta


func _get_damage() -> Damage:
	var damage = Damage.new()
	damage.amount = max_damage_amount * damage_modifier
	damage.knockback = velocity * knockback_factor * damage_modifier
	damage.source_global_position = global_position
	return damage


func invert() -> void:
	modulate = Color.BLACK


func _damage(area: HurtboxComponent) -> void:
	area.damage(_get_damage())
	arrow_damaged.emit(global_position, area, velocity)


func _explode() -> void:
	var total_explosive_damage = explosive_damage * damage_modifier
	if explosive_damage > 0.0: exploded.emit(global_position, total_explosive_damage)


func _heal() -> void:
	if healing_amount > 0.0: healed.emit(healing_amount)


func _pierce() -> void:
	if piercing_amount <= 0:
		visible = false
		collision_shape.set_deferred("disabled", true)
	else:
		piercing_amount -= 1


func _on_arrow_hit(area: HurtboxComponent) -> void:
	clear_timer.stop()
	SfxSoundController.play_audio(hit_sound_stream)
	_pierce()
	_damage(area)
	_heal()
	_explode()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	clear_timer.start()
	

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent: _on_arrow_hit(area)


func _on_clear_timer_timeout() -> void:
	queue_free()

