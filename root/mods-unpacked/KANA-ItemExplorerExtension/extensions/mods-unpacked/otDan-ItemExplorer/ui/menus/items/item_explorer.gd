extends "res://mods-unpacked/otDan-ItemExplorer/ui/menus/items/item_explorer.gd"


var kana_items_sorted_by_tier := []
var kana_sort_by_options := {
	0: {
		"text": "sort by tier",
		"key": "tier",
		"handler": "KANA_sort_by_tier",
	},
	1: {
		"text": "sort by most seen",
		"key": "most_seen",
		"handler": "KANA_sort_by_most_seen",
	},
	2: {
		"text": "sort by most bought",
		"key": "most_bought",
		"handler": "KANA_sort_by_most_bought",
	},
}

func _ready() -> void:
	var btn_sort_by: OptionButton = .get_node("VBoxContainer/HBoxContainer/VBoxContainer2/ButtonSortBy")
	btn_sort_by.init(kana_sort_by_options)
	btn_sort_by.connect("item_selected", self, "_KANA_on_btn_sort_by_item_selected")


func init() -> void:
	.init()
	# Hide the Side Panel first
	_KANA_set_side_panel_alpha(0.0)

	kana_items_sorted_by_tier = KANA_sort_by_tier()
	KANA_clear_item_container()
	KANA_init_items(kana_items_sorted_by_tier)


func item_toggle_focus_entered(item_data: ItemData) -> void:
	.item_toggle_focus_entered(item_data)

	var item_tracking_info_panel: PanelContainer = get_node("VBoxContainer/HBoxContainer/VBoxContainer/ItemTrackingInfo")
	var item_tracking_info: Dictionary = ProgressData.data.kana_item_explorer_extension_item_data[item_data.my_id]

	if item_tracking_info.viewed > 0:
		item_tracking_info_panel.init(item_tracking_info)
		_KANA_set_side_panel_alpha(1.0)


func _KANA_set_side_panel_alpha(alpha_value: float) -> void:
	var side_panel: VBoxContainer = get_node("VBoxContainer/HBoxContainer/VBoxContainer")
	side_panel.modulate.a = alpha_value


func KANA_sort_by_tier() -> Array:
	var kana_items_by_tier := {}
	var kana_items_by_tier_array := []

	for item in ItemService.items:
		item = item as ItemData

		if not kana_items_by_tier.has(item.tier):
			kana_items_by_tier[item.tier] = []

		kana_items_by_tier[item.tier].push_back(item)

	for index in kana_items_by_tier.size():
		kana_items_by_tier_array.append_array(kana_items_by_tier[index])

	return kana_items_by_tier_array


func KANA_sort_by_most_seen() -> Array:
	var kana_items_by_most_seen: Array = kana_items_sorted_by_tier.duplicate(true)
	kana_items_by_most_seen.sort_custom(self, "_KANA_sort_by_most_seen")

	return kana_items_by_most_seen


func _KANA_sort_by_most_seen(item_a: ItemData, item_b: ItemData) -> bool:
	var item_a_view_count: int = ProgressData.data.kana_item_explorer_extension_item_data[item_a.my_id].viewed
	var item_b_view_count: int = ProgressData.data.kana_item_explorer_extension_item_data[item_b.my_id].viewed

	if item_a_view_count > item_b_view_count:
		return true

	if item_a_view_count == item_b_view_count:
		if item_a.tier < item_b.tier:
			return true

	return false


func KANA_sort_by_most_bought() -> Array:
	var kana_items_by_most_bought: Array = kana_items_sorted_by_tier.duplicate(true)
	kana_items_by_most_bought.sort_custom(self, "_KANA_sort_by_most_bought")

	return kana_items_by_most_bought


func _KANA_sort_by_most_bought(item_a: ItemData, item_b: ItemData) -> bool:
	var item_a_bought_count: int = ProgressData.data.kana_item_explorer_extension_item_data[item_a.my_id].bought
	var item_b_bought_count: int = ProgressData.data.kana_item_explorer_extension_item_data[item_b.my_id].bought

	if item_a_bought_count > item_b_bought_count:
		return true

	if item_a_bought_count == item_b_bought_count:
		if item_a.tier < item_b.tier:
			return true

	return false


func KANA_clear_item_container() -> void:
	for child in item_container.get_children():
		child.free()


# Copy paste from original mod
func KANA_init_items(items: Array) -> void:
	var first_item: Button = null
	for item in items:
		var mod = ContentLoader.lookup_modid_by_itemdata(item)
		if mod == "CL_Notice-NotFound":
			mod = "Vanilla"
		else:
			mod = get_string_after_character(mod, "-")

		for key in visible_keys:
			if not visible_items.has(key):
				visible_items[key] = {}
			visible_items[key][item] = true

		var instance = item_toggle.instance()
		instance.set_item(item)
		instance.connect("item_toggle_focus_entered", self, "item_toggle_focus_entered")
		instance.connect("item_button_pressed", self, "item_button_pressed")
		item_container.add_child(instance)

		if not mod_items.has(mod):
			mod_items[mod] = []
		mod_items[mod].append(item)

		item_dictionary[item] = instance

		if first_item == null:
			first_item = instance.get_node("%ToggleButton")

		first_item.grab_focus()


func _KANA_on_btn_sort_by_item_selected(index: int) -> void:
	var sorted_items: Array = call(kana_sort_by_options[index].handler)
	KANA_clear_item_container()
	KANA_init_items(sorted_items)

