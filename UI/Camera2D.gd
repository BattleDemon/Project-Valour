extends Camera2D

var mousePos = Vector2()

var mousePosGlobal = Vector2()
var start = Vector2()
var startV = Vector2()
var end = Vector2()
var endV = Vector2()
var isDragging = false
signal area_selected
signal start_move_selection
var is_moving_up = false
var is_moving_down = false
var is_moving_left = false
var is_moving_right = false

@onready var box = get_node("../UI/Panel")

func _ready():
	connect("area_selected", Callable(get_parent(), "_on_area_selected"))


func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
	
	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
		
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV = mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			end = start
			isDragging = false
			draw_area(false)
	if is_moving_down == true:
		if self.zoom > Vector2(1.25,1.25):
			self.position = self.position + Vector2(0,10) 
		else:
			self.position = self.position + Vector2(0,10) * (Vector2(.5,.5) + self.zoom)
		
	if is_moving_up == true:
		if self.zoom > Vector2(1.25,1.25):
			self.position = self.position - Vector2(0,10)
		else:
			self.position = self.position - Vector2(0,10) * (Vector2(.5,.5) + self.zoom)
		
	if is_moving_left == true:
		if self.zoom > Vector2(1.25,1.25):
			self.position = self.position - Vector2(10,0)
		else:
			self.position = self.position - Vector2(10,0) * (Vector2(.5,.5) + self.zoom)
		
	if is_moving_right == true:
		if self.zoom > Vector2(1.25,1.25):
			self.position = self.position + Vector2(10,0)
		else:
			self.position = self.position + Vector2(10,0) * (Vector2(.5,.5) + self.zoom)


func _input(event):
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()
		if event.is_pressed():
			if event.is_action("Scroll up"):
				if self.zoom < Vector2(3, 3):
					self.zoom = self.zoom + Vector2(.1, .1)
			elif event.is_action("Scroll down"):
				if self.zoom > Vector2(.5, .5):
					self.zoom = self.zoom - Vector2(.1, .1)
					
	if event.is_action_pressed("W"):
		is_moving_up = true
		
	elif event.is_action_pressed("A"):
		is_moving_left = true
		
	elif event.is_action_pressed("D"):
		is_moving_right = true
		
	elif event.is_action_pressed("S"):
		is_moving_down = true
		
	if event.is_action_released("W"):
		is_moving_up = false
		
	elif event.is_action_released("A"):
		is_moving_left = false
		
	elif event.is_action_released("D"):
		is_moving_right = false
		
	elif event.is_action_released("S"):
		is_moving_down = false
		

func draw_area(s=true):
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)
	
