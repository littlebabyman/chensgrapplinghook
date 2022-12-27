AddCSLuaFile()

CreateConVar("cgh_distance", "2048", {FCVAR_ARCHIVE}, "Grappling hook's maximum grapple distance", 0)
CreateConVar("cgh_power", "100", FCVAR_ARCHIVE, "Grappling hook's pulling power.", 0)
CreateConVar("cgh_falldamage", "0", FCVAR_ARCHIVE, "Enable fall damage when using grappling hook.", 0, 1)
if CLIENT then
    CreateClientConVar("cgh_key", "g", true, true, "Key to bind grappling to.")
end