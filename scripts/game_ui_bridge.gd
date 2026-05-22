extends Node


@export var player_healthbar: ProgressBar


signal boss_ready(health_component: HealthComponent)
signal charge_bar_value_changed(new_value: float)
signal controls_label_hide_requested
signal level_lost
signal level_started
signal level_won
signal player_health_changed(new_value: float)
signal signed_value_display_requested(value: float, value_position: Vector2, value_sign: String)
signal value_display_requested(value: float, value_position: Vector2)
signal virtual_joystick_plus_analogic_changed(value: Vector2, distance: float, angle: float, angle_clockwise: float, angle_not_clockwise: float)
signal virtual_joystick_plus_pressed
signal virtual_joystick_plus_released

