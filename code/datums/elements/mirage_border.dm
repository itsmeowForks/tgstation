/**
 * Creates a mirage effect allowing you to see around the world border, by adding the opposite side to its vis_contents.
 */
/datum/element/mirage_border

/datum/element/mirage_border/Attach(datum/target, turf/target_turf, direction, range=world.view)
	. = ..()
	if(!isturf(target))
		return COMPONENT_INCOMPATIBLE
	if(!target_turf || !istype(target_turf) || !direction)
		. = COMPONENT_INCOMPATIBLE
		CRASH("[type] improperly attached with the following args: target=\[[target_turf]\], direction=\[[direction]\], range=\[[range]\]")

	var/atom/movable/mirage_holder/holder = new(target)

	var/x = target_turf.x
	var/y = target_turf.y
	var/z = target_turf.z
	// Handle "15x15", converting it to 15
	if(istext(range))
		range = max(getviewsize(range)[1], getviewsize(range)[2])
	var/turf/southwest = locate(clamp(x - (direction & WEST ? range : 0), 1, world.maxx), clamp(y - (direction & SOUTH ? range : 0), 1, world.maxy), clamp(z, 1, world.maxz))
	var/turf/northeast = locate(clamp(x + (direction & EAST ? range : 0), 1, world.maxx), clamp(y + (direction & NORTH ? range : 0), 1, world.maxy), clamp(z, 1, world.maxz))
	//holder.vis_contents += block(southwest, northeast) // This doesnt work because of beta bug memes
	for(var/i in block(southwest, northeast))
		holder.vis_contents += i
	if(direction & SOUTH)
		holder.pixel_y -= world.icon_size * range
	if(direction & WEST)
		holder.pixel_x -= world.icon_size * range

/datum/element/mirage_border/Detach(atom/movable/target)
	. = ..()
	var/atom/movable/mirage_holder/held = locate() in target.contents
	if(held)
		qdel(held)

INITIALIZE_IMMEDIATE(/atom/movable/mirage_holder)
// Using /atom/movable because this is a heavily used path
/atom/movable/mirage_holder
	name = "Mirage holder"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
