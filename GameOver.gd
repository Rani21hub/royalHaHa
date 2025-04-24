extends Node2D

func _ready():
	
	$Control/Score.text = str(Global.player_score)

func _on_Start_pressed():
	$"Control/Start Button".play(0)
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_exit_pressed():
	$"Control/Start Button".play(0)
	get_tree().change_scene("res://Main.tscn")
