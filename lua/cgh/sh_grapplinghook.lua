AddCSLuaFile()

CreateConVar("cgh_distance", "2048", {FCVAR_ARCHIVE}, "Grappling hook's maximum grapple distance", 0)
CreateConVar("cgh_power", "100", FCVAR_ARCHIVE, "Grappling hook's pulling power.", 0)
CreateConVar("cgh_falldamage", "0", FCVAR_ARCHIVE, "Fall damage multiplier when using grappling hook.", 0)
local ct = CurTime()
local trace = {}
local vel = Vector()
local dist, power, mult = GetConVar("cgh_distance"):GetInt(), GetConVar("cgh_power"):GetInt(), GetConVar("cgh_falldamage"):GetFloat()
local function ResetCurTime() ct = CurTime() + engine.TickInterval() end
cvars.AddChangeCallback("cgh_distance", function() dist = GetConVar("cgh_distance"):GetInt() end)
cvars.AddChangeCallback("cgh_power", function() dist = GetConVar("cgh_power"):GetInt() end)
cvars.AddChangeCallback("cgh_falldamage", function() dist = GetConVar("cgh_falldamage"):GetInt() end)

hook.Add("SetupMove", "chensgrapplinghook", function(ply, mv, cmd)
    if mv:KeyPressed(IN_USE) then
        trace = util.TraceLine({
            start = ply:EyePos(),
            endpos = ply:EyePos() + ply:GetAimVector() * dist,
            filter = {ply},
        })
        if !trace.Hit then return end
        -- ply.grappling = true
        ResetCurTime()
        dir = trace.HitPos
        sound.Play("NPC_Combine.Zipline_Start", trace.HitPos, 75, 100, 1)
        ply:EmitSound("NPC_Combine.Zipline_MidClothing")
    end
    if trace.Hit then
        if mv:KeyDown(IN_USE) && CurTime() > ct then
            vel = (dir - ply:EyePos()) * (power / dist) / trace.Fraction
            ResetCurTime()
            mv:SetVelocity(mv:GetVelocity() + vel)
            debugoverlay.Line(dir, ply:EyePos(), 0)
        elseif mv:KeyReleased(IN_USE) then
            -- ply.grappling = false
            ply:EmitSound("d1_town.CarRelease")
        end
    -- else ply.grappling = false 
    end
end)

--[[hook.Add("GetFallDamage", "chensgrapplinghook", function(ply, speed)
    if ply.grappling then return mult end
end)]]