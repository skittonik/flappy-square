extends StaticBody2D


func _process(delta: float) -> void:
	
	if(Globals.game_state != "dead"):
		global_position.x -= Globals.scroll_speed * delta
		
		if global_position.x < -640:
			global_position.x += 2560
	





