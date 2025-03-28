extends Control
var isBeingRandomlyMade = null
var currentFile = ""
var meme : int = 1
var ttext : String = ""
var btext : String = ""
var memeColor : Color = Color(Color.WHITE)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isBeingRandomlyMade == true:
		meme = randi_range(1, 20)
		$Meme.texture = load("res://Graphics/Images/Memes/" + str(meme) + ".png")
		getText(1)
		getText(2)
		ttext = Global.randomizeString(ttext, false).to_upper()
		btext = Global.randomizeString(btext, false).to_upper()
		memeColor = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)

	elif isBeingRandomlyMade == false:
		meme = Global.CurrentPost[4]
		ttext = "[font_size=48]" + Global.CurrentPost[2]
		btext = "[font_size=48]" + Global.CurrentPost[3]
		$Meme.texture = load("res://Graphics/Images/Memes/" + str(meme) + ".png")
		memeColor = Global.CurrentPost[9]
	$TopTextLabel.text = ttext
	$BottomTextLabel.text = btext
	$Meme.modulate = memeColor
	#$TopText.texture = load("res://Graphics/Images/Memes/TopText/" + str(ttext) + ".png")
	#$BottomText.texture = load("res://Graphics/Images/Memes/BottomText/" + str(btext) + ".png")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func getText(bottomOrTop : int):    
	if bottomOrTop == 1:
		currentFile = "user://memetoptext.txt"
	if bottomOrTop == 2:
		currentFile = "user://memebottomtext.txt"
	var list = FileAccess.open(currentFile, FileAccess.READ)
	var rng = RandomNumberGenerator.new()

	while not list.eof_reached():
		if bottomOrTop == 1:
			ttext = list.get_line()
		if bottomOrTop == 2:
			btext = list.get_line()
		if rng.randi() % 10 == 0:
			return
