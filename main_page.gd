extends Control
var currentPosts = 0
var post = load("res://PostSmall.tscn")
var postInst
var srotspeed : Vector3 = Vector3(0, 0, 0)
var currentStocksShown = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	srotspeed = Vector3(randf_range(0.1, 15), randf_range(0.1, 15), randf_range(0.1, 15))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$SubViewport/ShovelModel.rotation_degrees += srotspeed / 50
	$HBoxContainer/VBoxContainer/ProfileColor/StockMarket/StocksAndTextDivider/ScrollContainer/VBoxContainer/StockPrice.text = "Current Shares: " + str(Global.stockmarkets[Global.currentStockSelected][8]) + "\n" + "Current Funds: " + str(Global.myMoney) + "€" + "\n" + "Current Price: " + str(Global.stockmarkets[Global.currentStockSelected][2]) + "€" 
	if currentPosts < Global.howManyPostsPerPage:
		postInst = post.instantiate()
		$HBoxContainer/ScrollPage/PostList.add_child(postInst)
		currentPosts += 1
		$HBoxContainer/ScrollPage/LoadingWheel.rotation_degrees += 5 
	else:
		if $HBoxContainer/ScrollPage/PostList.is_visible_in_tree() == false:
			$HBoxContainer/ScrollPage/PostList.show()
			$HBoxContainer/ScrollPage/LoadingWheel.hide()
			
	if currentStocksShown < Global.stockmarkets.size():
		for key in Global.stockmarkets:
			$HBoxContainer/VBoxContainer/ProfileColor/StockMarket/StocksButtons.add_item(str(key), null, true)
			currentStocksShown += 1
	
	if Input.is_action_just_pressed("ReloadMainPage"):
		for n in $HBoxContainer/ScrollPage/PostList.get_children():
			$HBoxContainer/ScrollPage/PostList.remove_child(n)
			n.queue_free() 
		currentPosts = 0
	if Input.is_action_just_pressed("OpenUASWindow"):
		createUserAndSettingsWindow()


func _on_stocks_buttons_item_selected(index: int) -> void:
	$HBoxContainer/VBoxContainer/ProfileColor/StockMarket/StocksAndTextDivider/ScrollContainer/VBoxContainer/StockDesc.text = Global.stockmarkets[$HBoxContainer/VBoxContainer/ProfileColor/StockMarket/StocksButtons.get_item_text(index)][0] + "\n" + "DESCRIPTION: " + Global.stockmarkets[$HBoxContainer/VBoxContainer/ProfileColor/StockMarket/StocksButtons.get_item_text(index)][1]
	Global.currentStockSelected = $HBoxContainer/VBoxContainer/ProfileColor/StockMarket/StocksButtons.get_item_text(index)


func _on_purchase_pressed() -> void:
	if Global.myMoney >= Global.stockmarkets[Global.currentStockSelected][2] && Global.stockmarkets[Global.currentStockSelected][2] > 0:
		Global.myMoney -= Global.stockmarkets[Global.currentStockSelected][2]
		Global.stockmarkets[Global.currentStockSelected][8] += 1


func _on_sell_pressed() -> void:
	if Global.stockmarkets[Global.currentStockSelected][8] > 0:
		Global.myMoney += Global.stockmarkets[Global.currentStockSelected][2]
		Global.stockmarkets[Global.currentStockSelected][8] -= 1

func createUserAndSettingsWindow() -> void:
	$Window.visible = true
	
func _on_window_close_requested() -> void:
	$Window.visible = false
