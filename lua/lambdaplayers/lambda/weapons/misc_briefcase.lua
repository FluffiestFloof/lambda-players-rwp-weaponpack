local random = math.random
local CurTime = CurTime
local IsValid = IsValid

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_briefcase = {
        model = "models/lambdaplayers/briefcase/w_briefcase.mdl",
        origin = "Misc",
        prettyname = "Briefcase",
        holdtype = "melee",
        killicon = "lambdaplayers/killicons/icon_vwp_briefcase",
        ismelee = true,
        bonemerge = true,
        keepdistance = 10,
        attackrange = 50,

        OnEquip = function( lambda, wepent )
            wepent:EmitSound( "vo/gman_misc/gman_04.wav", 60 )
        end,

        callback = function( self, wepent, target )
            self.l_WeaponUseCooldown = CurTime() + 1

            wepent:EmitSound( "Weapon_Crowbar.Single", 70 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE )

            self:SimpleTimer( 0.075, function()
                if !IsValid( target ) or self:GetRangeSquaredTo( target ) > ( 70 * 70 ) then return end

                local dmg = random( 15, 25 )
                local dmginfo = DamageInfo()
                dmginfo:SetDamage( dmg )
                dmginfo:SetAttacker( self )
                dmginfo:SetInflictor( wepent )
                dmginfo:SetDamageType( DMG_CLUB )
                dmginfo:SetDamageForce( ( target:WorldSpaceCenter() - self:WorldSpaceCenter() ):GetNormalized() * dmg )
                target:TakeDamageInfo( dmginfo )
                
                wepent:EmitSound( "physics/wood/wood_box_impact_hard"..random( 4, 6 )..".wav", 75 )
            end)

            return true
        end,

        islethal = true,
    }

})