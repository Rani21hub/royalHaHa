extends Node2D
	
func _process(delta):
	$"Top Bar/Score".text = str(Global.player_score)
	if Global.is_loading:
		$"Top Bar/Timer".text = str(int(60))
		$"Control/Kings Dialouge/AnimationPlayer".play("Loading")
	else:
		$"Control/Kings Dialouge/AnimationPlayer".stop(true)
		$"Top Bar/Timer".text = str(int($"Top Bar/Timer2".time_left))
	

var opt_jokes = []
var opt_jokes_size = opt_jokes.size()

func _which_joke_choosed(id):
	var choosen_joke = $Control/MenuButton.get_popup().get_item_text(id)
	$"Control/Player Dialouge/Message".text = choosen_joke
	for joke in opt_jokes:
		if joke["joke"] == choosen_joke and int(joke["rate"]) >= 5:
			Global.remove_joke(joke)
			$"Control/Kings Dialouge/AnimationPlayer/Message".text = Global.approving_responses[int(rand_range(0.0, 4.0))]
			$Control/MenuButton.get_popup().remove_item(id)
			$"Control/Kings Dialouge/Sprite".texture = preload("res://ASSETS/Images/4x/King-Smile.png")
			$"Control/Player Dialouge/Sprite2".texture = preload("res://ASSETS/Images/4x/Player-Joking.png")
			Global.player_score += int(joke["rate"])
			$"Top Bar/Timer2".start(60)
			update_list_item()
		elif Global.life_count >= 1 and int(joke["rate"]) < 5:
			Global.life_count -= 1
			$"Control/Kings Dialouge/AnimationPlayer/Message".text = Global.disapproving_responses[int(rand_range(0.0, 4.0))]
			$"Control/Kings Dialouge/Sprite".texture = preload("res://ASSETS/Images/4x/king-disapointed.png")
			$"Control/Player Dialouge/Sprite2".texture = preload("res://ASSETS/Images/4x/Player-Annoied.png")
			Global.player_score += int(joke["rate"])
		elif Global.life_count == 0  and int(joke["rate"]) < 5:
			$"Control/Kings Dialouge/Sprite".texture = preload("res://ASSETS/Images/4x/king-mad.png")
			$"Control/Player Dialouge/Sprite2".texture = preload("res://ASSETS/Images/4x/player-angry.png")
			game_over()
		
		match Global.life_count:
			1:
				$"Top Bar/Heart".texture = preload("res://ASSETS/Images/4x/life-count0.png")
			2:
				$"Top Bar/Heart".texture = preload("res://ASSETS/Images/4x/life-count1.png")
			3:
				$"Top Bar/Heart".texture = preload("res://ASSETS/Images/4x/life-count2.png")
			

func _ready():
	$"Restart with connection".visible = false
	$"Restart with connection".show_on_top = true
	$"Background Music".play(0)
	$"Control/Kings Dialouge"
	$"Control/Kings Dialouge".show()
	$"Control/Player Dialouge".show()
	$Control/MenuButton.get_popup().connect("id_pressed", self, '_which_joke_choosed')
	if !Global.is_loading:
		Global.is_loading = true
		$HTTPRequest.request(Global.url)
	print("loading in progress")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		$"Control/Kings Dialouge/AnimationPlayer/Message".text = 'Tell Me A Joke That Can Make Me Laugh.'
		$"Restart with connection".visible = false
		var json = JSON.parse(body.get_string_from_utf8())
		Global.is_loading = false
		Global.jokes = Global.filter_jokes(json.result)
		print("Loading Completed")
		opt_jokes = Global.random_jokes(Global.jokes)
		$"Top Bar/Timer2".start(60)
		update_list_item()
	else:
		$"Restart with connection".show_on_top = true
		$"Restart with connection".visible = true

func update_list_item():
	opt_jokes = Global.random_jokes(Global.jokes)
	$Control/MenuButton.get_popup().clear()
	for i in range(len(opt_jokes)):
		$"Control/MenuButton".get_popup().add_item(opt_jokes[i]['joke'], i)

func game_over():
	$"Control/Kings Dialouge/Sprite".texture = preload("res://ASSETS/Images/4x/king-mad.png")
	$"Control/Player Dialouge/Sprite2".texture = preload("res://ASSETS/Images/4x/player-angry.png")
	$"End".play(0)
	print(Global.player_score)
	get_tree().change_scene("res://GameOver.tscn")
	Global.life_count = 3
	


func _on_exit_pressed():
	$"Start Button".play(0)
	get_tree().change_scene("res://Main.tscn")


func _on_Start_pressed():
	$"Start Button".play(0)
	get_tree().change_scene("res://Scenes/Game.tscn")
