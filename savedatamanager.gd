extends Node

func save():
	if !DirAccess.dir_exists_absolute("user://saves"):
		DirAccess.make_dir_absolute("user://saves")
	var file = FileAccess.open("user://" + "saves/" + Global.username + ".save", FileAccess.WRITE)
	file.store_var(Global.stockmarkets)
	file.store_var(Global.stocksHistory)
	file.store_var(Global.username)
	file.store_var(Global.password)
	file.store_var(Global.myPosts)
	file.store_var(Global.myReplies)
	file.store_var(Global.myDMs)
	file.store_var(Global.myMoney)
	file.store_var(Global.howManyPostsPerPage)
	file.close()
func loadSave():
	if FileAccess.file_exists("user://saves/" + Global.username + ".save"):
		var file = FileAccess.open("user://saves/" + Global.username + ".save", FileAccess.READ)
		Global.stockmarkets = file.get_var()
		Global.stocksHistory = file.get_var()
		Global.username = file.get_var()
		Global.password = file.get_var()
		Global.myPosts = file.get_var()
		Global.myReplies = file.get_var()
		Global.myDMs = file.get_var()
		Global.myMoney = file.get_var()
		Global.howManyPostsPerPage = file.get_var()
		print(str(Global.stockmarkets) + "\n" + Global.username)
		file.close()
