extends CharacterBody2D
class_name Player


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var rotation_speed: float = 50.0
@export var move_speed: float = 200.0
@export var maxHealth : int = 200
@export var health : int = 10
@onready var action_box: Area2D = $action_box
@export var inv_List:Array[inventory_item]
var facing: Vector2 = Vector2.ZERO
var inv_active:bool = false
var potion_icon = load("res://assets/2D Pixel Dungeon Asset Pack/items and trap_animation/flasks/flasks_1_1.png")
var Health_potion = load("res://resources/Health_potion.tres")
var coins = load("res://resources/coin.tres")
var coin_icon = load("res://assets/2D Pixel Dungeon Asset Pack/items and trap_animation/coin/coin_1.png")
var M_Health_potion = load("res://resources/Major_Health_potion.tres")

var item_id:int = 0

func _ready():
	inv_add()
	print("Player is ready!")
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(_delta):
	if Input.is_action_just_pressed("inventory"):
		display_inv()
	if inv_active == true:
		inv_add()
		interact()
		handle_movement()

func handle_movement():
	# Get input direction from arrow keys
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	handle_sprite(direction)

	
	# Normalize diagonal movement to prevent speed boost
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement using Godot's built-in physics
	velocity = direction * move_speed
	move_and_slide()

# BAD QUICK CODE MAYBE CHANGE
func handle_sprite(direction: Vector2) -> void:
	var prefix: String = "walk"
	if direction == Vector2.ZERO:
		prefix = "idle"
	else:
		facing = direction
		
	if facing.y > 0:
		animated_sprite.play(prefix + "_forward")
		action_box.position = Vector2(0, 15)
	elif facing.y < 0:
		animated_sprite.play(prefix + "_backward")
		action_box.position = Vector2(0, -15)
	elif facing.x < 0:
		animated_sprite.play(prefix + "_side")
		action_box.position = Vector2(-15, 0)
		animated_sprite.flip_h = true
	elif facing.x > 0:
		animated_sprite.play(prefix + "_side")
		action_box.position = Vector2(15, 0)
		animated_sprite.flip_h = false





func heal(minor_major:int):
	if minor_major == 1:
		if Health_potion.number > 0:
			health += 20
			Health_potion.number -= 1
	elif minor_major == 2:
		if M_Health_potion.number > 0:
			health += 100
			M_Health_potion.number -= 1
	if health > maxHealth:
		health = maxHealth
	print("Health: " + str(health))


func display_inv():
	if inv_active == false:
		$ItemList.visible = true
		$ItemList.auto_width = true
		$ItemList.fixed_icon_size = Vector2i(30,30)
		inv_add()
		inv_active = true
	else:
		$ItemList.visible = false
		inv_active = false

func inv_add():
	$ItemList.clear()
	$ItemList.add_item("Health Potion (" + str(Health_potion.number) + ")", potion_icon)
	$ItemList.add_item("Major Health Potion ("+ str(M_Health_potion.number) + ")", potion_icon)
	$ItemList.add_item("coins (" + str(coins.number) + ")", coin_icon)
	$ItemList.select(item_id)
	

func interact():
	if Input.is_action_just_pressed("left_inventory"):
		item_id -= 1 
		$ItemList.select(item_id)
	if Input.is_action_just_pressed("right_inventory"):
		item_id += 1 
		$ItemList.select(item_id)
	if Input.is_action_just_pressed("use_inventory"):
		if $ItemList.is_selected(0):
			heal(1)
		if $ItemList.is_selected(1):
			heal(2)




# TODO: Add character methods here (Lesson 2)

# - level_up()
# - attack()


func die():
	print("You died!")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
