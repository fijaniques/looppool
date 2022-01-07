extends RichTextLabel

onready var timer = $Timer

func _process(delta):
	percent_visible += delta
