extends StaticBody2D

signal out_of_view

func _on_visible_on_screen_notifier_2d_screen_exited():
	out_of_view.emit()
	queue_free()
