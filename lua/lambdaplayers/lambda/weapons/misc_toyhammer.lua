local random = math.random

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_toyhammer = {
        model = "models/lambdaplayers/toyhammer/w_pvp_toy.mdl",
        origin = "Misc", -- GMod Tower but it's the only one so it's goes in Misc
        prettyname = "Toy Hammer",
        holdtype = "melee",
        killicon = "lambdaplayers/killicons/icon_vwp_toyhammer",
        ismelee = true,
        bonemerge = true,
        keepdistance = 10,
        attackrange = 50,
        offpos = Vector( 0, 0, 0 ),
        offang = Angle( 0, 0, 0 ),


        damage = 5,
        rateoffire = 0.4,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
        attacksnd = "lambdaplayers/weapons/toyhammer/toymiss*2*.wav",
        hitsnd = "lambdaplayers/weapons/toyhammer/toyhit*3*.wav",

        OnEquip = function( lambda, wepent )
            wepent:EmitSound( "lambdaplayers/weapons/toyhammer/toydeploy.wav", 70, random( 97, 101 ) )
        end,

        islethal = true,
    }

})