extends Node2D

func _ready():
	Dialogic.start("timeline")

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

#func freeze_engine() -> void:
	#Engine.time_scale = freeze_slow
	#await get_tree().create_timer(freeze_time * freeze_slow).timeout
	#Engine.time_scale = 1
