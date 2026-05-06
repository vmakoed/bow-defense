extends Node


@export var upgrades_menu_packed: PackedScene


var upgrades_menu: Node


func _ready() -> void:
	upgrades_menu = upgrades_menu_packed.instantiate()
	upgrades_menu.hide()
	get_tree().current_scene.call_deferred("add_child", upgrades_menu)


func show() -> void:
	if upgrades_menu.visible: return
	upgrades_menu.show()
