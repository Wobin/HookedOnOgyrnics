local mod = get_mod("Hooked On Ogrynics")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "show_anyway",			
				type = "checkbox",
				default_value = false,
			},
		}
	}
}
