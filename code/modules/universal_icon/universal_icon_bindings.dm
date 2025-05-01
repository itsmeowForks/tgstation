// These bindings are used by get_flat_universal_icon
// These exist because performing certain operations on /icon removes their ability to be associated
// with the fileystem - the stringification of ".icon" returns an empty string.
// This makes the icon inaccessible to rustg and universal icons as a whole.
// These bindings store the transformed applied to that type of icon, as well as the file path initially used

/icon/var/icon_file
/icon/var/icon_state
/icon/var/dir
/icon/var/frame
/icon/var/moving
/icon/var/list/transforms

/icon/New(I, icon_state, dir, frame, moving)
	. = ..()
	var/string_icon = "[I]"
	if(istype(I, /icon))
		var/icon/icon_old = I
		if(!length(string_icon) || string_icon == "/icon") // only replace if empty, otherwise we might put an outdated value
			src.icon_file = icon_old.icon_file
		src.transforms = deep_copy_list_alt(icon_old.transforms)
	else if(istype(I, /image))
		var/image/image_old = I
		if(!length(string_icon) || string_icon == "/image") // only replace if empty, otherwise we might put an outdated value
			src.icon_file = image_old.icon_file
		src.transforms = deep_copy_list_alt(image_old.transforms)
	else
		src.icon_file = string_icon
	src.icon_state = icon_state
	src.dir = dir
	src.frame = frame
	src.moving = moving

/icon/proc/to_list()
	RETURN_TYPE(/list)
	return list(
		"icon_file" = "[src]",
		"icon_state" = src.icon_state || "",
		"dir" = src.dir || SOUTH,
		"frame" = isnull(src.frame) ? 0 : src.frame,
		"transform" = deep_copy_list_alt(src.transforms)
	)

/icon/Blend(icon_or_color, blend_mode, x=1, y=1)
	. = ..()
	LAZYINITLIST(src.transforms)
	if(x != 1 || y != 1)
		// not implemented yet!
		return
	if(istext(icon_or_color))
		src.transforms += list(list("type" = RUSTG_ICONFORGE_BLEND_COLOR, "color" = icon_or_color, "blend_mode" = blend_mode))
	else if(istype(icon_or_color, /icon))
		var/icon/icon_object = icon_or_color
		src.transforms += list(list("type" = RUSTG_ICONFORGE_BLEND_ICON, "icon" = icon_object.to_list(), "blend_mode" = blend_mode))
	else
		CRASH("The fuck is this? [icon_or_color]")

/icon/Scale(width, height)
	. = ..()
	LAZYINITLIST(src.transforms)
	src.transforms += list(list("type" = RUSTG_ICONFORGE_SCALE, "width" = width, "height" = height))

/icon/Crop(x1, y1, x2, y2)
	. = ..()
	LAZYINITLIST(src.transforms)
	src.transforms += list(list("type" = RUSTG_ICONFORGE_CROP, "x1" = x1, "y1" = y1, "x2" = x2, "y2" = y2))

/icon/ChangeOpacity(amount)
	. = ..()
	LAZYINITLIST(src.transforms)
	src.transforms += list(list("type" = RUSTG_ICONFORGE_BLEND_COLOR, "color" = "#ffffff[num2hex(clamp(amount, 0, 1) * 255, 2)]", "blend_mode" = ICON_MULTIPLY))

/icon/Turn(angle)
	. = ..()
	// Not implemented yet

/icon/Flip(dir)
	. = ..()
	// Not implemented yet

/icon/Shift(dir, offset, wrap=0)
	. = ..()
	// Not implemented yet

/icon/SetIntensity(r, g, b)
	. = ..()
	// Not implemented yet

/icon/SwapColor(old_rgba, new_rgba)
	. = ..()
	// Not implemented yet

/icon/MapColors(rr, rg, rb, gr, gg, gb, br, bg, bb, r0=0, g0=0, b0=0)
	. = ..()
	// Not implemented yet

/icon/MapColors(r_rgb, g_rgb, b_rgb, rgb0=rgb(0,0,0))
	. = ..()
	// Not implemented yet

/icon/MapColors(rr, rg, rb, ra, gr, gg, gb, ga, br, bg, bb, ba, ar, ag, ab, aa, r0=0, g0=0, b0=0, a0=0)
	. = ..()
	// Not implemented yet

/icon/MapColors(r_rgba, g_rgba, b_rgba, a_rgba, rgba0)
	. = ..()
	// Not implemented yet

/icon/DrawBox(rgb, x1, y1, x2, y2)
	. = ..()
	// Not implemented yet

/icon/Insert(new_icon, icon_state, dir, frame, moving, delay)
	. = ..()

/image/var/icon_file
/image/var/list/transforms

/image/New(I, icon_state, dir, frame, moving)
	. = ..()
	var/string_icon = "[I]"
	if(istype(I, /icon))
		var/icon/icon_old = I
		if(!length(string_icon) || string_icon == "/icon") // only replace if empty, otherwise we might put an outdated value
			src.icon_file = icon_old.icon_file
		src.transforms = deep_copy_list_alt(icon_old.transforms)
		if(!length(src.icon_file))
			// what the fuck
			CRASH("Hey so no icon file was found ever on this icon which is weird as shit [string_icon] [src.icon_file]")
	else if(istype(I, /image))
		var/image/image_old = I
		if(!length(string_icon) || string_icon == "/image") // only replace if empty, otherwise we might put an outdated value
			src.icon_file = image_old.icon_file
		src.transforms = deep_copy_list_alt(image_old.transforms)
		if(!length(src.icon_file))
			if(istype(image_old.icon, /icon))
				var/icon/icon_old = image_old.icon
				src.icon_file = icon_old.icon_file
				src.transforms = deep_copy_list_alt(icon_old.transforms)
			else // icon object is JUST a filepath, never called new()
				src.icon_file = "[image_old.icon]"
	else
		src.icon_file = string_icon
