local IsValid = IsValid
local CurTime = CurTime
local random = math.random
local Rand = math.Rand
local ents_Create = ents.Create
local grenadeDamage = GetConVar( "sk_plr_dmg_fraggrenade" ):GetFloat()
local grenadeRadius = GetConVar( "sk_fraggrenade_radius" ):GetFloat()

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    vwp_clustergrenade = {
        model = "models/weapons/w_grenade.mdl",
        origin = "Misc",
        prettyname = "Cluster Grenade",
        holdtype = "grenade",
        killicon = "npc_grenade_frag",
        bonemerge = true,
        keepdistance = 500,
        attackrange = 1000,
        
        callback = function( self, wepent, target )
            local grenade = ents_Create( "npc_grenade_frag" )
            if !IsValid( grenade ) then return end

            self.l_WeaponUseCooldown = CurTime() + 1.8

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE )

            grenade:SetPos( self:GetPos() + self:GetUp() * 60 + self:GetForward() * 20 + self:GetRight() * -10 )
            grenade:Fire( "SetTimer", 3, 0 )
            grenade:SetSaveValue( "m_hThrower", self )
            grenade:SetOwner( self )
            grenade:Spawn()
            grenade:SetHealth( 99999 )

            local throwForce = 1200
            local throwDir = self:GetForward()
            local throwSnd = "WeaponFrag.Throw"
            if IsValid( target ) then
                throwDir = ( target:GetPos() - grenade:GetPos() ):GetNormalized()
                if self:IsInRange( target, 350 ) then
                    throwForce = 400
                    throwSnd = "WeaponFrag.Roll"
                end
            end
            wepent:EmitSound( throwSnd )

            local phys = grenade:GetPhysicsObject()
            if IsValid( phys ) then
                phys:ApplyForceCenter( throwDir * throwForce )
                phys:AddAngleVelocity( Vector( 600, random(-1200, 1200) ) )
            end

            grenade:CallOnRemove( "lambdaplayer_clusternade_"..grenade:EntIndex(), function() 
                for i=1, 5 do
                    local cluster = ents.Create("npc_grenade_frag")
                    cluster:SetPos( grenade:GetPos() + Vector( 0, 0, 10 ) )
                    cluster:Fire( "SetTimer", Rand( 1, 2 ) , 0 )
                    cluster:SetSaveValue( "m_hThrower", self )
                    cluster:SetSaveValue( "m_flDamage", grenadeDamage/2 )
                    cluster:SetSaveValue( "m_DmgRadius", grenadeRadius/2 )
                    cluster:SetOwner( grenade:GetOwner() )
                    cluster:SetModelScale( cluster:GetModelScale() / 2 , 0.01 )
                    cluster:Spawn()
                    cluster:SetHealth( 99999 )
                    
                    local phys = cluster:GetPhysicsObject()
                    if IsValid(phys) then
                        phys:ApplyForceCenter( VectorRand( -500, 500 ) )
                        phys:AddAngleVelocity(Vector( 500, 600, 0 ))
                    end
                end
            end )

            return true
        end,

        islethal = true,
    }

})