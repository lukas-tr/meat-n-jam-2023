extends CanvasLayer

signal start_game

func update_distance(distance):
	distance /= 10
	$DistanceLabel.text = str(round(distance)) + " m" if distance < 1000 else "%.2f km" % (distance / 1000)

func update_speed(speed):
	$SpeedLabel.text = str(round(speed / 10)) + " km/h"

func update_jumps(jumps):
	$JumpsLabel.text = "%d Jumps" % jumps
