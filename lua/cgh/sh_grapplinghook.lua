AddCSLuaFile()

local ct = CurTime()
local trace = {}
local vel = Vector()
local dist, power = GetConVar("cgh_distance"):GetInt(), GetConVar("cgh_power"):GetInt()
local fd = GetConVar("cgh_falldamage"):GetBool()
local function ResetCurTime() ct = CurTime() + engine.TickInterval() end
cvars.AddChangeCallback("cgh_distance", function() dist = GetConVar("cgh_distance"):GetInt() end)
cvars.AddChangeCallback("cgh_power", function() power = GetConVar("cgh_power"):GetInt() end)
cvars.AddChangeCallback("cgh_falldamage", function() mult = GetConVar("cgh_falldamage"):GetInt() end)

hook.Add("SetupMove", "chensgrapplinghook", function(ply, mv, cmd)
    if !ply:IsValid() or !IsFirstTimePredicted() then return end
    if mv:KeyPressed(IN_USE) && !ply:InVehicle() then
        trace = util.TraceLine({
            start = ply:EyePos(),
            endpos = ply:EyePos() + ply:GetAimVector() * dist,
            filter = {ply},
        })
        if !trace.Hit then return end
        ply.grappling = true
        ResetCurTime()
        dir = trace.HitPos
        sound.Play("NPC_Combine.Zipline_Start", trace.HitPos, 75, 100, 1)
        ply:EmitSound("NPC_Combine.Zipline_MidClothing")
    end
    if trace.Hit && ply:GetMoveType() == MOVETYPE_WALK then
        if mv:KeyDown(IN_USE) && CurTime() > ct then
            vel = (dir - ply:EyePos()) * power / dist * 0.5 / trace.Fraction
            ResetCurTime()
            mv:SetVelocity(mv:GetVelocity() + vel)
            debugoverlay.Line(dir, ply:EyePos(), 0.1)
            print(vel, mv:GetVelocity():Length())
        elseif mv:KeyReleased(IN_USE) then
            ply.grappling = false
            ply:EmitSound("d1_town.CarRelease")
        end
    end
end)

if SERVER then
    hook.Add("GetFallDamage", "chensgrapplinghook", function(ply, speed)
        if ply.grappling && !fd then return 0 end
    end)
end