extends Area2D
var interact = false
@onready var action_box: Area2D = $action_box
@onready var Chest = get_node("Chest")


func play_animation(reverse: bool = false) -> void:
	var speed: int
	if reverse:
		speed = -1
	else:
		speed = 1
	$AnimatedSprite2D.play("", speed, reverse)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and interact == false:
		interact = true
		print("has entered")
		play_animation()
		Chest.animate_opening()
		
		
		
