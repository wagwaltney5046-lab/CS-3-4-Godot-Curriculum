extends Area2D
var coin = preload("res://scenes/coin.tscn")


func animate_opening() -> void:
	$AnimatedSprite2D.play()
	var _coin = coin.instantiate()
	_coin.position = position - Vector2(0, 0.5)
	get_tree().root.add_child(_coin)
