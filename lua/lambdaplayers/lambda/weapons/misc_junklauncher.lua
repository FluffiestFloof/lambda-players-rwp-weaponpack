local IsValid = IsValid
local CurTime = CurTime
local ents_Create = ents.Create
local random = math.random
local Rand = math.Rand

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_junklauncher = {
        model = "models/weapons/w_rocket_launcher.mdl",
        origin = "Misc",
        prettyname = "Junk Launcher",
        holdtype = "rpg",
        killicon = "lambdaplayers/killicons/icon_vwp_junklauncher",
        bonemerge = true,
        keepdistance = 700,
        attackrange = 4000,

        callback = function( self, wepent, target )            
            self.l_WeaponUseCooldown = CurTime() + 3

            wepent:EmitSound( "Weapon_SMG1.Double" )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG )

            -- A --
            local function ThrowJunk()
                local mdls = {
                    "models/props_junk/garbage_milkcarton001a.mdl",
                    "models/props_junk/garbage_milkcarton002a.mdl",
                    "models/props_junk/garbage_metalcan002a.mdl",
                    "models/props_junk/garbage_metalcan001a.mdl",
                    "models/props_junk/garbage_glassbottle002a.mdl",
                    "models/props_junk/garbage_plasticbottle002a.mdl",
                    "models/props_junk/garbage_plasticbottle003a.mdl",
                    "models/props_junk/garbage_newspaper001a.mdl",
                    "models/props_junk/garbage_bag001a.mdl",
                    "models/props_junk/glassjug01.mdl",
                    "models/props_junk/GlassBottle01a.mdl",
                    "models/props_junk/garbage_takeoutcarton001a.mdl",
                    "models/props_junk/plasticbucket001a.mdl",
                    "models/props_junk/PopCan01a.mdl",
                    "models/props_interiors/pot02a.mdl"
                }
                
                local vecThrow = ( target:WorldSpaceCenter() - self:EyePos() ):Angle()
                local ent = ents.Create("prop_physics")
                ent:SetModel( mdls[math.random(#mdls)] )
                ent:SetPos( self:EyePos() + vecThrow:Forward() * 32 + vecThrow:Up() * 16 )
                ent:SetAngles( vecThrow )
                ent:SetOwner( self )
                ent:Spawn()

                local velocity = vecThrow:Forward()

                velocity = velocity * 100000
                velocity = velocity + ( VectorRand() * 5000 )
                ent:GetPhysicsObject():ApplyForceCenter( velocity )

                local propCallback = ent:AddCallback('PhysicsCollide', function(ent, data)
                    local dmg = data.HitSpeed:Length()
                    if IsValid( ent ) and IsValid( data.HitEntity ) and data.HitEntity != self and dmg >= 750 then
                        local propDmg = DamageInfo()
                        propDmg:SetDamage( dmg )
                        propDmg:SetInflictor( IsValid( wepent ) and wepent or ent )
                        propDmg:SetAttacker( self )
                        propDmg:SetDamageType( DMG_CRUSH )
                        data.HitEntity:TakeDamageInfo( propDmg )
                    end
                end)
                timer.Simple( 5, function() if IsValid(ent) then ent:RemoveCallback('PhysicsCollide', propCallback) end end )
                timer.Simple( 15, function() if IsValid(ent) then ent:Remove() end end )

            end

            for i = 1, 5 do
                ThrowJunk()
            end

            -- A --

            return true
        end,

        islethal = true,
    }

})