table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_hackmonitor = {
        model = "",
        origin = "Misc",
        prettyname = "Anti Hacks Monitors",
        holdtype = "magic",
        killicon = "lambdaplayers/killicons/icon_vwp_hackmonitor",
        bonemerge = true,
        nodraw = true,
        keepdistance = 500,
        attackrange = 2000,

        clip = 1,

        callback = function( self, wepent, target )
            local monitor = ents.Create( "prop_physics" )
            if !IsValid( monitor ) then return end
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + 2

            self:EmitSound( "vo/npc/male01/hacks01.wav" )
            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )

            monitor:SetModel( "models/props_lab/monitor01a.mdl" )
            monitor:SetPos( wepent:GetPos() + self:GetForward() * 40 )
            monitor:SetAngles( self:GetForward():Angle() )
            monitor:SetOwner(self)
            monitor:Spawn()

            local normal = ( target:GetPos() - monitor:GetPos() ):GetNormalized()

            local phys = monitor:GetPhysicsObject()

            if IsValid( phys ) then phys:ApplyForceCenter( normal * 700000 ) end

            local propCallback = monitor:AddCallback('PhysicsCollide', function(ent, data)
                local dmg = data.HitSpeed:Length()
                if IsValid( ent ) and IsValid( data.HitEntity ) and data.HitEntity != self and dmg >= 750 then
                    local propDmg = DamageInfo()
                    propDmg:SetDamage( dmg )
                    propDmg:SetInflictor( IsValid( wepent ) and wepent or ent )
                    propDmg:SetAttacker( self )
                    propDmg:SetDamageType( DMG_CRUSH )
                    data.HitEntity:TakeDamageInfo( propDmg )
                    ent:EmitSound('physics/metal/metal_box_break'..math.random( 2 )..'.wav', 70, math.random( 90, 110 ))
                end
            end)
            timer.Simple( 5, function() if IsValid( monitor ) then monitor:RemoveCallback('PhysicsCollide', propCallback) end end)
            timer.Simple( 10, function() if IsValid( monitor ) then monitor:Remove() end end)
        

            return true
        end,

        islethal = true,
    }

})