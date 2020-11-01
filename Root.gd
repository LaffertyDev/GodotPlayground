extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var noise = OpenSimplexNoise.new()
	
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	var width = 1024
	var height = 768
	var image = Image.new()
	image.create(width, height, false, Image.FORMAT_RGBA8)
	image.lock()
	for x in range(0, width):
		for y in range(0, height):
			var noiseComponent = (noise.get_noise_2d(x, y) + 1.0) / 2
			var r = noiseComponent
			var g = noiseComponent
			var b = noiseComponent
			if (noiseComponent < 0.5):
				b = 1.0
				r = 0.0
				g = 0.0
			
			image.set_pixel(x, y, Color(r, g, b, 1.0))
	
	var tex = ImageTexture.new()
	tex.create_from_image(image)
	tex.resource_name = "I created this"
	$Sprite.texture = tex
