@tool
extends OverlaidWindow


@onready var heal_button: UpgradeButton = %HealUpgradeButton
@onready var pierce_button: UpgradeButton = %PierceUpgradeButton


func _ready() -> void:
	_set_upgrade_button_visibility(heal_button, !PlayerStats.has_upgrade(heal_button.upgrade))
	_set_upgrade_button_visibility(pierce_button, !PlayerStats.has_upgrade(pierce_button.upgrade))
	PlayerStats.upgrade_added.connect(_on_upgrade_added)
	PlayerStats.upgrade_removed.connect(_on_upgrade_removed)


func _set_upgrade_button_visibility(button: UpgradeButton, value: bool):
	button.visible = value


func _on_heal_upgrade_button_pressed() -> void:
	_on_upgrade_button_pressed(heal_button.upgrade)


func _on_pierce_upgrade_button_pressed() -> void:
	_on_upgrade_button_pressed(pierce_button.upgrade)


func _on_upgrade_toggled(upgrade: PlayerUpgrade, toggled: bool) -> void:
	if upgrade == heal_button.upgrade: _set_upgrade_button_visibility(heal_button, !toggled)
	if upgrade == pierce_button.upgrade: _set_upgrade_button_visibility(pierce_button, !toggled)


func _on_upgrade_added(upgrade: PlayerUpgrade) -> void:
	_on_upgrade_toggled(upgrade, true)


func _on_upgrade_button_pressed(upgrade: PlayerUpgrade) -> void:
	PlayerStats.add_upgrade(upgrade)
	close()


func _on_upgrade_removed(upgrade: PlayerUpgrade) -> void:
	_on_upgrade_toggled(upgrade, false)
