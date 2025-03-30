extends Area2D
var damage = 10
 
func _physics_process(delta):
	position.x += 500 * delta


func _on_hitboxcomponent_area_entered(area):
	get_node("Hitboxcomponent/CollisionShape2D").set_deferred("disabled", true)
	if area.is_in_group("Enemies"):
		area.onHit(damage)
	queue_free()
