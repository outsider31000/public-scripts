Citizen.CreateThread(function()
    WarMenu.CreateMenu('clothes', _U('clothes'))
    WarMenu.SetSubTitle('clothes', _U('select_option'))

    while true do
        if WarMenu.IsMenuOpened('clothes') then
            if WarMenu.Button(_U('remove_hat')) then
                ExecuteCommand(_U('hat'))
            elseif WarMenu.Button(_U('remove_shirt')) then
                ExecuteCommand(_U('shirt'))
            elseif WarMenu.Button(_U('remove_mask')) then
                ExecuteCommand(_U('mask'))
            elseif WarMenu.Button(_U('remove_glasses')) then
                ExecuteCommand(_U('glasses'))
            elseif WarMenu.Button(_U('remove_tie')) then
                ExecuteCommand(_U('tie'))
            elseif WarMenu.Button(_U('remove_neck')) then
                ExecuteCommand(_U('neck'))
            elseif WarMenu.Button(_U('remove_braces')) then
                ExecuteCommand(_U('braces'))
            elseif WarMenu.Button(_U('remove_vest')) then
                ExecuteCommand(_U('vest'))
            elseif WarMenu.Button(_U('remove_coat')) then
                ExecuteCommand(_U('coat'))
            elseif WarMenu.Button(_U('remove_ccoat')) then
                ExecuteCommand(_U('ccoat'))
            elseif WarMenu.Button(_U('remove_poncho')) then
                ExecuteCommand(_U('poncho'))
            elseif WarMenu.Button(_U('remove_layer')) then
                ExecuteCommand(_U('layer'))
            elseif WarMenu.Button(_U('remove_gloves')) then
                ExecuteCommand(_U('gloves'))
            elseif WarMenu.Button(_U('remove_rings')) then
                ExecuteCommand(_U('rings'))
            elseif WarMenu.Button(_U('remove_bracelets')) then
                ExecuteCommand(_U('bracelets'))
            elseif WarMenu.Button(_U('remove_belt')) then
                ExecuteCommand(_U('belt'))
            elseif WarMenu.Button(_U('remove_buckle')) then
                ExecuteCommand(_U('buckle'))
            elseif WarMenu.Button(_U('remove_pants')) then
                ExecuteCommand(_U('pants'))
            elseif WarMenu.Button(_U('remove_skirt')) then
                ExecuteCommand(_U('skirt'))
            elseif WarMenu.Button(_U('remove_chaps')) then
                ExecuteCommand(_U('chaps'))
            elseif WarMenu.Button(_U('remove_boots')) then
                ExecuteCommand(_U('boots'))
            elseif WarMenu.Button(_U('remove_spurs')) then
                ExecuteCommand(_U('spurs'))
            elseif WarMenu.Button(_U('undress')) then
                ExecuteCommand(_U('dressoff'))
            elseif WarMenu.Button(_U('wear')) then
                ExecuteCommand(_U('dresson'))
            end
            WarMenu.Display()
        elseif IsControlJustReleased(0, 0x1F6D95E5) then -- F4
			WarMenu.OpenMenu('clothes')
		end
        Citizen.Wait(0)
    end
end)

RegisterCommand("ccoat", function(source, args)
    
    
end)