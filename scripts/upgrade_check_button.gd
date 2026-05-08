@tool
class_name UpgradeCheckButton
extends CheckButton


@export var upgrade: PlayerUpgrade: set = _set_upgrade


func _set_upgrade(value: PlayerUpgrade) -> void:
	upgrade = value
	text = value.name
