extends Area2D

signal jump

func _on_body_entered(body):
	jump.emit()
