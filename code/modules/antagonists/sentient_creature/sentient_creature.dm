/datum/antagonist/sentient_creature
	name = "\improper Sentient Creature"
	show_in_antagpanel = FALSE
	show_in_roundend = FALSE
	count_against_dynamic_roll_chance = FALSE
	ui_name = "AntagInfoSentient"

/datum/antagonist/sentient_creature/get_preview_icon()
	var/datum/universal_icon/final_icon = uni_icon('icons/mob/simple/pets.dmi', "corgi")

	var/datum/universal_icon/pandora = uni_icon('icons/mob/simple/lavaland/lavaland_elites.dmi', "pandora")
	pandora.blend_color(rgb(128, 128, 128, 128), ICON_MULTIPLY)
	pandora.shift(WEST, ICON_SIZE_X / 4, 32, 32)
	final_icon.blend_icon(pandora, ICON_UNDERLAY)

	var/datum/universal_icon/rat = uni_icon('icons/mob/simple/animal.dmi', "regalrat")
	rat.blend_color(rgb(128, 128, 128, 128), ICON_MULTIPLY)
	rat.shift(EAST, ICON_SIZE_X / 4, 32, 32)
	final_icon.blend_icon(rat, ICON_UNDERLAY)

	final_icon.scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	return final_icon

/datum/antagonist/sentient_creature/on_gain()
	var/mob/living/master = owner.enslaved_to?.resolve()
	if(master)
		owner.current.copy_languages(master, LANGUAGE_MASTER)
	return ..()

/datum/antagonist/sentient_creature/ui_static_data(mob/user)
	var/list/data = list()
	var/mob/living/master = owner.enslaved_to?.resolve()
	if(master)
		data["enslaved_to"] = master.real_name
		data["p_them"] = master.p_them()
		data["p_their"] = master.p_their()
	data["holographic"] = owner.current.flags_1 & HOLOGRAM_1
	return data
