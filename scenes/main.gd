extends Control
#region Node References
@onready var pause_menu: Node = $PauseMenu
#endregion

#region Temp. Properties
var state: GameState
var is_in_pause_menu: bool = false
#endregion
#region Constants
@export var interactions : Array[DialogueInteraction]
const EVENT_SELECTION_PROPERTIES: Array[String] = ["turn"]
#endregion
func _ready():
	pause_menu.resume.connect(func(): is_in_pause_menu = false)

func _input(event):
	if is_in_pause_menu: #The menu handles all input when it is active
		return
	
	if event.is_action_pressed("escape"):
		pause_menu.open_pause_menu()

func start_next_dialogue() -> void:
	var next_event: DialogueInteraction
	for event in interactions:
		var selection_valid := true
		
		for property in EVENT_SELECTION_PROPERTIES:
			if (event[property] != null) and !(event[property] == state[property]):
				selection_valid = false
		
		if selection_valid:
			next_event = event
			break
	
	var dialogue = load(next_event.path_to_dialogue)
	if dialogue == OK:
		DialogueManager.show_dialogue_balloon(dialogue)
