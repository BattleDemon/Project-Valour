extends TileMap

var moisture = FastNoiseLite.new()
var temperture = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var width = 150
var height = 150

@onready var player = Vector2(0,0)
@onready var tree = "res://world Objects/Environment Objects/Tree.tscn"

func _ready():
	moisture.seed = randi()
	temperture.seed = randi()
	altitude.seed = randi()
	
func _process(delta):
	generate_chunk(player)
	
func generate_chunk(position):
	var tilePos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var moist = moisture.get_noise_2d(tilePos.x - width/2 + x, tilePos.y - height/2 + y)*10
			var temp = temperture.get_noise_2d(tilePos.x - width/2 + x, tilePos.y - height/2 + y)*10
			var alt = altitude.get_noise_2d(tilePos.x + x - width/2, tilePos.y - height/2 + y)*10
			
			set_cell(0, Vector2i(tilePos.x - width/2 + x, tilePos.y - height/2 + y), 0, Vector2(round((moist+10)/5), round((temp+10)/5)))
