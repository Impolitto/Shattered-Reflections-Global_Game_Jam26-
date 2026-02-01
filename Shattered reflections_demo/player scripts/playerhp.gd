extends Node2D
signal health_changed(current_health)
@export var  max_health:int = 3
@export var health:int = max_health

# Called when the node enters the scene tree for the first time.



func takedamage(amount): 
	if health > 0 : 
		health -=amount 
		health_changed.emit(health)

func heal(amount) : 
	if health > 0 : 
		health +=amount
		health_changed.emit(health)
func reset_health() : 
	if health > 0 : 
		health = max_health
		health_changed.emit(health)
func _ready() -> void:
	await get_tree().process_frame
	reset_health()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
