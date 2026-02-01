extends HBoxContainer
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().root.find_child("player", true, false)
	if player:
		player.health_changed.connect(_on_health_updated)

func _on_health_updated(current_health): 
	for i in range(get_child_count()):
		var mask = get_child(i)
		if i < current_health:
			mask.play("default")
			mask.modulate.a = 1.0 # Fully visible
		else:
			if mask.animation != "lose":
				mask.play("lose")
				mask.modulate.a = 0.3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_F) : player.takedamage(1)
	pass
