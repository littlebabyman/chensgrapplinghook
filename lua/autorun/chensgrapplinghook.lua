include("cgh/sh_grapplinghook.lua")
if CLIENT then
    hook.Add("PopulateToolMenu", "chensgrapplinghook", function()
        spawnmenu.AddToolMenuOption("Options", "Grappling Hook", "chensgrapplinghook", "Settings", "", "", function(DForm)
            DForm:Help("Grappling hook")
            DForm:NumSlider("Maximum grapple distance", "cgh_distance", 0, 128^2)
            DForm:NumSlider("Grappling power", "cgh_power", 0, 32^2)
            DForm:NumSlider("Fall damage modifier", "cgh_falldamage", 0, 1, 2)
        end)
    end)
end