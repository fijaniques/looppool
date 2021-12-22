extends Area2D

export var nextScene : String

func _on_PortalOut_area_entered(area):
	get_tree().change_scene(nextScene)
