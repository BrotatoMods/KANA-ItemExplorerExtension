extends "res://mods-unpacked/otDan-ItemExplorer/ui/menus/items/parts/item_toggle.gd"


func _ready() -> void:
	toggle_button.self_modulate.a = 0.25

	if ProgressData.data.kana_item_explorer_extension_item_data[item_data.my_id].viewed == 0:
		toggle_button.disabled = true
		item_icon.self_modulate.a = 1.0
		item_icon.texture = load("res://items/global/random_icon.png")


func send_item():
	if ProgressData.data.kana_item_explorer_extension_item_data[item_data.my_id].viewed == 0:
		return

	.send_item()
