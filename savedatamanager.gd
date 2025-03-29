extends Node

var storedData : Dictionary = {}

func save():
	if !DirAccess.dir_exists_absolute("user://saves"):
		DirAccess.make_dir_absolute("user://saves")
	var file = FileAccess.open("user://" + "saves/" + Global.username + ".save", FileAccess.WRITE)
	storedData = {
		"StockMarketData" : Global.stockmarkets,
		"StockMarketHistory" : Global.stocksHistory,
		"Username" : Global.username,
		"Password" : Global.password,
		"MyPosts" : Global.myPosts,
		"MyReplies" : Global.myReplies,
		"MyDMs" : Global.myDMs,
		"MyMoney" : Global.myMoney,
		"HowManyPostsPerPage" : Global.howManyPostsPerPage
	}
	file.store_var(storedData)

	file.close()
func loadSave():
	if FileAccess.file_exists("user://saves/" + Global.username + ".save"):
		var file = FileAccess.open("user://saves/" + Global.username + ".save", FileAccess.READ)
		storedData = file.get_var()
		Global.stockmarkets = storedData["StockMarketData"]
		Global.stocksHistory = storedData["StockMarketHistory"]
		Global.username = storedData["Username"]
		Global.password = storedData["Password"]
		Global.myPosts = storedData["MyPosts"]
		Global.myReplies = storedData["MyReplies"]
		Global.myDMs = storedData["MyDMs"]
		Global.myMoney = storedData["MyMoney"]
		Global.howManyPostsPerPage = storedData["HowManyPostsPerPage"]
		#print(str(Global.stockmarkets) + "\n" + Global.username)
		file.close()

func checkPassword(username, passwordWritten):
	if FileAccess.file_exists("user://saves/" + username + ".save"):
		var file = FileAccess.open("user://saves/" + username + ".save", FileAccess.READ)
		storedData = file.get_var() 
		print(storedData["Password"] + " is something like " + passwordWritten)
		if storedData["Password"] == passwordWritten:
			return true
		else: 
			return false
		
	else:
		print("ThatDontExistMF")
	
