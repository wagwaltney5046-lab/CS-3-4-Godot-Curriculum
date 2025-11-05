# This next line allows the color of the coin to update without running the game
# It can mostly be ignored, but it must be the first line of the script
@tool

extends Area2D
class_name pickup

@export var color: Color
@export var amount : int = 1
@export var type : String = ""
@export var label : String = ""
@export var auto_pickup : bool = true
var collected: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	# Set the color of the pickup
	if $AnimatedSprite2D.material != null:
		$AnimatedSprite2D.material.set_shader_parameter("color", color)
	configure_pickup(type, label)

func _process(delta: float) -> void:
	
	pass

func _on_body_entered(body):
	if collected == false:
		if body is Player:
			collected = true
			configure_pickup(type, label)
			# Remove the potion after use
			if auto_pickup:
				if $AnimationPlayer.has_animation("disappear"):
					$AnimationPlayer.play("disappear")
				else: queue_free()
			else:
				pass


func configure_pickup(_type : String, _label : String) -> bool:
	if _type == "coin":
		if _label == "copper":
			load("res://resources/coin.tres").number += 5
			return true
		elif _label == "silver":
			load("res://resources/coin.tres").number += 15
			return true
		elif _label == "gold":
			load("res://resources/coin.tres").number += 30
			return true
		else: return false
	elif _type == "health_potion":
		if _label == "small":
			load("res://resources/Health_potion.tres").number += 1
			return true
		elif _label == "large":
			load("res://resources/Major_Health_potion.tres").number += 1
			return true
		else: return false
	else: return false
