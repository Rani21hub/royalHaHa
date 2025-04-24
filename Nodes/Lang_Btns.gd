extends Control

func _ready():
	$Amh.hide()
	$Eng.pressed = true

func _on_Eng_pressed():
	if $Amh.pressed :
		$Amh.pressed = false
	$Eng.pressed = true
	Global.is_amharic = false
	
func _on_Amh_pressed():
	if $Eng.pressed:
		$Eng.pressed= false;
	$Amh.pressed = true
	Global.is_amharic = true
