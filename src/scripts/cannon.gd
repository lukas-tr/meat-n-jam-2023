extends Area2D

signal spawn_player

func _ready():
	spawn_player.emit()
	periodic_rotation()
	
func periodic_rotation():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", PI/2, 1).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "rotation", 0, 1).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(periodic_rotation)
