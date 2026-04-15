extends CharacterBody2D

@export var tileSize = 40 # pixels / tile

@export var xAcc = 75 # tiles / second^2
@export var xDec = 100 # tiles / second^2
@export var maxXVel = 12 # tiles / second

@export var gravity = 60 # tiles / second^2
@export var jumpVel = 15 # tiles / second
@export var maxYVel = 24 # tiles / second

var groundedTimer = INF
var jumpInputTimer = INF
var jumpTimer = INF

var health = 5
signal playerHit
signal playerDie

func _physics_process(delta):
	var acc = Vector2(0, 0) # tiles / second^2
	var vel = velocity / tileSize # tiles / second
	
	var xInput = 0
	if get_parent().gameActive:
		if Input.is_action_pressed("move_right"):
			xInput += 1
		if Input.is_action_pressed("move_left"):
			xInput += -1
	
	if vel.x > xDec * delta:
		if xInput == 1:
			acc.x = xAcc
		else:
			acc.x = -xDec
	elif vel.x < -xDec * delta:
		if xInput == -1:
			acc.x = -xAcc
		else:
			acc.x = xDec
	else:
		if xInput == 1:
			acc.x = xAcc
		elif xInput == -1:
			acc.x = -xAcc
		else:
			vel.x = 0
	
	acc.y = gravity
	
	if is_on_floor():
		groundedTimer = 0
		
	if get_parent().gameActive:
		if Input.is_action_just_pressed("jump"):
			jumpInputTimer = 0
	
	if groundedTimer <= 0.1 && jumpInputTimer <= 0.1:
		groundedTimer = INF
		jumpInputTimer = INF
		jumpTimer = 0
	
	if jumpTimer <= 0.15 && Input.is_action_pressed("jump"):
		vel.y = -jumpVel
	else:
		jumpTimer = INF
	
	groundedTimer += delta
	jumpInputTimer += delta
	jumpTimer += delta
	
	vel += acc * delta
	vel.x = clamp(vel.x, -maxXVel, maxXVel)
	vel.y = clamp(vel.y, -maxYVel, maxYVel)
	
	velocity = vel * tileSize
	move_and_slide()

func _on_hurtbox_body_entered(body):
	if get_parent().gameActive:
		if $InvincibilityTimer.is_stopped():
			$InvincibilityTimer.start()
			health -= 1
			if health <= 0:
				playerDie.emit()
			else:
				playerHit.emit()
