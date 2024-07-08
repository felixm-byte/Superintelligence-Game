extends Control
#region Node References
@onready var pause_menu: Node = $PauseMenu
#endregion

#region Temp. Properties
var state: GameState
var is_in_pause_menu: bool = false
#endregion

func _ready():
	pause_menu.resume.connect(func(): is_in_pause_menu = false)

func _input(event):
	if is_in_pause_menu: #The menu handles all input when it is active
		return
	
	if event.is_action_pressed("escape"):
		pause_menu.open_pause_menu()
