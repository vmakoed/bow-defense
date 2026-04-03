extends ProgressBar


@export var charging_stylebox: StyleBoxFlat
@export var charged_stylebox: StyleBoxFlat


func _ready() -> void:
	_apply_charging_stylebox()


func _apply_charging_stylebox() -> void:
	add_theme_stylebox_override("background", charging_stylebox)


func _on_bow_charge_changed(charge: float, max_charge: float) -> void:
	value = charge / max_charge * 100.0
	if value == 100.0:
		add_theme_stylebox_override("background", charged_stylebox)
	else:
		_apply_charging_stylebox()


