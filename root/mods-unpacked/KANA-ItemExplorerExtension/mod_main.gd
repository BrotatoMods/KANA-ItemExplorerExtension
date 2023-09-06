extends Node


const KANA_ITEM_EXPLORER_EXTENSION_DIR := "KANA-ItemExplorerExtension"
const KANA_ITEM_EXPLORER_EXTENSION_LOG_NAME_MAIN := "KANA-ItemExplorerExtension:Main"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


func _init(modloader = ModLoader) -> void:
	mod_dir_path = ModLoaderMod.get_unpacked_dir().plus_file(KANA_ITEM_EXPLORER_EXTENSION_DIR)
	# Add extensions
	install_script_extensions()
	# Add translations
	add_translations()


func install_script_extensions() -> void:
	extensions_dir_path = mod_dir_path.plus_file("extensions")
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("ui/menus/title_screen/title_screen.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("ui/menus/shop/shop.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("ui/menus/shop/shop_items_container.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("mods-unpacked/otDan-ItemExplorer/ui/menus/items/item_explorer.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("mods-unpacked/otDan-ItemExplorer/ui/menus/items/parts/item_toggle.gd"))


func add_translations() -> void:
	translations_dir_path = mod_dir_path.plus_file("translations")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-ItemExplorerExtension/translations/translation.de.translation")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-ItemExplorerExtension/translations/translation.en.translation")


func _ready() -> void:
	_KANA_edit_item_explorer_scene()


func _KANA_edit_item_explorer_scene() -> void:
	var item_explorer_scene: MarginContainer = load("res://mods-unpacked/otDan-ItemExplorer/ui/menus/items/item_explorer.tscn").instance()

	_KANA_add_item_tracking_info_panel(item_explorer_scene)
	_KANA_add_sort_by_button(item_explorer_scene)

	ModLoaderMod.save_scene(item_explorer_scene, "res://mods-unpacked/otDan-ItemExplorer/ui/menus/items/item_explorer.tscn")


func _KANA_add_item_tracking_info_panel(item_explorer_scene: Node) -> void:
	var item_tracking_info_scene: PanelContainer = load("res://mods-unpacked/KANA-ItemExplorerExtension/ui/menus/items/parts/item_tracking_info.tscn").instance()

	var item_info_vbox: VBoxContainer = item_explorer_scene.get_node("VBoxContainer/HBoxContainer/VBoxContainer")
	var item_panel_ui: PanelContainer = item_info_vbox.get_node("ItemPanelUI")

	item_info_vbox.add_child_below_node(item_panel_ui, item_tracking_info_scene)
	item_tracking_info_scene.set_owner(item_explorer_scene)


func _KANA_add_sort_by_button(item_explorer_scene: Node) -> void:
	var left_side_bar: VBoxContainer = item_explorer_scene.get_node("VBoxContainer/HBoxContainer/VBoxContainer2")
	var sort_by_option_button: OptionButton = load("res://mods-unpacked/KANA-ItemExplorerExtension/ui/menus/items/parts/button_sort_by.tscn").instance()

	# Add the options button to the side panel
	left_side_bar.add_child(sort_by_option_button)
	# Move the options button to the top
	left_side_bar.move_child(sort_by_option_button, 0)
	# Set the owner so it doesn't disapear when the scene is packed
	sort_by_option_button.set_owner(item_explorer_scene)
