extends AnimatableBody2D
@onready var action_box: Area2D = $action_box


#func set_is_open(is_open: bool) -> void:
	#if is_open == true:
		#$AnimatedSprite2D.frame = 1
		#collision_layer = 1000
		#$LightOccluder2D.visible = false
	#if is_open == false:
		#$AnimatedSprite2D.frame = 0
		#$LightOccluder2D.visible = true

func _on_goon_body_entered(body: Node2D) -> void:
	if body is Player:
		print("open")
		$AnimatedSprite2D.frame = 1


func _on_goon_body_exited(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.frame = 0
		print("close")
