extends Area2D

signal money_pickup

func _on_body_entered(body):
	money_pickup.emit()
	queue_free()
