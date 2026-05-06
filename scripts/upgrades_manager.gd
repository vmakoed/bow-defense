extends PanelContainer
class_name UpgradesManager


@export var healing_upgrade: PlayerUpgrade
@export var piercing_upgrade: PlayerUpgrade


@onready var healing_button: CheckButton = %HealButton
@onready var piercing_button: CheckButton = %PierceButton


func _ready() -> void:
	_set_upgrade_button(healing_button, PlayerStats.has_upgrade(healing_upgrade))
	_set_upgrade_button(piercing_button, PlayerStats.has_upgrade(piercing_upgrade))
	PlayerStats.upgrade_added.connect(_on_upgrade_added)
	PlayerStats.upgrade_removed.connect(_on_upgrade_removed)


func _toggle_upgrade(upgrade: PlayerUpgrade, toggled_on: bool) -> void:
	if toggled_on: 
		PlayerStats.add_upgrade(upgrade)
	else:
		PlayerStats.remove_upgrade(upgrade)


func _set_upgrade_button(button: CheckButton, pressed: bool):
	button.set_pressed_no_signal(pressed)


func _on_upgrade_toggled(upgrade: PlayerUpgrade, toggled: bool) -> void:
	if upgrade == healing_upgrade: _set_upgrade_button(healing_button, toggled)
	if upgrade == piercing_upgrade: _set_upgrade_button(piercing_button, toggled)


func _on_upgrade_added(upgrade: PlayerUpgrade) -> void:
	_on_upgrade_toggled(upgrade, true)


func _on_upgrade_removed(upgrade: PlayerUpgrade) -> void:
	_on_upgrade_toggled(upgrade, false)


func _on_heal_button_toggled(toggled_on: bool) -> void:
	_toggle_upgrade(healing_upgrade, toggled_on)


func _on_pierce_button_toggled(toggled_on: bool) -> void:
	_toggle_upgrade(piercing_upgrade, toggled_on)
