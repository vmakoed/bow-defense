extends PanelContainer


@onready var score_label: Label = %ScoreLabel
@onready var wave_label: Label = %WaveLabel


@export var spawner: Node


func update_score(new_value: int) -> void:
	%ScoreLabel.text = str(new_value)


func update_spawn_time_label(new_value: float) -> void:
	%SpawnTimeLabel.text = str(snappedf(new_value, 0.1))


func _on_stats_update_timer_timeout() -> void:
	update_spawn_time_label(spawner.get_time_left())
