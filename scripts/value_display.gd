extends Node2D


func _ready() -> void:
	%ValueLabel.hide()


func _setup(label: Label, amount: float, value_position: Vector2, value_sign: String) -> void:
	label.text = "{sign}{amount}".format({
		"sign": value_sign,
		"amount": str(int(amount))
	})
	label.global_position = value_position


func _animate(label: Label) -> void:
	var tween = create_tween()
	tween.tween_property(
		label,
		"position",
		label.position + Vector2(0, -10),
		1.0
	).from_current()
	tween.tween_property(
		label,
		"modulate",
		Color(1, 1, 1, 0.0),
		1.0
	).from_current()
	tween.finished.connect(func(): label.queue_free())


func show_value_label(amount: float, value_position: Vector2, value_sign := "") -> void:
	var label : Label = %ValueLabel.duplicate()
	_setup(label, amount, value_position, value_sign)
	add_child(label)
	label.show()
	_animate(label)
