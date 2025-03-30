extends Node

var storedData : Dictionary = {}

func save():
	if !DirAccess.dir_exists_absolute("user://saves"):
		DirAccess.make_dir_absolute("user://saves")
	if !DirAccess.dir_exists_absolute("user://images"):
		DirAccess.make_dir_absolute("user://images")
	
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

func getProfilePicture():
	var image 
	var playerPFP
	if FileAccess.file_exists("user://images/" + Global.username + ".png"):
		image = Image.load_from_file("user://images/" + Global.username + ".png")
		playerPFP = ImageTexture.create_from_image(image)
	else:
		image = load("res://Graphics/Images/ProfilePictures/1.png")
		playerPFP = ImageTexture.create_from_image(image)
		image.save_png("user://images/" + Global.username + ".png")
	return playerPFP

func checkIfTXTsDoExist():
	for txtfile in Global.standardTXTs:
		if txtfile in DirAccess.get_files_at("user://"):
			continue
		else:
			performTXTCreationWizardry(txtfile)

func performTXTCreationWizardry(whichFile):
	var file = FileAccess.open("res://StartupTextFiles/" + whichFile, FileAccess.READ)
	var createdFile = FileAccess.open("user://" + whichFile, FileAccess.WRITE_READ)
	print(file.get_as_text())
	createdFile.store_string(file.get_as_text())
	file.close()
	createdFile.close()
	
