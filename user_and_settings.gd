extends Control
@onready var windowNode = get_tree().get_root().get_node("/root/MainPage/Window")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	windowNode.visibility_changed.connect(restartStuff)
	restartStuff()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func refreshRandomizerFiles():
	if $MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/TXTFiles.get_child_count() > 0:
		for node in $MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/TXTFiles.get_children():
			node.queue_free()
	
	for txtfile in DirAccess.get_files_at("user://"):
		var wizard = RichTextLabel.new()
		wizard.bbcode_enabled = true
		var color : String = "[color=red]"
		var warning : String = "<- WARNING: Unrecognized file."
		if Global.standardTXTs.has(str(txtfile)):
			color = "[color=#FFFFFF]"
			warning = ""
		wizard.text = color + "[font_size=18]" + txtfile + " " + warning
		wizard.custom_minimum_size = Vector2(582, 18)
		wizard.scroll_active = false
		wizard.clip_contents = true
		$MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/TXTFiles.add_child(wizard)

func refreshReplyHistory():
	if $MarginContainer/PageVBox/HBoxContainer/UserProfile/VBoxContainer/MyReplies.get_child_count() > 0:
		for node in $MarginContainer/PageVBox/HBoxContainer/UserProfile/VBoxContainer/MyReplies.get_children():
			node.queue_free()
	
	for key in Global.myReplies:
		print(key)
		var wizard = RichTextLabel.new()
		wizard.bbcode_enabled = true
		wizard.text = "[font_size=18]" + key
		wizard.custom_minimum_size = Vector2(582, 18)
		wizard.scroll_active = false
		wizard.clip_contents = true
		wizard.size_flags_vertical = Control.SIZE_EXPAND_FILL
		wizard.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		$MarginContainer/PageVBox/HBoxContainer/UserProfile/VBoxContainer/MyReplies.add_child(wizard)



func _on_ammount_slider_value_changed(value: int) -> void:
	$MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/AmmoutOfPostsText.text = "Ammount of posts per load: [color=#ffffff]" + str(value) + "\n" + "[font_size=18]The number of posts rendered per refresh."
	Global.howManyPostsPerPage = value


func _on_pfp_reload_pressed() -> void:
	$MarginContainer/PageVBox/HBoxContainer/UserProfile/VBoxContainer/ProfilePicture.texture = SaveDataManager.getProfilePicture()


func _on_randomizer_files_button_pressed() -> void:
	var userDirectory = ProjectSettings.globalize_path("user://")
	OS.shell_open(userDirectory)


func _on_randomizer_files_reload_pressed() -> void:
	refreshRandomizerFiles()


func _on_stock_change_slider_value_changed(value: float) -> void:
	Global.stocksChangeTime = value
	$MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/StockChangeRate.text = "Market Flucuation Time: [color=#ffffff]" + str(Global.stocksChangeTime) + "s\n" + "[font_size=18]How much time passes for the market to fluctuate, or, for the line to go up or down."
	

func restartStuff():
	$MarginContainer/PageVBox/HBoxContainer/UserProfile/VBoxContainer/ProfilePicture.texture = SaveDataManager.getProfilePicture()
	refreshRandomizerFiles()
	refreshReplyHistory()
	$MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/AmmoutOfPostsText.text = "Ammount of posts per load: [color=#ffffff]" + str(Global.howManyPostsPerPage) + "\n" + "[font_size=18]The number of posts rendered per refresh."
	$MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/StockChangeRate.text = "Market Flucuation Time: [color=#ffffff]" + str(Global.stocksChangeTime) + "s\n" + "[font_size=18]How much time passes for the market to fluctuate, or, for the line to go up or down."
	$MarginContainer/PageVBox/HBoxContainer/UserProfile/VBoxContainer/MyRepliesText.text = "Replies: [color=#ffffff]" + str(Global.myReplies.keys().size()) + "\n[font_size=18]Your thoughts spread out on the cutting board for all to see."
	$MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/FontSizeText.text = "Font Size: [color=#ffffff]" + str(Global.textSize) + "px\n[font_size=18]Size of the post title font. Applies after page refesh."

func _on_update_profile_desc_pressed() -> void:
	Global.profileDesc = $MarginContainer/PageVBox/HBoxContainer/UserProfile/VBoxContainer/ColorRect2/MarginContainer/ProfileDescTextEdit.text


func _on_resolutions_item_clicked(index: int, _at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == 1:
		match index:
			0:
				Global.windowSize = Vector2(640, 480)
			1:
				Global.windowSize = Vector2(800, 600)
			2:
				Global.windowSize = Vector2(1024, 768)
			3:
				Global.windowSize = Vector2(1280, 1024)
	for windowNumb in range(get_tree().get_node_count_in_group("SubWindowNodes") + 1):
		DisplayServer.window_set_position(Vector2i(1920 / 2, 1080 / 2), windowNumb)
		DisplayServer.window_set_size(Global.windowSize, windowNumb)
	


func _on_font_size_slider_value_changed(value: float) -> void:
	Global.textSize = value
	$MarginContainer/PageVBox/HBoxContainer/Settings/VBoxContainer/FontSizeText.text = "Font Size: [color=#ffffff]" + str(Global.textSize) + "px\n[font_size=18]Size of the post title font. Applies after page refesh."
