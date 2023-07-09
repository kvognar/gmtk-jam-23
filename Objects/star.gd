extends AnimatedSprite2D

var velocity: int

func _ready():
	velocity = randi_range(50, 300)
	frame = randi_range(0,15)
	position.x = randi_range(0,600)
	position.y = randi_range(0,900)

func _process(delta):
	if position.y > get_viewport_rect().size.y + 10:
		position.y = -10
		frame = randi_range(0,15)
		velocity = randi_range(50, 300) 
	
	position.y += velocity * delta
