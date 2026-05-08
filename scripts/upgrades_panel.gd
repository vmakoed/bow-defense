extends PanelContainer
class_name UpgradesPanel


@export var upgrades_manager: UpgradesManager


var upgrade_buttons: Dictionary[PlayerUpgrade, UpgradeCheckButton] = {}
var upgrades: Array[PlayerUpgrade]: set = _set_upgrades


@onready var upgrades_container: VBoxContainer = %UpgradesContainer


func _ready() -> void:
	upgrades = upgrades_manager.upgrades
	PlayerStats.upgrade_added.connect(_on_upgrade_added_from_outside)
	PlayerStats.upgrade_removed.connect(_on_upgrade_removed_from_outside)


func _set_upgrades(values: Array[PlayerUpgrade]) -> void:
	_clear_upgrade_toggles()
	for upgrade in values: _add_upgrade_toggle(upgrade)


func _add_upgrade_toggle(upgrade: PlayerUpgrade) -> void:
	var upgrade_toggle := UpgradeCheckButton.new()
	upgrade_buttons[upgrade] = upgrade_toggle
	upgrade_toggle.upgrade = upgrade
	upgrade_toggle.toggled.connect(
		func(toggled_on: bool): _on_upgrade_toggled(upgrade, toggled_on)
	)
	upgrades_container.add_child(upgrade_toggle)


func _clear_upgrade_toggles()-> void:
	for toggle in upgrades_container.get_children(): toggle.queue_free()


func _on_upgrade_toggled(upgrade: PlayerUpgrade, toggled_on: bool) -> void:
	if toggled_on: 
		PlayerStats.add_upgrade(upgrade)
	else:
		PlayerStats.remove_upgrade(upgrade)


func _on_upgrade_toggled_from_outside(upgrade: PlayerUpgrade, toggled: bool) -> void:
	upgrade_buttons[upgrade].set_pressed_no_signal(toggled)


func _on_upgrade_added_from_outside(upgrade: PlayerUpgrade) -> void:
	_on_upgrade_toggled_from_outside(upgrade, true)


func _on_upgrade_removed_from_outside(upgrade: PlayerUpgrade) -> void:
	_on_upgrade_toggled_from_outside(upgrade, false)
