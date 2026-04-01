extends CharacterBody2D

@export var tileSize = 40 # pixels / tile

@export var xAcc = 20 # tiles / second^2
@export var XDec = 10 # tiles / second^2
@export var gravity = 20 # tiles / second^2

@export var maxXVel = 5 # tiles / second
@export var maxYVel = 5 # tiles / second

var acc = Vector2(0, 0) # tiles / second^2
var vel = Vector2(0, 0) # tiles / second

func _physics_process(delta):
	acc = Vector2(0, 0)
	
	acc.y = gravity
	
	vel += acc * delta
	
	velocity = vel * tileSize
	move_and_slide()
