extends PlayerState

@export var _animation_tree: NodePath
@onready var animation_tree:AnimationTree = get_node(_animation_tree)

var action_pressed = false
@export var next_state: String

var slash_twitch: float = 150

func enter(_msg := {}) -> void:
	animation_tree.get("parameters/playeranims/playback").travel("secondslash")
	action_pressed = false
	player.can_input = false

func physics_update(delta: float) -> void:
	animation_tree.set("parameters/playeranims/secondslash/blend_position", player.last_input_vector)
	if player.can_move and player.input_vector != Vector2.ZERO:
		player.desired_speed = slash_twitch
		player.move_and_slide()
	
	if Input.is_action_pressed("attack"):
		action_pressed = true
	
	if next_state and player.can_input and action_pressed:
		state_machine.transition_to(next_state)

	elif player.can_input:
		state_machine.transition_to("Idle")
