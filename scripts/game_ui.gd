extends Control


func _ready() -> void:
	%BossUIContainer.hide()
	%HealthBar.max_value = GameConfig.max_player_health

	GameUIBridge.boss_ready.connect(_on_boss_ready)
	GameUIBridge.charge_bar_value_changed.connect(_on_charge_bar_value_changed)
	GameUIBridge.controls_label_hide_requested.connect(_on_controls_label_hide_requested)
	GameUIBridge.level_lost.connect(_on_level_lost)
	GameUIBridge.level_started.connect(_on_level_started)
	GameUIBridge.level_won.connect(_on_level_lost)
	GameUIBridge.player_health_changed.connect(_on_player_health_changed)
	GameUIBridge.value_display_requested.connect(%ValueDisplay.show_value_label)
	GameUIBridge.signed_value_display_requested.connect(%ValueDisplay.show_value_label)


func _on_boss_ready(health_component: HealthComponent) -> void:
	%BossUIContainer.show()
	health_component.health_bar = %BossHealthBar


func _on_level_lost() -> void:
	%VirtualJoystickPlus.active = false
	%JoystickLayer.visible = false


func _on_level_started() -> void:
	%JoystickLayer.visible = true
	%VirtualJoystickPlus.active = true


func _on_level_won() -> void:
	%VirtualJoystickPlus.active = false
	%JoystickLayer.visible = false


func _on_charge_bar_value_changed(new_value: float) -> void:
	%ChargeBar.value = new_value


func _on_controls_label_hide_requested() -> void:
	%ControlsLabel.hide()


func _on_player_health_changed(new_value: float) -> void:
	%HealthBar.value = new_value


func _on_virtual_joystick_plus_analogic_changed(value: Vector2, distance: float, angle: float, angle_clockwise: float, angle_not_clockwise: float) -> void:
	GameUIBridge.virtual_joystick_plus_analogic_changed.emit(value, distance, angle, angle_clockwise, angle_not_clockwise)


func _on_virtual_joystick_plus_pressed() -> void:
	GameUIBridge.virtual_joystick_plus_pressed.emit()


func _on_virtual_joystick_plus_released() -> void:
	GameUIBridge.virtual_joystick_plus_released.emit()
