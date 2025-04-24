extends Node


func _ready():
	$AcceptDialog.visible = false
	$AcceptDialog/CanvasLayer.visible = false
	$"Menu Bg".play(0)
	$Connect.hide()
	$Start.disabled = true
	CheckConnection.connect("connection_success", self, "_on_success")
	CheckConnection.connect("error_connection_failed", self, "_on_failure")
	CheckConnection.connect("error_ssl_handshake", self, "_on_fail_ssl_handshake")
	pass 

func _on_Button_pressed():
	$"Start Button".play(0)
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_exit_pressed():
	get_tree().quit(0)


func _on_success():
	print("Connection Success!!")
	$Start.disabled = false
	

func _on_failure(code, message):
	$Start.disabled = true
	$Start.hide()
	$Connect.show()

func _on_fail_ssl_handshake():
	print("SSL Handshake Error!!")

func _on_About_pressed():
	if $AcceptDialog.visible == false and $AcceptDialog/CanvasLayer.visible == false:
		$AcceptDialog.visible = true
		$AcceptDialog/CanvasLayer.visible = true
	else:
		$AcceptDialog/CanvasLayer.visible = false
		$AcceptDialog.visible = false


func _on_AcceptDialog_confirmed():
	$AcceptDialog/CanvasLayer.visible = false
	$AcceptDialog.visible = false


func _on_AcceptDialog_popup_hide():
	$AcceptDialog/CanvasLayer.visible = false
	$AcceptDialog.visible = false
