extends Node



func _ready() -> void:
	Signals.restart_game.connect(restart_game)
	


func _process(delta: float) -> void:
	
	$GUI/ScoreLabel.text = str(Globals.player_score)
	$GUI/ScoreBoard/ScoreLabel.text = str(Globals.player_score)
	$GUI/ScoreBoard/BestScoreLabel.text = str(Globals.player_best_score)
	
	if(Globals.game_state == "playing"):
		$GUI/ScoreLabel.visible = true
	else:
		$GUI/ScoreLabel.visible = false
	if(Globals.game_state == "dead"):
		$GUI/ScoreBoard.visible = true
	else:
		$GUI/ScoreBoard.visible = false
	


func restart_game() -> void:
	
	Globals.game_state = "pre-game"
	
	$Player/Body.reset()
	for wall in $Walls.get_children():
		wall.reset()
	
	Globals.player_score = 0
	




