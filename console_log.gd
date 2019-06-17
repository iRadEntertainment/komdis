#=======================#
#    console_log.gd     #
#=======================#



extends VBoxContainer

const MAX_LINES = 200
var lines_theme = load("res://styles/smalltext.tres")


func _ready():
	clear_console()

func clear_console():
	for line in get_children():
		line.queue_free()

func add_lines(lines, col = null):
	if typeof(lines) == TYPE_STRING:
		lines = [lines]
	
	if typeof(lines) == TYPE_ARRAY:
		for line in lines:
			var new_line = Label.new()
			new_line.theme = lines_theme
			new_line.text = str(line)
			if col:
				new_line.modulate = col
			add_child(new_line)
		
	else:
		print("please pass |lines| as String or Array - lines passed: %s"%str(lines))
	
	#delete extra lines
	while get_child_count() > MAX_LINES:
		get_child(0).free()
	
	yield(get_tree(),"idle_frame")
	$"..".scroll_vertical += 5000
	