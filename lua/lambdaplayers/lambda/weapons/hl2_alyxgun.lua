local random = math.random
local CurTime = CurTime
local bulletInfo = {
    Force = 3,
    HullSize = 5,
    Num = 1,
    TracerName = "Tracer",
    Spread = Vector( 0.16, 0.16, 0 )
}

local function ShootGun( lambda, wepent )
    bulletInfo.Attacker = lambda
    bulletInfo.Damage = random( 3, 5 )
    bulletInfo.Src = wepent:GetPos()
    bulletInfo.IgnoreEntity = lambda

    wepent:EmitSound( "weapons/alyx_gun/alyx_gun_fire"..random(3,4)..".wav", 75, 100, 1, CHAN_WEAPON )
    lambda:HandleMuzzleFlash( 1 )
    lambda:HandleShellEject( "ShellEject", Vector(), Angle( -180, 0, 0 ) )
    wepent:FireBullets( bulletInfo )
    
    lambda.l_Clip = lambda.l_Clip - 1
end

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_alyxgun = {
        model = "models/weapons/w_alyx_gun.mdl",
        origin = "Half-Life 2",
        prettyname = "Alyx Gun",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_vwp_alyxgun",
        bonemerge = true,
        keepdistance = 325,
        attackrange = 2000,
        offpos = Vector( 3, 0, 3.5 ),   
        offang = Angle( 0, 0, 0 ),

        clip = 30,

        reloadtime = 1.8,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1,
        reloadsounds = { { 0, "Weapon_Pistol.Reload" } },

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end
            
            self.l_WeaponUseCooldown = CurTime() + 0.5

            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()

            ShootGun( self, wepent )

            self:SimpleTimer(0.06, function()
                ShootGun( self, wepent )
            end)

            self:SimpleTimer(0.12, function()
                ShootGun( self, wepent )
            end)

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            return true
        end,

        islethal = true,
    }

})