extends Node


@export var upgrades_menu_packed: PackedScene
@export var upgrades_manager: UpgradesManager


var upgrades_menu: Node


func _ready() -> void:
	upgrades_menu = upgrades_menu_packed.instantiate()
	upgrades_menu.hide()
	get_tree().current_scene.call_deferred("add_child", upgrades_menu)


func show() -> void:
	if upgrades_menu.visible: return
	upgrades_menu.show()


func _on_upgrade_reached() -> void:
	var available_upgrades := upgrades_manager.get_available_upgrades(
		GameConfig.upgrade_selection_limit
	)

	if available_upgrades.is_empty(): return
	upgrades_menu.upgrades = available_upgrades
	show()	
