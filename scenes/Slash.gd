extends PlayerState

@export var _animation_tree: NodePath
@onready var animation_tree:AnimationTree = get_node(_animation_tree)

@export var next_state: String

var action_pressed = false
var slash_twitch: float = 150

func enter(_msg := {}) -> void:
	animation_tree.get("parameters/playeranims/playback").travel("slash")
	player.can_input = false
	action_pressed = false


func physics_update(delta: float) -> void:
	animation_tree.set("parameters/playeranims/slash/blend_position", player.last_input_vector)
	if player.can_move and player.input_vector != Vector2.ZERO:
		player.desired_speed = slash_twitch
		player.move_and_slide()
	
	if Input.is_action_pressed("dash"):
		state_machine.transition_to("Dash")
	
	if Input.is_action_pressed("attack"):
		action_pressed = true
	
	
	if next_state and player.can_input and action_pressed:
		state_machine.transition_to(next_state)
		
	elif player.can_input:
		state_machine.transition_to("Idle")
