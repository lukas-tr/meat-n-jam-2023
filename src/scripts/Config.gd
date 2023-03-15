extends Node

const DEFAULT_SECTION = "config"

var _max_distance = 0
var _money = 0
var _cannon_level = 0
var _jump_level = 0

var max_distance = 0:
	set(val):
		_max_distance = val
		save_config()
	get:
		return _max_distance

var money = 0:
	set(val):
		_money = val
		save_config()
	get:
		return _money

var jump_level = 0:
	set(val):
		_jump_level = val
		save_config()
	get:
		return _jump_level

var cannon_level = 0:
	set(val):
		_cannon_level = val
		save_config()
	get:
		return _cannon_level

func _ready():
	load_config()

func save_config():
	var config = ConfigFile.new()

	config.set_value(DEFAULT_SECTION, "max_distance", _max_distance)
	config.set_value(DEFAULT_SECTION, "money", _money)
	config.set_value(DEFAULT_SECTION, "cannon_level", _cannon_level)
	config.set_value(DEFAULT_SECTION, "jump_level", _jump_level)

	config.save("user://config_user.cfg")

func load_config():
	var config = ConfigFile.new()
	var err = config.load("user://config_user.cfg")
	if err != OK:
		return
	
	_max_distance = config.get_value(DEFAULT_SECTION, "max_distance", 0)
	_money = config.get_value(DEFAULT_SECTION, "money", 0)
	_cannon_level = config.get_value(DEFAULT_SECTION, "cannon_level", 0)
	_jump_level = config.get_value(DEFAULT_SECTION, "jump_level", 0)
	
	
