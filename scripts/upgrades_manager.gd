extends PanelContainer
class_name UpgradesManager


@export var healing_strategy: BaseArrowStrategy
@export var piercing_strategy: BaseArrowStrategy


var healing_enabled: bool
var piercing_enabled: bool


func arrow_strategies() -> Array[BaseArrowStrategy]:
	var value: Array[BaseArrowStrategy] = []
	_append_strategy(value, healing_enabled, healing_strategy)
	_append_strategy(value, piercing_enabled, piercing_strategy)
	return value


func _append_strategy(strategies: Array[BaseArrowStrategy], strategy_flag: bool, strategy: BaseArrowStrategy) -> void:
	if not strategy_flag: return
	if not strategy: return
	strategies.append(strategy)


func _on_heal_button_toggled(toggled_on: bool) -> void:
	healing_enabled = toggled_on


func _on_pierce_button_toggled(toggled_on: bool) -> void:
	piercing_enabled = toggled_on
