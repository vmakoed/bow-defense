extends PanelContainer
class_name UpgradesManager


@export var healing_strategy: BaseArrowStrategy


var healing_enabled: bool


func arrow_strategies() -> Array[BaseArrowStrategy]:
	var value: Array[BaseArrowStrategy] = []
	if healing_enabled: value.push_back(healing_strategy)
	return value


func _on_heal_button_toggled(toggled_on: bool) -> void:
	healing_enabled = toggled_on

