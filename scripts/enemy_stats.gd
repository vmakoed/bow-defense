class_name EnemyStats
extends Resource


enum SpawnStrategy { BASE, SHIELD, BOSS }


@export var attack_cooldown := 5.0
@export var attacking_speed := 250.0
@export var color := Color.BLUE
@export var damage := 50.0
@export var max_health := 100.0
@export var scale := Vector2(1.0, 1.0)
@export var shield := false
@export var spawn_strategy := SpawnStrategy.BASE
@export var weight := 1.0
