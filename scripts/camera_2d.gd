extends Camera2D


const MIN_SHAKE_OFFSET = -8.0
const MAX_SHAKE_OFFSET = 8.0
const SHAKE_RESTORE_DURATION = 0.2


var tween: Tween


func shake() -> void:
	tween = create_tween()
	offset = Vector2(
		randf_range(MIN_SHAKE_OFFSET, MAX_SHAKE_OFFSET),
		randf_range(MIN_SHAKE_OFFSET, MAX_SHAKE_OFFSET)
	)

	tween.tween_property(
		self,
		"offset",
		Vector2.ZERO,
		SHAKE_RESTORE_DURATION
	).from_current()
