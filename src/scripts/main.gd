extends Node2D

@export var platform_scene: PackedScene
@export var money_scene: PackedScene
@export var trampoline_scene: PackedScene
@export var spike_scene: PackedScene

var last_platform_x_position = -2048

const PLATFORM_SPAWN_OFFSET = Vector2(1024, 250)

var player_launched = false

var jumps_left = 0

func _ready():
	check_platforms()
	$Player.set_process(false)
	$Player.hide()
	$HUD.update_distance(0)
	jumps_left = $Config.jump_level
	update_jumps()

func _physics_process(delta):
	check_platforms()
	update_distance()
	if player_launched and $Player and $Player.get_velocity().length() < 5:
		$Config.max_distance = max($Config.max_distance, $Player.get_position().x)
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _process(delta):
	if Input.is_action_just_released("jump") and not player_launched:
		spawn_player()
	if not player_launched:
		$Player.position = Vector2($Cannon/PlayerSpawn.global_position)

func check_platforms():
	if $Player:
		var player_position = $Player.get_position()
		if player_position.x > last_platform_x_position - PLATFORM_SPAWN_OFFSET.x:
			spawn_platform()
			for i in range(randi_range(0, 5)):
				spawn_coin()
			var r = randi_range(0, 3)
			if player_position.x > 200:
				if r == 0:
					spawn_trampoline()
				elif r == 1:
					spawn_spikes()

func add_money():
	$Config.money += 1

func push_player():
	$Player.velocity += Vector2(500, -500)
	
func spawn_trampoline():
	var coin = trampoline_scene.instantiate()
	coin.jump.connect(push_player)
	coin.position.y = 150
	coin.position.x = $Player.position.x + 2000
	add_child(coin)

func slow_player():
	$Player.velocity.x = $Player.velocity.x * 0.3
	
func spawn_spikes():
	var coin = spike_scene.instantiate()
	coin.spike.connect(slow_player)
	coin.position.y = 150
	coin.position.x = $Player.position.x + 2000
	add_child(coin)

func spawn_coin():
	var coin = money_scene.instantiate()
	coin.money_pickup.connect(add_money)
	coin.position.y = $Player.position.y + randi_range(-800, 800)
	coin.position.x = $Player.position.x + randi_range(1000, 2000)
	add_child(coin)

func spawn_platform():
	var platform = platform_scene.instantiate()
	platform.position.y = PLATFORM_SPAWN_OFFSET.y
	platform.position.x = last_platform_x_position + PLATFORM_SPAWN_OFFSET.x
	last_platform_x_position = platform.position.x
	add_child(platform)

func spawn_player():
	player_launched = true
	$Player.set_process(true)
	$Player.show()
	$Player.position = Vector2($Cannon/PlayerSpawn.global_position)
	$Player.velocity = get_launch_velocity()

func get_launch_velocity():
	return Vector2($Cannon/Target.position).rotated($Cannon/Target.global_rotation) * (1 + $Config.cannon_level)

func update_distance():
	$HUD.update_distance($Player.get_position().x)
	$HUD.update_speed($Player.get_velocity().length())

func update_jumps():
	$HUD.update_jumps(jumps_left)
	if jumps_left <= 0:
		$Player.disable_jump()

func _on_player_on_jump():
	jumps_left -= 1
	update_jumps()

