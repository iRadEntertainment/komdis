#=================#
#    komdis.gd    #
#=================#

extends Control


func _ready():
	pass

func console_print(lines, col = null): find_node("console_log").add_lines(lines, col)

func update_district_shift_panel():
	$main/district_panel.update_panel()