extends Area2D

signal player_damaged

func _on_body_entered(body: Node2D) -> void:
	player_damaged.emit()
