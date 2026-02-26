extends Area2D
class_name HurtboxComponent


func damage():
	get_parent().queue_free()
