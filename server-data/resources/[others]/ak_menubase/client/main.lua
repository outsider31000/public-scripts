MenuData = {}
MenuData.Opened = {}
MenuData.RegisteredTypes = {}

--==================================FUNCTIONS ==================================
MenuData.RegisteredTypes['default'] = {
    open  = function(namespace, name, data)
        SendNUIMessage({
            ak_menubase_action = 'openMenu',
            ak_menubase_namespace = namespace,
             ak_menubase_name = name,
             ak_menubase_data = data
        })end,
    close  = function(namespace, name)
        SendNUIMessage({
            ak_menubase_action = 'closeMenu',
             ak_menubase_namespace = namespace,
             ak_menubase_name = name,
             ak_menubase_data = data
        })
    end
}




function MenuData.Open(type, namespace, name, data, submit, cancel, change, close)
    local menu = {}

    menu.type      = type
    menu.namespace = namespace
    menu.name      = name
    menu.data      = data
    menu.submit    = submit
    menu.cancel    = cancel
    menu.change    = change

    menu.close = function()
        MenuData.RegisteredTypes[type].close(namespace, name)

        for i=1, #MenuData.Opened, 1 do
            if MenuData.Opened[i] then
                if MenuData.Opened[i].type == type and MenuData.Opened[i].namespace == namespace and MenuData.Opened[i].name == name then
                    MenuData.Opened[i] = nil
                end
            end
        end

        if close then
            close()
        end

    end

    menu.update = function(query, newData)

        for i=1, #menu.data.elements, 1 do
            local match = true

            for k,v in pairs(query) do
                if menu.data.elements[i][k] ~= v then
                    match = false
                end
            end

            if match then
                for k,v in pairs(newData) do
                    menu.data.elements[i][k] = v
                end
            end
        end

    end

    menu.refresh = function()
        MenuData.RegisteredTypes[type].open(namespace, name, menu.data)
    end

    menu.setElement = function(i, key, val)
        menu.data.elements[i][key] = val
    end

    menu.setElements = function(newElements)
        menu.data.elements = newElements
    end

    menu.setTitle = function(val)
        menu.data.title = val
    end

    menu.removeElement = function(query)
        for i=1, #menu.data.elements, 1 do
            for k,v in pairs(query) do
                if menu.data.elements[i] then
                    if menu.data.elements[i][k] == v then
						menu.data.elements[i] = nil
                        break
                    end
                end

            end
        end
    end
	MenuData.Opened[#MenuData.Opened+1]= menu
    MenuData.RegisteredTypes[type].open(namespace, name, data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    return menu
end

function MenuData.Close(type, namespace, name)
    for i=1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            if MenuData.Opened[i].type == type and MenuData.Opened[i].namespace == namespace and MenuData.Opened[i].name == name then
                MenuData.Opened[i].close()
                MenuData.Opened[i] = nil
            end
        end
    end
end

function MenuData.CloseAll()
    for i=1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            MenuData.Opened[i].close()
            MenuData.Opened[i] = nil
        end
    end
end

function MenuData.GetOpened (type, namespace, name)
    for i=1, #MenuData.Opened, 1 do
        if MenuData.Opened[i] then
            if MenuData.Opened[i].type == type and MenuData.Opened[i].namespace == namespace and MenuData.Opened[i].name == name then
                return MenuData.Opened[i]
            end
        end
    end
end

function MenuData.GetOpenedMenus()
    return MenuData.Opened
end

function MenuData.IsOpen (type, namespace, name)
    return MenuData.GetOpened(type, namespace, name) ~= nil
end


--==================================FUNCTIONS ==================================

--================================== CALLBACKS ==================================

local Timer, MenuType = 0, 'default'


RegisterNUICallback('menu_submit', function(data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)

    if menu.submit ~= nil then
        menu.submit(data, menu)
    end
end)

RegisterNUICallback('playsound', function()
    PlaySoundFrontend("NAV_LEFT", "PAUSE_MENU_SOUNDSET", true, 0)
end)

RegisterNUICallback('menu_cancel', function(data)
    PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)

    if menu.cancel ~= nil then
        menu.cancel(data, menu)
    end
end)
RegisterNUICallback('menu_change', function(data)
    local menu = MenuData.GetOpened(MenuType, data._namespace, data._name)

    for i=1, #data.elements, 1 do
        menu.setElement(i, 'value', data.elements[i].value)

        if data.elements[i].selected then
            menu.setElement(i, 'selected', true)
        else
            menu.setElement(i, 'selected', false)
        end
    end

    if menu.change ~= nil then
        menu.change(data, menu)
    end
end)
--================================== CALLBACKS ==================================


--==================================  CONTROL SECTION =========================================
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if #MenuData.Opened > 0 then

            if ( IsControlJustPressed(0, 0x43DBF61F)  or  IsDisabledControlJustPressed(0, 0x43DBF61F)) and (GetGameTimer() - Timer) > 250 then
                SendNUIMessage({ak_menubase_action = 'controlPressed', ak_menubase_control = 'ENTER'})
                Timer = GetGameTimer()
            end

            if (IsControlJustPressed(0, 0x308588E6)  or  IsDisabledControlJustPressed(0, 0x308588E6))and (GetGameTimer() - Timer) > 250   then
                SendNUIMessage({ak_menubase_action  = 'controlPressed', ak_menubase_control = 'BACKSPACE'})
                Timer = GetGameTimer()
            end

            if (IsControlJustPressed(0, 0x911CB09E)  or  IsDisabledControlJustPressed(0, 0x911CB09E)) and (GetGameTimer() - Timer) > 150 then

                SendNUIMessage({ak_menubase_action  = 'controlPressed', ak_menubase_control = 'TOP'})
                Timer = GetGameTimer()
            end

            if (IsControlJustPressed(0, 0x4403F97F)  or  IsDisabledControlJustPressed(0, 0x4403F97F)) and (GetGameTimer() - Timer) > 150 then

                SendNUIMessage({ak_menubase_action  = 'controlPressed', ak_menubase_control = 'DOWN'})
                Timer = GetGameTimer()
            end

            if (IsControlJustPressed(0, 0xAD7FCC5B)  or  IsDisabledControlJustPressed(0, 0xAD7FCC5B))  and (GetGameTimer() - Timer) > 150 then
                SendNUIMessage({ak_menubase_action  = 'controlPressed', ak_menubase_control = 'LEFT'})
                Timer = GetGameTimer()
            end

            if (IsControlJustPressed(0, 0x65F9EC5B)  or  IsDisabledControlJustPressed(0, 0x65F9EC5B))and (GetGameTimer() - Timer) > 150 then
                SendNUIMessage({ak_menubase_action  = 'controlPressed', ak_menubase_control = 'RIGHT'})
                Timer = GetGameTimer()
            end
        end
    end
end)


--==================================  CONTROL SECTION =========================================

--==================================  SHARE FUNCTIONS =========================================
AddEventHandler('ak_menubase:getData', function(cb)
    cb(MenuData)
end)
--==================================  SHARE FUNCTIONS =========================================
