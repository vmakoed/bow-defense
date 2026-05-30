extends Node2D


signal level_lost
signal level_won


func _ready() -> void:
	GameUIBridge.level_started.emit()


func _on_level_won() -> void:
	level_won.emit()
	GameUIBridge.level_won.emit()


func _on_level_lost() -> void:
	level_lost.emit()
	GameUIBridge.level_lost.emit()
