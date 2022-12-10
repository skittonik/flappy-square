extends Node2D


var wall_width = 80
var rnd: RandomNumberGenerator = RandomNumberGenerator.new()

@onready var start_position = global_position


func _ready() -> void:
	
	rnd.randomize()
	set_wall_height()
	


func _physics_process(delta: float) -> void:
	
	if(Globals.game_state == "playing"):
		global_position.x -= Globals.scroll_speed * delta
		
		if(global_position.x < -(wall_width / 2)):
			global_position.x += get_viewport_rect().size.x + wall_width
			set_wall_height()
	


func set_wall_height() -> void:
	
	var min_wall_height = 120
	var max_wall_height = 448
	
	global_position.y = rnd.randi_range(min_wall_height, max_wall_height)


func reset():
	global_position = start_position
	set_wall_height()



