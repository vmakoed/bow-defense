class_name ShielderPair
extends Node


var enemy: Enemy
var shielder: Enemy


@onready var connection_line: ConnectionLine = %ConnectionLine


func _ready() -> void:
	connection_line.enemy_position = enemy.global_position
	connection_line.shielder_position = shielder.global_position
	enemy.died.connect(_on_either_died)
	shielder.died.connect(_on_either_died)
	enemy.moved.connect(_on_enemy_moved)
	shielder.moved.connect(_on_shielder_moved)


func _on_either_died() -> void:
	queue_free()


func _on_enemy_moved() -> void:
	connection_line.enemy_position = enemy.global_position


func _on_shielder_moved() -> void:
	connection_line.shielder_position = shielder.global_position
