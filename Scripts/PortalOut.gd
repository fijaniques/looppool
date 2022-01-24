extends Area2D

export(PackedScene) var nextScene

func _on_PortalOut_body_entered(body):
	get_tree().change_scene_to(nextScene)
