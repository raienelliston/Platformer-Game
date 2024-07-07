extends Node2D

signal triggered

@export var reciever_id: int

func _ready():
	add_to_group("receivers")
	var detectors = get_tree().get_nodes_in_group("detectors")
	for detector in detectors:
		if detector.detector_id == reciever_id:
			detector.connect("detected_signal", _on_detected_signal)
			
func _on_detected_signal():
	print("detected signal")
	triggered.emit()
