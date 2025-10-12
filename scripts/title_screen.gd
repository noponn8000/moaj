extends Node2D;

var start_hover := false;
var exit_hover := false;

func _on_start_area_mouse_entered() -> void:
	start_hover = true;
	%HoverAudio.play();

func _on_start_area_mouse_exited() -> void:
	start_hover = false;

func _on_exit_area_mouse_entered() -> void:
	%HoverAudio.play();
	exit_hover = true;
	
func _on_exit_area_mouse_exited() -> void:
	exit_hover = false;

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if exit_hover:
			get_tree().quit();
		elif start_hover:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
