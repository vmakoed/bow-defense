extends Line2D
class_name ConnectionLine


const ENEMY_POSITION_INDEX = 0
const SHIELDER_POSITION_INDEX = 1


var enemy_position: Vector2: set = _set_enemy_position
var shielder_position: Vector2: set = _set_shielder_position


func _ready() -> void:
	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)


func _set_enemy_position(value: Vector2) -> void:
	enemy_position = value
	set_point_position(ENEMY_POSITION_INDEX, enemy_position)


func _set_shielder_position(value: Vector2) -> void:
	shielder_position = value
	set_point_position(SHIELDER_POSITION_INDEX, shielder_position)
