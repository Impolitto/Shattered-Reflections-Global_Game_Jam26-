extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible=false
	 # Replace with function body.
@onready
var panel =get_node("Panel")
var seen=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		if(Input.is_action_just_pressed("PAUSE") and seen==false):
			panel.visible=true
			print("panel visible")
			seen=true
		else:
			if(Input.is_action_just_pressed("PAUSE")and seen==true):
				panel.visible=false
				print("panel unvisible")
				seen=false
			
			
			


func _on_resume_pressed() -> void:
	panel.visible=false
	print("Resumed")
	seen=false # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn") # Replace with function body.
