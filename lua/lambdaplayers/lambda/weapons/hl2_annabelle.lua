table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_annabelle = {
        model = "models/weapons/w_annabelle.mdl",
        origin = "Half-Life 2",
        prettyname = "Annabelle",
        holdtype = "ar2",
        killicon = "lambdaplayers/killicons/icon_vwp_annabelle",
        bonemerge = true,
        keepdistance = 350,
        attackrange = 2250,

        clip = 2,
        tracername = "Tracer",
        damage = 20,
        spread = 0.1,
        rateoffire = 0.5,
        muzzleflash = 1,
        shelleject = "ShotgunShellEject",
        shelloffang = Angle( -180, 0, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        attacksnd = "weapons/shotgun/shotgun_fire6.wav",

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        reloadanimspeed = 1.2,

        islethal = true,
    }

})