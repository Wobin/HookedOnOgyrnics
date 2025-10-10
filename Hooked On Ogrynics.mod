return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Hooked On Ogrynics` encountered an error loading the Darktide Mod Framework.")

		new_mod("Hooked On Ogrynics", {
			mod_script       = "Hooked On Ogrynics/scripts/mods/Hooked On Ogrynics/Hooked On Ogrynics",
			mod_data         = "Hooked On Ogrynics/scripts/mods/Hooked On Ogrynics/Hooked On Ogrynics_data",
			mod_localization = "Hooked On Ogrynics/scripts/mods/Hooked On Ogrynics/Hooked On Ogrynics_localization",
		})
	end,
	  load_after = {
    "DarktideLocalServer"
  },
	version = "2.0.1",
	packages = {},
}
