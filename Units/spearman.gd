extends CharacterBody2D

@export var selected = false
@onready var box = get_node("Box")
#@onready var anim = get_node("AnimationPlayer")

@onready var targetPos = position
var follow_cursor = false
var Speed = 50


func _ready():
	set_selected(selected)
	
func set_selected(value):
	selected = value
	box.visible = value

func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false
		
func _physics_process(delta):
	if follow_cursor == true:
		if selected:
			targetPos = get_global_mouse_position()
			#anim.play("Walk")
	velocity = position.direction_to(targetPos) * Speed
	if position.distance_to(targetPos) > 25:
		move_and_slide()
	else:
		#anim.stop()
		pass
