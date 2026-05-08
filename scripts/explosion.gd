extends Area2D


const DURATION = 0.3
const FINAL_SCALE = Vector2(15.0, 15.0)
const KNOCKBACK_STRENGTH = 250.0


var damage_amount = 3.0


func _ready() -> void:
	%CollisionShape2D.scale = FINAL_SCALE
	await get_tree().physics_frame
	for area in get_overlapping_areas():
		if area is HurtboxComponent:
			area.damage(_get_damage(area.global_position))

	var tween = get_tree().create_tween()
	tween.tween_property(%RectArea, "scale", FINAL_SCALE, DURATION).from_current()
	tween.parallel().tween_property(%RectArea, "modulate", Color.TRANSPARENT, DURATION).from_current()
	tween.tween_callback(queue_free)


func _get_damage(target_position: Vector2) -> Damage:
	var damage = Damage.new()
	damage.amount = damage_amount
	var direction = global_position.direction_to(target_position)
	damage.knockback = direction * KNOCKBACK_STRENGTH
	print(damage.knockback)
	return damage

