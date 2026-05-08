@tool
extends OverlaidWindow


@onready var upgrades_container: BoxContainer = %UpgradesContainer


var upgrades: Array[PlayerUpgrade]: set = set_upgrades


@export var upgrade_button_packed: PackedScene


func _ready() -> void:
	upgrades = []


func set_upgrades(values: Array[PlayerUpgrade]) -> void:
	_clear_upgrade_buttons()
	for upgrade in values: _add_upgrade_button(upgrade)


func _add_upgrade_button(upgrade: PlayerUpgrade) -> void:
	var upgrade_button: UpgradeButton = upgrade_button_packed.instantiate()
	upgrade_button.upgrade = upgrade
	upgrade_button.pressed.connect(func(): _on_upgrade_button_pressed(upgrade))
	upgrades_container.add_child(upgrade_button)


func _clear_upgrade_buttons() -> void:
	for child in upgrades_container.get_children(): child.queue_free()


func _on_upgrade_button_pressed(upgrade: PlayerUpgrade) -> void:
	PlayerStats.add_upgrade(upgrade)
	close()
