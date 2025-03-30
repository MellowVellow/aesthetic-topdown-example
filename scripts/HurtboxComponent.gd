extends Area2D
class_name HurtboxComponent

@export var hitEffectScene: PackedScene
func hurt_effect():
	var hitEffect : Node2D = hitEffectScene.instantiate() as Node2D
	var main = get_tree().current_scene
	main.add_child(hitEffect)
	hitEffect.global_position = global_position
