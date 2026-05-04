extends Node2D


var points: Array[Vector2]: set = set_points


func _draw() -> void:
	for index in range(0, points.size(), 2):
		draw_circle(points[index], 3.0, Color.WHITE)


func set_points(value: Array[Vector2]) -> void:
	points = value
	queue_redraw()
