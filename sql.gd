#=======================#
#        sql.gd         #
#=======================#


extends Node

const SQLite = preload("res://lib/gdsqlite.gdns")
const db_path = "res://komdis.db"

onready var db = SQLite.new()
var query      = ""
var result     = null

#-------- fields
var district_numbers = [4001,4103,4405,4002,4407,4102,50080,50120,50150,50190,50210,50220,50230,30210,30230,30330,30390,30410,30450]
var DISTRICT_SHIFT_fields = [
"id integer PRIMARY KEY",
"district integer NOT NULL",
"day integer NOT NULL",
"arrive real",
"sort real",
"fin real",
"first real",
"last real",
"end_day real",
"pause real",
"newspapers integer",
"abobo integer",
"sms_abobo integer",
"label integer",
"addressed integer",
"notes varchar"
]


#==================================================================
func _ready():
#	create_db(db_path)
	if !open_db():
		print("SQL: Cannot open database.")
		$"root/komdis".console_print("SQL: Cannot open database.", Color.red)
		return
	
#	drop_table("district_shift")
#	create_table("district_shift",DISTRICT_SHIFT_fields)
	

#==================================================================

func create_table(tablename, fields_array):
	#--- create with tablename
	query = "CREATE TABLE IF NOT EXISTS %s ("%tablename
	#--- add fields with commas
	for field in fields_array:
		query += field + ","
	
	#--- get rid of the last comma and close the query
	query = query.trim_suffix(",")
	query += ");";
	#--- finalize
	result = db.query(query);

func drop_table(tablename):
	query = "DROP TABLE IF EXISTS %s;"%tablename
	db.query(query)

func print_table(tablename):
	query = "SELECT * FROM %s;"%tablename;
	result = db.fetch_array(query);
	if !result: print("SQL: |%s| Table doesn't exist."%tablename)
	else:
		print(result)
	return result

func open_db():
	if (!db.open_db(db_path)):
		return false
	
	
	return true

func create_db(db_filepath):
	#check if file exist already
	var dir = Directory.new();
	if dir.file_exists(db_filepath):
		print("SQL: File %s already exist"%db_filepath)
		return false
	#create db_file
	var db_file = File.new()
	db_file.open(db_filepath, File.WRITE)
	db_file.close()
	return true