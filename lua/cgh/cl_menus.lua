hook.Add("PopulateToolMenu", "chensgrapplinghook", function()
    spawnmenu.AddToolMenuOption("Options", "#cgh.menu.name", "chensgrapplinghook", "Settings", "", "", function(DForm)
        -- DForm:Help("#cgh.menu.name")
        DForm:NumSlider("#cgh.menu.distance", "cgh_distance", 0, 128 ^ 2)
        DForm:NumSlider("#cgh.menu.power", "cgh_power", 0, 32 ^ 2)
        DForm:CheckBox("#cgh.menu.falldamage", "cgh_falldamage")
    end)
end)