extends PauseMenuLayer


var upgrades: Array[PlayerUpgrade]: set = set_upgrades


func set_upgrades(values: Array[PlayerUpgrade]) -> void:
	pause_menu.upgrades = values
