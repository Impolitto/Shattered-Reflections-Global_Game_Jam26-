extends Camera2D
@onready var player: CharacterBody2D = $"../CharacterBody2D"




@export var lookahead = 20
# Called when the node enters the scene tree for the first time.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = player.global_position + Vector2(lookahead,0) 
	position = position.lerp(target ,delta *22.0)
