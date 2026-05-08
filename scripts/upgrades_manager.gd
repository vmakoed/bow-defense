class_name UpgradesManager
extends Node


@export var upgrades: Array[PlayerUpgrade]


func get_available_upgrades(limit: int) -> Array[PlayerUpgrade]:
	var available_upgrades: Array[PlayerUpgrade] = []

	for upgrade in upgrades:
		if not PlayerStats.has_upgrade(upgrade): available_upgrades.append(upgrade)
		if available_upgrades.size() == limit: break
		
	return available_upgrades
