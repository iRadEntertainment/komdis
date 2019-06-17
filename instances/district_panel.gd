#=======================#
#   district_panel.gd   #
#=======================#


extends HBoxContainer

const row_scn = preload("res://instances/district_row.tscn")
var select_filter = "select * from district_shift order by day desc;"

func _ready():
	update_panel()

func update_panel():
	for row in $district_shift_scroll/district_shift_list.get_children():
		row.free()
	var dics = sql.db.fetch_array(select_filter)
	if !dics:
		return
	
	var prev_day = 190324
	var prev_weekday = 0
	for dic in dics:
		var new_row = row_scn.instance()
		new_row.dic = dic
		#--- separators
		if dic.has("day"):
#			var day   = dic["day"]%100
#			var month = (int(dic["day"]/100))%100
#			var date = {"day":day , "month":month , "year":2019}
#			var to_unix = OS.get_unix_time_from_datetime(date)
#			var weekday = OS.get_datetime_from_unix_time(to_unix)["weekday"]
			
#			print("weekday:",prev_weekday,weekday)
			
#			if prev_weekday < weekday:
#				var Hsep1 = HSeparator.new()
#				Hsep1.modulate = Color.crimson
#				$district_shift_scroll/district_shift_list.add_child(Hsep1)
			
			if dic["day"] != prev_day:
				var Hsep = HSeparator.new()
				Hsep.modulate = Color.green
				$district_shift_scroll/district_shift_list.add_child(Hsep)
			
#			prev_weekday = weekday
			prev_day = dic["day"]
		#--- add new voice after separators checks
		$district_shift_scroll/district_shift_list.add_child(new_row)
	
	
	
	