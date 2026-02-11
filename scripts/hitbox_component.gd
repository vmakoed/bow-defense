extends Area2D
class_name HitboxComponent


func damage():
	get_parent().queue_free()
