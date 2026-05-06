@tool
class_name UpgradeButton
extends Button

@export var upgrade: PlayerUpgrade


func _ready() -> void:
	if upgrade:
		%NameLabel.text = upgrade.name
		%DescriptionLabel.text = upgrade.description
