///Telekinesis lets you interact with objects from range, and gives you a light blue halo around your head.
/datum/mutation/human/telekinesis
	name = "Telekinesis"
	desc = "A strange mutation that allows the holder to interact with objects through thought."
	quality = POSITIVE
	difficulty = 18
	text_gain_indication = "<span class='notice'>You feel smarter!</span>"
	limb_req = BODY_ZONE_HEAD
	instability = 30

/datum/mutation/human/telekinesis/New(class_ = MUT_OTHER, timer, datum/mutation/human/copymut)
	..()
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/effects/genetics.dmi', "telekinesishead", -MUTATIONS_LAYER))

/datum/mutation/human/telekinesis/on_acquiring(mob/living/carbon/human/H)
	. = ..()
	if(.)
		return
	RegisterSignal(H, COMSIG_MOB_ATTACK_RANGED, .proc/on_ranged_attack)

/datum/mutation/human/telekinesis/on_losing(mob/living/carbon/human/H)
	. = ..()
	if(.)
		return
	UnregisterSignal(H, COMSIG_MOB_ATTACK_RANGED)

/datum/mutation/human/telekinesis/get_visual_indicator()
	return visual_indicators[type][1]

///Triggers on COMSIG_MOB_ATTACK_RANGED. Usually handles stuff like picking up items at range.
/datum/mutation/human/telekinesis/proc/on_ranged_attack(mob/source, atom/target)
	SIGNAL_HANDLER
	if(!tkMaxRangeCheck(source, target) || source.z != target.z)
		source.balloon_alert(source, "can't TK, too far!")
		return
	return target.attack_tk(source)

/datum/mutation/human/telekinesis/mod
	name = "Kinesis"
	desc = "A modification that allows the wearer of a MODsuit to interact with objects through thought with the kinesis module."
	locked = TRUE
	text_gain_indication = null
	limb_req = null
	instability = 0

/datum/mutation/human/telekinesis/mod/get_visual_indicator()
	return
