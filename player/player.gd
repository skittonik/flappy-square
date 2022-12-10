extends CharacterBody2D


const MIN_VELOCITY_Y = -500
const MAX_VELOCITY_Y = 500

var gravity = 1500

var jump_strength = 1000
@onready var start_position = global_position


func _process(delta: float) -> void:
	
	if(Input.is_action_just_pressed("ui_click")):
		if(Globals.game_state == "pre-game"):
			Globals.game_state = "playing"
			$AnimationPlayer.stop()
		if(Globals.game_state == "pre-game" or Globals.game_state == "playing"):
			velocity.y -= jump_strength
		if(Globals.game_state == "dead"):
			Signals.restart_game.emit()
	


func _physics_process(delta: float) -> void:
	
	if(Globals.game_state == "playing" or Globals.game_state == "dead"):
		velocity.y += gravity * delta
		velocity.y = clamp(velocity.y, MIN_VELOCITY_Y, MAX_VELOCITY_Y)
		move_and_slide()
		rotate_player()
	


func rotate_player():
	
	if(velocity.y > 260 and velocity.y != 0):
		rotation += 0.04
	elif(velocity.y < 260 and velocity.y != 0):
		rotation -= 0.04
	
	rotation = clamp(rotation, -0.4, 0.4)
	


func reset():
	
	global_position = start_position
	rotation = 0
	$AnimationPlayer.play("bobbing")
	


func collect_points():
	Globals.player_score += 1
	


func game_over():
	
	if(Globals.player_score > Globals.player_best_score):
		Globals.player_best_score = Globals.player_score
	
	Globals.game_state = "dead"


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_collision_layer_value(2) and Globals.game_state == "playing"):
		collect_points()
	else:
		game_over()




