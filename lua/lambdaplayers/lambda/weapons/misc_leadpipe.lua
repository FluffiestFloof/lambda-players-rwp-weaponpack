table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_leadpipe = {
        model = "models/props_canal/mattpipe.mdl",
        origin = "Misc",
        prettyname = "Lead Pipe",
        holdtype = "melee",
        killicon = "lambdaplayers/killicons/icon_vwp_metalpipe",
        ismelee = true,
        bonemerge = true,
        keepdistance = 10,
        attackrange = 55,

        damage = 10,
        rateoffire = 0.4,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
        attacksnd = "Weapon_Crowbar.Single",
        hitsnd = "Weapon_Crowbar.Melee_Hit",

        islethal = true,
    }

})