extends Node

@onready var receiver: Node2D = $RedReceiver

func _ready() -> void:
	if receiver and receiver.has_signal("triggered"):
		receiver.connect("triggered", _on_receiver_triggered)
		
func _on_receiver_triggered() -> void:
	print("test parent")
