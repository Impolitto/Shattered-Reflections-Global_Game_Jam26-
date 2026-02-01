extends CharacterBody2D
@export var dash_cooldown = 1.25
@onready var dashTimer:Timer = Timer.new()
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_collision = $"attack area/CollisionShape2D"
@export var SPEED = 300.0
var attack_range = 75;
@export var  light_attack_dmg = 10
@export var light_attack_timer = 0.5 
var is_attacking = false ;
var  jumping = false 
var  isdashing = false 
var state= "idle"
var jumpcount:int
@export var  JUMP_VELOCITY = -400.0
@export var dashforce = 2000

func _ready() : 
	jumpcount = 0 
	dashTimer.one_shot = true 
	dashTimer.wait_time = 0.2
	attack_collision.set_deferred("disabled", true)
func jump () : 
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			 
			velocity.y = JUMP_VELOCITY
			jumpcount = 1   # first jump
			jumping = true 
		elif jumpcount < 2: # allow one extra jump in air
			jumping = true 
			velocity.y = JUMP_VELOCITY /1.3
			jumpcount += 1
			
		
func changeState(new_state) : 
	if state !=new_state : 
		state = new_state
		animated_sprite.play(state)
func hande_anim () :
	
	if is_on_floor(): jumping = false  
	if isdashing :  return 
	if is_attacking : return 
	if jumping and !isdashing: changeState("jump")
	elif Input.get_axis("left","right") !=0 and !isdashing and !is_attacking : 
		changeState("move")
	else : 
		changeState("idle")
	
	# jump state 
	
func flipcharacter () : 
	var axis = Input.get_axis("left","right")
	
	if axis < 0 and is_on_floor() : 
		animated_sprite.flip_h = true 
	elif axis >0 and is_on_floor() : 
		animated_sprite.flip_h = false 
		
		
func _process(delta: float) -> void:
	flipcharacter()
	hande_anim()
	light_attack()
	print("Hitbox Disabled: ", attack_collision.disabled)


func dash():
	var dir 
	if animated_sprite.flip_h : dir = -1
	elif animated_sprite.flip_h == false : dir =1
	
	if Input.is_action_just_pressed("dash") && !isdashing && Input.get_axis("left","right") == 0  :
		isdashing = true 
		velocity.x = dashforce * dir
		changeState("dash")
		await 	get_tree().create_timer(dash_cooldown).timeout
		isdashing = false
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		


	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
	else:		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	dash()
	jump()
func light_attack (): 
	if Input.is_action_just_pressed("light_attack") and !is_attacking and Input.get_axis("left","right") ==0  : 
		changeState("light1")
		attack_collision.disabled = false
		
		is_attacking = true 
		await get_tree().create_timer(light_attack_timer).timeout
		is_attacking = false
		attack_collision.disabled = true
		velocity.x = 0
		
	

func _on_attack_area_area_entered(area: Area2D) -> void:
	print("wa") # Replace with function body.
