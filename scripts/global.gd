extends Node

var high_score: int = 0;
var score: int = 0;

func load_high_score() -> void:
	var save_file := FileAccess.open("user://highscore.save", FileAccess.READ);
	if save_file:
		var save_string := save_file.get_as_text();
		var data: Dictionary = JSON.parse_string(save_string);
		if data:
			high_score = data.high_score;
			
		save_file.close();
	else:
		high_score = 0;

func save_high_score() -> void:
	if score > high_score: high_score = score;
	
	var save_file := FileAccess.open("user://highscore.save", FileAccess.WRITE);
	if save_file:
		var data := {"high_score": high_score};
		var save_string := JSON.stringify(data);
		save_file.store_string(save_string);
		
		save_file.close();
