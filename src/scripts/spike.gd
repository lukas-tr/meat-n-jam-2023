extends Area2D

signal spike

func _on_body_entered(body):
	spike.emit()
