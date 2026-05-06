extends Node


signal upgrade_added(upgrade: PlayerUpgrade)
signal upgrade_removed(upgrade: PlayerUpgrade)


@export var upgrades: Array[PlayerUpgrade]


func add_upgrade(upgrade: PlayerUpgrade) -> void:
	if has_upgrade(upgrade): return
	upgrades.append(upgrade)
	upgrade_added.emit(upgrade)


func get_arrow_strategies() -> Array[BaseArrowStrategy]:
	var result: Array[BaseArrowStrategy] = []
	for upgrade in upgrades: result.append(upgrade.strategy)
	return result


func has_upgrade(upgrade: PlayerUpgrade) -> bool: 
	return upgrades.has(upgrade)


func remove_upgrade(upgrade: PlayerUpgrade) -> void:
	if not has_upgrade(upgrade): return
	upgrades.erase(upgrade)
	upgrade_removed.emit(upgrade)
