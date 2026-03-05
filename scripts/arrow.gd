class_name Arrow
extends Area2D


@export var damage_amount := 40.0
@export var knockback_factor := 0.2


var gravity_modifier: float
var velocity: Vector2


@onready var clear_timer: Timer = %ClearTimer
@onready var hit_sound_player: AudioStreamPlayer2D = %HitSoundPlayer
@onready var collision_shape: CollisionShape2D = %CollisionShape2D


func _process(delta: float) -> void:
	velocity.y += gravity_modifier * delta
	rotation = velocity.angle()
	position += velocity * delta


func _get_damage() -> Damage:
	var damage = Damage.new()
	damage.amount = damage_amount
	damage.knockback = velocity * knockback_factor
	return damage


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	clear_timer.start()
	

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		clear_timer.stop()
		hit_sound_player.play()
		visible = false
		collision_shape.set_deferred("disabled", true)
		area.damage(_get_damage())


func _on_clear_timer_timeout() -> void:
	queue_free()


func _on_hit_sound_player_finished() -> void:
	queue_free()
