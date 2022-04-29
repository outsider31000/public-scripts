WarMenu = { }

WarMenu.debug = false


local menus = { }
local keys = { up = 0x911CB09E, down = 0x4403F97F, left = 0xAD7FCC5B, right = 0x65F9EC5B, select = 0xC7B5340A, back = 0x308588E6 }
local optionCount = 0

local currentKey = nil
local currentMenu = nil

local titleHeight = 0.09
local titleYOffset = 0.010
local titleScale = 1.0

local buttonHeight = 0.038
local buttonFont = 7
local buttonScale = 0.365

local buttonTextXOffset = 0.003
local buttonTextYOffset = 0.005


local function debugPrint(text)
	if WarMenu.debug then
		Citizen.Trace('[WarMenu] '..tostring(text))
	end
end


local function setMenuProperty(id, property, value)
	if id and menus[id] then
		menus[id][property] = value
		debugPrint(id..' menu property changed: { '..tostring(property)..', '..tostring(value)..' }')
	end
end


local function isMenuVisible(id)
	if id and menus[id] then
		return menus[id].visible
	else
		return false
	end
end


local function setMenuVisible(id, visible, holdCurrent)
	if id and menus[id] then
		setMenuProperty(id, 'visible', visible)

		if not holdCurrent and menus[id] then
			setMenuProperty(id, 'currentOption', 1)
		end

		if visible then
			if id ~= currentMenu and isMenuVisible(currentMenu) then
				setMenuVisible(currentMenu, false)
			end

			currentMenu = id
		end
	end
end

local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)

    local str = CreateVarString(10, "LITERAL_STRING", text)

    if color then
        SetTextColor(255, 255, 255, color.a)
    else
        SetTextColor(255, 255, 255, 255)
    end

    SetTextFontForCurrentCommand(font)
    SetTextScale(scale, scale)

    if shadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end

    if center then
        SetTextCentre(center)
    elseif alignRight then
        --DisplayText(menus[currentMenu].x, menus[currentMenu].x + menus[currentMenu].width - buttonTextXOffset)
    end

    DisplayText(str, x, y)

end


local function drawRect(x, y, width, height, color)
	DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
end


local function drawTitle()
	if menus[currentMenu] then
		local x = menus[currentMenu].x + menus[currentMenu].width / 2
		local y = menus[currentMenu].y + titleHeight / 2

		if HasStreamedTextureDictLoaded("menu_textures") and HasStreamedTextureDictLoaded("generic_textures") then
			SetScriptGfxDrawOrder(0)
			DrawSprite("menu_textures", "translate_bg_1a", x, y +0.26, 0.28, 0.70, 180.8, 000, 2, 2, 255, 1)
			DrawSprite("generic_textures", "menu_header_1a", x, y, menus[currentMenu].width + .03, titleHeight, 0.0, 255, 40, 40, 255, 0)
		end
		DrawSprite("generic_textures", "list_item_h_line_narrow", x, y + 0.0799, menus[currentMenu].width+ 0.01, 0.003, 0.0, 255, 40, 40, 255, 0)

		drawText(menus[currentMenu].title, x, y - titleHeight / 2 + titleYOffset, menus[currentMenu].titleFont, { r = 255, g = 255, b = 255, a = 255 } , titleScale, true, true, false)
	end
end


local function drawSubTitle()
	if menus[currentMenu] then
		local x = menus[currentMenu].x + menus[currentMenu].width / 2
		local y = menus[currentMenu].y + titleHeight + buttonHeight / 2

		local subTitleColor = { r = 255, g = 255, b = 255, a = 255 }

		if HasStreamedTextureDictLoaded("generic_textures") then
			SetScriptGfxDrawOrder(5)
			DrawSprite("generic_textures", "selection_box_bg_1d", x, y - 0.002, menus[currentMenu].width + 0.01 , buttonHeight, 0.0, 0, 0, 0, 255, 0)
		end

		drawText(menus[currentMenu].subTitle, menus[currentMenu].x + buttonTextXOffset + 0.00, y+0.005 - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false)
		--DrawSprite("menu_textures", "divider_line", x, y - 0.002, menus[currentMenu].width+ 0.001, 0.02, 0.0, 255, 255, 255, 255, 0)
		--drawText(tostring(menus[currentMenu].currentOption)..' / '..tostring(optionCount), menus[currentMenu].x + buttonTextXOffset + menus[currentMenu].width - 0.015, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTextColor, buttonScale, false, shadow, true)
	end
end


local function drawButton(text, subText)
	local x = menus[currentMenu].x + menus[currentMenu].width / 2
	local multiplier = nil

	if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
		multiplier = optionCount
	elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then
		multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
	end

	if multiplier then
		local y = menus[currentMenu].y+0.03 + titleHeight + buttonHeight + (buttonHeight * multiplier) - buttonHeight / 2
		local backgroundColor = nil
		local textColor = nil
		local subTextColor = nil
		local shadow = false

		if menus[currentMenu].currentOption == optionCount then
			backgroundColor = menus[currentMenu].menuFocusBackgroundColor
			textColor = menus[currentMenu].menuFocusTextColor
			subTextColor = menus[currentMenu].menuFocusTextColor
		else
			backgroundColor = menus[currentMenu].menuBackgroundColor
			textColor = menus[currentMenu].menuTextColor
			subTextColor = menus[currentMenu].menuSubTextColor
			shadow = true
		end


		if menus[currentMenu].currentOption == optionCount then
			if HasStreamedTextureDictLoaded("generic_textures") then
				SetScriptGfxDrawOrder(2)
				DrawSprite("generic_textures", "selection_box_bg_1d", x, y - 0.002, menus[currentMenu].width+ 0.01, buttonHeight, 0.0, 255, 40, 40, 255, 0)
			end
		else
			if HasStreamedTextureDictLoaded("generic_textures") then
				SetScriptGfxDrawOrder(1)
				DrawSprite("generic_textures", "selection_box_bg_1d", x, y - 0.002, menus[currentMenu].width+ 0.01, buttonHeight, 0.0, 0, 0, 0, 255, 0)
			end
		end

		drawText(text, menus[currentMenu].x + buttonTextXOffset - 0.002, y - (buttonHeight / 2) + buttonTextYOffset, buttonFont, textColor, buttonScale, false, shadow)

		if subText then
			drawText(subText, menus[currentMenu].x + buttonTextXOffset + menuWidth - 0.01, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTextColor, buttonScale, false, shadow, true)
		end
	end
end


function WarMenu.CreateMenu(id, title)
	-- Default settings
	menus[id] = { }
	menus[id].title = title
	menus[id].subTitle = 'INTERACTION MENU'

	menus[id].visible = false

	menus[id].previousMenu = nil

	menus[id].aboutToBeClosed = false

	menus[id].x = 0.02
	menus[id].y = 0.10

	menus[id].width = 0.21

	menus[id].currentOption = 1
	menus[id].maxOptionCount = 12

	menus[id].titleFont = 7
	menus[id].titleColor = { r = 255, g = 255, b = 255, a = 255 }
	menus[id].titleBackgroundColor = { r = 186, g = 2, b = 2, a = 255 }
	menus[id].titleBackgroundSprite = nil

	menus[id].menuTextColor = { r = 255, g = 255, b = 255, a = 255 }
	menus[id].menuSubTextColor = { r = 189, g = 189, b = 189, a = 255 }
	menus[id].menuFocusTextColor = { r = 0, g = 0, b = 0, a = 255 }
	menus[id].menuFocusBackgroundColor = { r = 245, g = 245, b = 245, a = 255 }
	menus[id].menuBackgroundColor = { r = 0, g = 0, b = 0, a = 160 }

	menus[id].subTitleBackgroundColor = { r = menus[id].menuBackgroundColor.r, g = menus[id].menuBackgroundColor.g, b = menus[id].menuBackgroundColor.b, a = 255 }

	menus[id].buttonPressedSound = { name = "SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" } --https://pastebin.com/0neZdsZ5

	debugPrint(tostring(id)..' menu created')
end


function WarMenu.CreateSubMenu(id, parent, subTitle)
	if menus[parent] then
		WarMenu.CreateMenu(id, menus[parent].title)

		if subTitle then
			setMenuProperty(id, 'subTitle', string.upper(subTitle))
		else
			setMenuProperty(id, 'subTitle', string.upper(menus[parent].subTitle))
		end

		setMenuProperty(id, 'previousMenu', parent)

		setMenuProperty(id, 'x', menus[parent].x)
		setMenuProperty(id, 'y', menus[parent].y)
		setMenuProperty(id, 'maxOptionCount', menus[parent].maxOptionCount)
		setMenuProperty(id, 'titleFont', menus[parent].titleFont)
		setMenuProperty(id, 'titleColor', menus[parent].titleColor)
		setMenuProperty(id, 'titleBackgroundColor', menus[parent].titleBackgroundColor)
		setMenuProperty(id, 'titleBackgroundSprite', menus[parent].titleBackgroundSprite)
		setMenuProperty(id, 'menuTextColor', menus[parent].menuTextColor)
		setMenuProperty(id, 'menuSubTextColor', menus[parent].menuSubTextColor)
		setMenuProperty(id, 'menuFocusTextColor', menus[parent].menuFocusTextColor)
		setMenuProperty(id, 'menuFocusBackgroundColor', menus[parent].menuFocusBackgroundColor)
		setMenuProperty(id, 'menuBackgroundColor', menus[parent].menuBackgroundColor)
		setMenuProperty(id, 'subTitleBackgroundColor', menus[parent].subTitleBackgroundColor)
	else
		debugPrint('Failed to create '..tostring(id)..' submenu: '..tostring(parent)..' parent menu doesn\'t exist')
	end
end


function WarMenu.CurrentMenu()
	return currentMenu
end


function WarMenu.OpenMenu(id)
	if id and menus[id] then
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		setMenuVisible(id, true)
		debugPrint(tostring(id)..' menu opened')
	else
		debugPrint('Failed to open '..tostring(id)..' menu: it doesn\'t exist')
	end
end


function WarMenu.IsMenuOpened(id)
	return isMenuVisible(id)
end


function WarMenu.IsAnyMenuOpened()
	for id, _ in pairs(menus) do
		if isMenuVisible(id) then return true end
	end

	return false
end


function WarMenu.IsMenuAboutToBeClosed()
	if menus[currentMenu] then
		return menus[currentMenu].aboutToBeClosed
	else
		return false
	end
end


function WarMenu.CloseMenu()
	FreezeEntityPosition(PlayerPedId(), false)
	if menus[currentMenu] then
		if menus[currentMenu].aboutToBeClosed then
			menus[currentMenu].aboutToBeClosed = false
			setMenuVisible(currentMenu, false)
			debugPrint(tostring(currentMenu)..' menu closed')
			PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			optionCount = 0
			currentMenu = nil
			currentKey = nil
		else
			menus[currentMenu].aboutToBeClosed = true
			debugPrint(tostring(currentMenu)..' menu about to be closed')
		end
	end
end


function WarMenu.Button(text, subText)
	local buttonText = text
	if subText then
		buttonText = '{ '..tostring(buttonText)..', '..tostring(subText)..' }'
	end

	if menus[currentMenu] then
		optionCount = optionCount + 1

		local isCurrent = menus[currentMenu].currentOption == optionCount

		drawButton(text, subText)

		if isCurrent then
			if currentKey == keys.select then
				PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
				debugPrint(buttonText..' button pressed')
				return true
			elseif currentKey == keys.left or currentKey == keys.right then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			end
		end

		return false
	else
		debugPrint('Failed to create '..buttonText..' button: '..tostring(currentMenu)..' menu doesn\'t exist')

		return false
	end
end


function WarMenu.MenuButton(text, id)
	if menus[id] then
		if WarMenu.Button(text) then
			setMenuVisible(currentMenu, false)
			setMenuVisible(id, true, true)

			return true
		end
	else
		debugPrint('Failed to create '..tostring(text)..' menu button: '..tostring(id)..' submenu doesn\'t exist')
	end

	return false
end


function WarMenu.CheckBox(text, checked, callback)
	if WarMenu.Button(text, checked and 'On' or 'Off') then
		checked = not checked
		debugPrint(tostring(text)..' checkbox changed to '..tostring(checked))
		if callback then callback(checked) end

		return true
	end

	return false
end


function WarMenu.ComboBox(text, items, currentIndex, selectedIndex, callback)
	local itemsCount = #items
	local selectedItem = items[currentIndex]
	local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)

	if itemsCount > 1 and isCurrent then
		selectedItem = '← '..tostring(selectedItem)..' →'
	end

	if WarMenu.Button(text, selectedItem) then
		selectedIndex = currentIndex
		callback(currentIndex, selectedIndex)
		return true
	elseif isCurrent then
		if currentKey == keys.left then
			if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end
		elseif currentKey == keys.right then
			if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end
		end
	else
		currentIndex = selectedIndex
	end

	callback(currentIndex, selectedIndex)
	return false
end


function WarMenu.Display()
	if isMenuVisible(currentMenu) then
		if menus[currentMenu].aboutToBeClosed then
			WarMenu.CloseMenu()
		else
			ClearAllHelpMessages()

			drawTitle()
			drawSubTitle()

			currentKey = nil

			if IsControlJustReleased(1, keys.down) then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

				if menus[currentMenu].currentOption < optionCount then
					menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1
				else
					menus[currentMenu].currentOption = 1
				end
			elseif IsControlJustReleased(1, keys.up) then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

				if menus[currentMenu].currentOption > 1 then
					menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1
				else
					menus[currentMenu].currentOption = optionCount
				end
			elseif IsControlJustReleased(1, keys.left) then
				currentKey = keys.left
			elseif IsControlJustReleased(1, keys.right) then
				currentKey = keys.right
			elseif IsControlJustReleased(1, keys.select) then
				currentKey = keys.select
			elseif IsControlJustReleased(1, keys.back) then
				if menus[menus[currentMenu].previousMenu] then
					setMenuVisible(menus[currentMenu].previousMenu, true)
				else
					WarMenu.CloseMenu()
				end
			end

			optionCount = 0
		end
	end
end


function WarMenu.SetMenuWidth(id, width)
	setMenuProperty(id, 'width', width)
end


function WarMenu.SetMenuX(id, x)
	setMenuProperty(id, 'x', x)
end


function WarMenu.SetMenuY(id, y)
	setMenuProperty(id, 'y', y)
end


function WarMenu.SetMenuMaxOptionCountOnScreen(id, count)
	setMenuProperty(id, 'maxOptionCount', count)
end


function WarMenu.SetTitle(id, title)
	setMenuProperty(id, 'title', title)
end


function WarMenu.SetTitleColor(id, r, g, b, a)
	setMenuProperty(id, 'titleColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleColor.a })
end
 
 
function WarMenu.SetTitleBackgroundColor(id, r, g, b, a)
	setMenuProperty(id, 'titleBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleBackgroundColor.a })
end


function WarMenu.SetTitleBackgroundSprite(id, textureDict, textureName)
	RequestStreamedTextureDict(textureDict)
	setMenuProperty(id, 'titleBackgroundSprite', { dict = textureDict, name = textureName })
end


function WarMenu.SetSubTitle(id, text)
	setMenuProperty(id, 'subTitle', string.upper(text))
end


function WarMenu.SetMenuBackgroundColor(id, r, g, b, a)
	setMenuProperty(id, 'menuBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuBackgroundColor.a })
end


function WarMenu.SetMenuTextColor(id, r, g, b, a)
	setMenuProperty(id, 'menuTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuTextColor.a })
end

function WarMenu.SetMenuSubTextColor(id, r, g, b, a)
	setMenuProperty(id, 'menuSubTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuSubTextColor.a })
end

function WarMenu.SetMenuFocusColor(id, r, g, b, a)
	setMenuProperty(id, 'menuFocusColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuFocusColor.a })
end


function WarMenu.SetMenuButtonPressedSound(id, name, set)
	setMenuProperty(id, 'buttonPressedSound', { ['name'] = name, ['set'] = set })
end