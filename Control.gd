extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func update_percent(new_percent):
	$Tween.interpolate_property($barra_carga, "value", $barra_carga.value, new_percent, 0.5, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	
	yield($barra_carga, "tween_completed") 
	
	if new_percent == $barra_carga.max_value:
		$carga_anim_pantalla.play("Hide")
		
	
	
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
