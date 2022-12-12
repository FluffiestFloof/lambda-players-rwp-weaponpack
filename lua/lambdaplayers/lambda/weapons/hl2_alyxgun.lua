local random = math.random
local CurTime = CurTime
local bullettbl = {}

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
            
            bullettbl.Attacker = self
            bullettbl.Damage = random( 3, 5 )
            bullettbl.Force = 3
            bullettbl.HullSize = 5
            bullettbl.Num = 1
            bullettbl.TracerName = "Tracer"
            bullettbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bullettbl.Src = wepent:GetPos()
            bullettbl.Spread = Vector( 0.16, 0.16, 0 )
            bullettbl.IgnoreEntity = self
            
            self.l_WeaponUseCooldown = CurTime() + 0.5

            self:SimpleTimer(0.06, function()
                wepent:EmitSound( "weapons/alyx_gun/alyx_gun_fire"..random(3,4)..".wav", 65 )
                self:HandleMuzzleFlash( 1 )
                self:HandleShellEject( "ShellEject", Vector(), Angle( -180, 0, 0 ) )
                bullettbl.Src = wepent:GetPos()
                wepent:FireBullets( bullettbl )
            end)

            self:SimpleTimer(0.12, function()
                wepent:EmitSound( "weapons/alyx_gun/alyx_gun_fire"..random(3,4)..".wav", 65 )
                self:HandleMuzzleFlash( 1 )
                self:HandleShellEject( "ShellEject", Vector(), Angle( -180, 0, 0 ) )
                bullettbl.Src = wepent:GetPos()
                wepent:FireBullets( bullettbl )
            end)

            self.l_Clip = self.l_Clip - 3

            wepent:EmitSound( "Weapon_Alyx_Gun.Single" )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            
            self:HandleMuzzleFlash( 1 )
            self:HandleShellEject( "ShellEject", Vector(), Angle( -180, 0, 0 ) )

            wepent:FireBullets( bullettbl )

            return true
        end,

        islethal = true,
    }

})