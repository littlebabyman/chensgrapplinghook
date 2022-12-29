AddCSLuaFile()

hook.Add("PopulateToolMenu", "chensgrapplinghook", function()
    spawnmenu.AddToolMenuOption("Options", "#cgh.menu.name", "chensgrapplinghook", "Settings", "", "", function(panel)
        -- DForm:Help("#cgh.menu.name")
        local dist = panel:NumSlider("#cgh.menu.distance", "cgh_distance", 0, 128 ^ 2)
        local pwr = panel:NumSlider("#cgh.menu.power", "cgh_power", 0, 32 ^ 2)
        local fd = panel:CheckBox("#cgh.menu.falldamage", "cgh_falldamage")
        local reset = vgui.Create("DButton", panel)
        reset.clicked = false
        panel:AddItem(reset)
        reset:SetText("#cgh.menu.reset")
        function reset:DoClick()
            if reset.clicked then
                reset.clicked = false
                reset:SetText("#cgh.menu.reset.confirmed")
                timer.Simple(2, function()
                    reset:SetText("#cgh.menu.reset")
                end)
            else
                reset.clicked = true
                reset:SetText("#cgh.menu.reset.confirm")
            end
        end
        function reset:DoRightClick()
            if reset.clicked then
                reset.clicked = false
                reset:SetText("#cgh.menu.reset.cancel")
                timer.Simple(2, function()
                    reset:SetText("#cgh.menu.reset")
                end)
            end
        end
        local bt = Label("#cgh.menu.key", panel)
        local bind = vgui.Create("DBinder", panel)
        bt:SetDark(true)
        bind:SetText(GetConVar("cgh_key"):GetString())
        panel:AddItem(bt,bind)
        function bind:OnChange(num)
            GetConVar("cgh_key"):SetString(string.upper(input.GetKeyName(num)))
        end
    end)
end)