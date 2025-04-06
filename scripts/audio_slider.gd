extends Control

var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index("Master")
	var volume = AudioServer.get_bus_volume_linear(bus_index)
	get_node("CenterContainer/VSlider").value = volume
	



func _on_v_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, value)
