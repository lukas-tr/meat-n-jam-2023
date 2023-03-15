extends CanvasLayer

func _ready():
	$CannonBar.value = $Config.cannon_level
	$JumpsBar.value = $Config.jump_level
	var distance = $Config.max_distance / 10
	$MaxDistanceLabel.text = "Best Distance: " + (str(round(distance)) + " m" if distance < 1000 else "%.2f km" % (distance / 1000))
	_update_money()

func _on_upgrade_cannon_button_pressed():
	if $Config.money >= 10:
		$Config.money -= 10
		$Config.cannon_level += 1
		$CannonBar.value = $Config.cannon_level
		_update_money()

func _on_upgrade_jumps_button_pressed():
	if $Config.money >= 10:
		$Config.money -= 10
		$Config.jump_level += 1
		$JumpsBar.value = $Config.jump_level
		_update_money()

func _update_money():
	$MoneyLabel.text = "Money: %d" % $Config.money
	


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
