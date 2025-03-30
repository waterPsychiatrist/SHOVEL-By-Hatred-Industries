extends Control
var srotspeed : Vector3 = Vector3(0, 0, 0)
var goToMain = false
var mainPageScene = "res://MainPage.tscn"
@onready var usernameBox = $PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/UMargin/UsernameTextEdit
@onready var passwordBox = $PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/PMargin/PasswordTextEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	srotspeed = Vector3(randf_range(0.1, 15), randf_range(0.1, 15), randf_range(0.1, 15))
	ResourceLoader.load_threaded_request(mainPageScene)
	SaveDataManager.checkIfTXTsDoExist()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$SubViewport/ShovelModel.rotation_degrees += srotspeed / 50
	if goToMain == true:
		var loadProgress = []
		ResourceLoader.load_threaded_get_status(mainPageScene, loadProgress)
		if loadProgress[0] == 1:
			var packedScene = ResourceLoader.load_threaded_get(mainPageScene)
			get_tree().change_scene_to_packed(packedScene)
			
			
func _on_log_in_pressed() -> void:
		if usernameBox.text.replacen(" ", "") != "" && passwordBox.text != "":
			Global.username = $PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/UMargin/UsernameTextEdit.text.replacen(" ", "")
			print(usernameBox.text.replacen(" ", "") + " / " + passwordBox.text)
			if SaveDataManager.checkPassword(usernameBox.text.replacen(" ", ""), passwordBox.text) == true:
				SaveDataManager.loadSave()
				await get_tree().create_timer(3).timeout
				goToMain = true
			else:
				$PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/HelpText.text = "Password incorrect. Please try again."
		else:
			$PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/HelpText.text = "Username / password cannot be empty."
func _on_sign_up_pressed() -> void:
	if usernameBox.text.replacen(" ", "") != "" && passwordBox.text.replacen(" ", "") != "":
		Global.username = $PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/UMargin/UsernameTextEdit.text.replacen(" ", "")
		Global.password = $PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/PMargin/PasswordTextEdit.text
		SaveDataManager.save()
		await get_tree().create_timer(3).timeout
		goToMain = true
	else:
		$PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/HelpText.text = "Username / password cannot be empty."


func _on_password_text_edit_editing_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/HelpText.text = "If you forget this, you'll have to make a new account."


func _on_username_text_edit_editing_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$PageAndShovelSeperator/PageContents/ScrollContainer/VBoxContainer/HelpText.text = "No spaces on the username, preferably."
