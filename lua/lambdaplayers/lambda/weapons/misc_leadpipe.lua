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

        damage = 500,
        rateoffire = 1,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
        attacksnd = "Weapon_Crowbar.Single",
        hitsnd = "lambdaplayers/loudpipe/lead_pipe_ear_rape.wav",

        islethal = true,
    }

})