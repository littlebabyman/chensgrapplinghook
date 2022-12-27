hook.Add("PopulateToolMenu", "chensgrapplinghook", function()
    spawnmenu.AddToolMenuOption("Options", "#cgh.menu.name", "chensgrapplinghook", "Settings", "", "", function(panel)
        -- DForm:Help("#cgh.menu.name")
        panel:NumSlider("#cgh.menu.distance", "cgh_distance", 0, 128 ^ 2)
        panel:NumSlider("#cgh.menu.power", "cgh_power", 0, 32 ^ 2)
        panel:CheckBox("#cgh.menu.falldamage", "cgh_falldamage")
        local bind = vgui.Create("DBinder", panel)
        bind:SetText(GetConVar("cgh_key"):GetString())
        panel:AddItem(bind)
        function bind:OnChange(num)
            GetConVar("cgh_key"):SetString(input.GetKeyName(num))
        end
    end)
end)