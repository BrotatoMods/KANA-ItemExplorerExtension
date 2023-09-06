extends "res://ui/menus/title_screen/title_screen.gd"


const KANA_ITEM_EXPLORER_EXTENSION_LOG_NAME_EXTENSION_TITLE_SCREEN := "KANA-ItemExplorerExtension:Main"


func _ready() -> void:
	ModLoaderLog.debug("Updating item_explorer_extension_item_data in PorgressData current size -> %s" % ProgressData.data.kana_item_explorer_extension_item_data.size() if ProgressData.data.has('kana_item_explorer_extension_item_data') else '0', KANA_ITEM_EXPLORER_EXTENSION_LOG_NAME_EXTENSION_TITLE_SCREEN)

	var kana_item_keys := {}

	for items in ItemService.items:
		kana_item_keys[items.my_id] = {
			"viewed": 0,
			"bought": 0
		}

	if not ProgressData.data.has('kana_item_explorer_extension_item_data'):
		ProgressData.data.kana_item_explorer_extension_item_data = kana_item_keys
	else:
		ProgressData.data.kana_item_explorer_extension_item_data.merge(kana_item_keys)

	ModLoaderLog.debug("Updated item_explorer_extension_item_data in PorgressData current size -> %s" % ProgressData.data.kana_item_explorer_extension_item_data.size(), KANA_ITEM_EXPLORER_EXTENSION_LOG_NAME_EXTENSION_TITLE_SCREEN)
