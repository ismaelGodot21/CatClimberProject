extends Node2D

#onready var barradecarga = $ui/pantalla_carga

var level_trhead = Thread.new()
var load_percent = 0


func _ready():
#	load_game()
	
	
#func load_game():
#	level_trhead.start(self, "build_level", null, 1)
#	setup_character()
	
#func setup_character():
#	load_percent += 50
#	$ui/pantalla_carga.update_percent(load_percent)
	
#func build_level(empty):
#	load_percent += 50
#	$ui/pantalla_carga.update_percent(load_percent)
	
#	level_trhead.wait_to_finish()
#	pass
# Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	pass


func _on_Button2_pressed():
	get_tree().change_scene("res://niveles/nivel 1/nivel1.tscn")
	pass # Replace with function body.


func _on_opciones_pressed():
	get_tree().change_scene("res://niveles/opciones.tscn")
	pass # Replace with function body.


func _on_salir_pressed():
	get_tree().quit()
	pass # Replace with function body.
