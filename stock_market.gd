extends Control
var zoom = 1
var hasstartupstocking = false
var howManyFuckingTimes = 0
var gehef = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	howManyFuckingTimes = Global.stockmarkets.size()
	$StocksTimer.timeout.connect(timedStocks)
	for key in Global.stockmarkets:
		Global.stockmarkets[Global.currentStockSelected][6] = Global.stockmarkets[Global.currentStockSelected][2] * 1.2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
			
	queue_redraw()
	#print(Global.stockmarkets["UNIFUND"][2])
	if gehef < howManyFuckingTimes:
		for key in Global.stockmarkets:
			doTheStocksThing(key)
		gehef += 1
	if hasstartupstocking == true:
		$Camera2D.global_position = Vector2( 3 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][3]))
	
	
	#print(Global.stocksHistory[Global.currentStockSelected])
	$Camera2D.zoom = Vector2(1, zoom)
	if Input.is_action_just_pressed("ui_page_up"):
		zoom += 0.2
	if Input.is_action_just_pressed("ui_page_down"):
		zoom -= 0.2

func drawLineStocks(point1, point2):
	var colorOfCurrentLine = Color(Color.WHITE)
	if point1.y < point2.y:
		colorOfCurrentLine = Color(Color.RED)
	else:
		colorOfCurrentLine = Color(Color.GREEN)
	draw_line(point1, point2, colorOfCurrentLine, 5, false)
	
func _draw():
	#print(Global.stocksHistory[Global.currentStockSelected].size())
		#print("yeah man")
	var lineColor1 : Color
	var lineColor2 : Color
	var lineColor3 : Color
	var lineColor4 : Color
	var lineColor5 : Color
	if hasstartupstocking == true:
		if -Global.stocksHistory[Global.currentStockSelected][0] < -Global.stocksHistory[Global.currentStockSelected][1]:
			lineColor1 = Color(Color.RED)
		else:
			lineColor1 = Color(Color.GREEN)
		if -Global.stocksHistory[Global.currentStockSelected][1] < -Global.stocksHistory[Global.currentStockSelected][2]:
			lineColor2 = Color(Color.RED)
		else:
			lineColor2 = Color(Color.GREEN)
		if -Global.stocksHistory[Global.currentStockSelected][2] < -Global.stocksHistory[Global.currentStockSelected][3]:
			lineColor3 = Color(Color.RED)
		else:
			lineColor3 = Color(Color.GREEN)
		if -Global.stocksHistory[Global.currentStockSelected][3] < -Global.stocksHistory[Global.currentStockSelected][4]:
			lineColor4 = Color(Color.RED)
		else:
			lineColor4 = Color(Color.GREEN)
		if -Global.stocksHistory[Global.currentStockSelected][4] < -Global.stocksHistory[Global.currentStockSelected][5]:
			lineColor5 = Color(Color.RED)
		else:
			lineColor5 = Color(Color.GREEN)
		draw_line(
			Vector2( 0 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][0])),
			Vector2( 1 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][1])),
			lineColor1, 5, false
			)
		draw_line(
			Vector2( 1 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][1])),
			Vector2( 2 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][2])),
			lineColor2, 5, false
			)
		draw_line(
			Vector2( 2 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][2])),
			Vector2( 3 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][3])),
			lineColor3, 5, false
			)
		draw_line(
			Vector2( 3 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][3])),
			Vector2( 4 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][4])),
			lineColor4, 5, false
			)
		draw_line(
			Vector2( 4 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][4])),
			Vector2( 5 * (250.0 / 5), makeLineInBounds(Global.stocksHistory[Global.currentStockSelected][5])),
			lineColor5, 5, false
			)
func makeLineInBounds(value) -> float:
	var returnValue : float = 0
	if Global.stockmarkets[Global.currentStockSelected][3] != 0:
		if value > Global.stockmarkets[Global.currentStockSelected][6]:
			Global.stockmarkets[Global.currentStockSelected][6] = value
		if value < Global.stockmarkets[Global.currentStockSelected][7]:
			Global.stockmarkets[Global.currentStockSelected][7] = value
		returnValue = value / (absf(Global.stockmarkets[Global.currentStockSelected][6]) + abs(Global.stockmarkets[Global.currentStockSelected][7])) * 100
	#print(returnValue)
	return -returnValue
	
func doTheStocksThing(stockAffected):
		Global.stockmarkets[stockAffected][5] = randi_range(-1, 1)
		if Global.stockmarkets[stockAffected][5] == 1:
			Global.stockmarkets[stockAffected][2] += Global.stockmarkets[stockAffected][3] + randi_range(0, Global.stockmarkets[stockAffected][4])
		elif Global.stockmarkets[stockAffected][5] == -1:
			Global.stockmarkets[stockAffected][2] -= Global.stockmarkets[stockAffected][3] + randi_range(0, Global.stockmarkets[stockAffected][4])
			
			
		if Global.stocksHistory[stockAffected].size() > 5:
			if hasstartupstocking == false:
				hasstartupstocking = true
			Global.stocksHistory[stockAffected].remove_at(0)
			
		Global.stocksHistory[stockAffected].append(Global.stockmarkets[stockAffected][2])
		
func timedStocks():
	for key in Global.stockmarkets:
		doTheStocksThing(key)
