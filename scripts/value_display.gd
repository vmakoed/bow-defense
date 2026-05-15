extends Node2D


func _ready() -> void:
	%ValueLabel.hide()


func _setup(label: Label, value: float, value_position: Vector2, value_sign: String) -> void:
	label.text = "{sign}{value}".format({
		"sign": value_sign,
		"value": _cast(value)

	})
	label.global_position = value_position - Vector2(label.size.x / 2, 0)


func _animate(label: Label) -> void:
	var tween = create_tween()
	tween.tween_property(
		label,
		"global_position",
		label.global_position + Vector2(0, -10),
		1.0
	).from_current()
	tween.tween_property(
		label,
		"modulate",
		Color(1, 1, 1, 0.0),
		1.0
	).from_current()
	tween.finished.connect(func(): label.queue_free())


func _cast(value: float) -> String:
	var int_value = int(value)
	if value == float(int_value):
		return str(int_value)
	else:
		return str(snappedf(value, 0.1))


func show_value_label(value: float, value_position: Vector2, value_sign := "") -> void:
	var label: Label = %ValueLabel.duplicate()
	_setup(label, value, value_position, value_sign)
	add_child(label)
	label.show()
	_animate(label)
