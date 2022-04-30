Prompt = {}

PromptType = {
    JustPressed = 0,
    JustReleased = 1,
    Pressed = 2,
    Released = 3,
    StandardHold = 4,
    StandardizedHold = 5
}

Prompt.handle = 0
Prompt.visible = true
Prompt.label = ''
Prompt.type = PromptType.Pressed
Prompt.group = 0
Prompt.eventTriggered = false


function Prompt:Delete()
    Citizen.InvokeNative(0x00EDE88D4D13CF59, self.handle) -- UiPromptDelete
end

function Prompt:HasHoldModeCompleted()
    return Citizen.InvokeNative(0xE0F65F0640EF0617, self.handle) -- UiPromptHasHoldModeCompleted
end

function Prompt:GetEnabled()
    return Citizen.InvokeNative(0x0D00EDDFB58B7F28, self.handle) == 1
end

function Prompt:SetEnabled(enabled)
    Citizen.InvokeNative(0x8A0FB4D03A630D21, self.handle, enabled) -- UiPromptSetEnabled
end

function Prompt:GetVisible()
    return self.visible
end

function Prompt:SetVisible(visible)
    if visible == self.visible then
        return
    end
    self.visible = visible
    self:SetEnabled(visible)
    Citizen.InvokeNative(0x71215ACCFDE075EE, self.handle, visible) -- UiPromptSetVisible
end

function Prompt:New(control, label, promptType, group)
    local priority = 1
    local transportMode = 0
    local tag = nil
    local contextPoint = nil -- vector3
    local contextSize = 0 -- float
    local timedEventHash = 0

    local promptHandle = Citizen.InvokeNative(0x04F97DE45A519419) -- UiPromptRegisterBegin

    Citizen.InvokeNative(0xB5352B7494A08258, promptHandle, control) -- UiPromptSetControlAction

    local strLabel = CreateVarString(10, "LITERAL_STRING", label)
    Citizen.InvokeNative(0x5DD02A8318420DD7, promptHandle, strLabel) -- UiPromptSetText

    Citizen.InvokeNative(0xCA24F528D0D16289, promptHandle, priority) -- UiPromptSetPriority
    Citizen.InvokeNative(0x876E4A35C73A6655, promptHandle, transportMode) -- UiPromptSetTransportMode
    Citizen.InvokeNative(0x560E76D5E2E1803F, promptHandle,  18, true) -- UiPromptSetAttribute

    if tag ~= nil and #tag > 0 then
        Citizen.InvokeNative(0xDEC85C174751292B, promptHandle, tag) -- UiPromptSetTag
    end

    -- All of this is still being tested and checked
    if promptType == PromptType.JustReleased or promptType == PromptType.Released then
        Citizen.InvokeNative(0xCC6656799977741B, promptHandle, true)
    elseif promptType == PromptType.JustPressed or promptType == PromptType.Pressed then
        Citizen.InvokeNative(0xCC6656799977741B, promptHandle, false)
    elseif promptType == PromptType.StandardHold then
        Citizen.InvokeNative(0x94073D5CA3F16B7B, promptHandle, true) -- UiPromptSetHoldMode
    elseif promptType == PromptType.StandardizedHold then
        Citizen.InvokeNative(0x74C7D7B72ED0D3CF, promptHandle, timedEventHash) -- PromptSetStandardizedHoldMode
    end

    if contextPoint ~= nil then
        Citizen.InvokeNative(0xAE84C5EE2C384FB3, promptHandle, contextPoint.x, contextPoint.y, contextPoint.z)
    end

    if contextSize > 0 then
        Citizen.InvokeNative(0x0C718001B77CA468, promptHandle, contextSize)
    end

    if group > 0 then
        Citizen.InvokeNative(0x2F11D3A254169EA4, promptHandle, group, 0) -- UiPromptSetGroup
    end

    Citizen.InvokeNative(0x71215ACCFDE075EE, promptHandle, false) -- UiPromptSetVisible
    Citizen.InvokeNative(0x8A0FB4D03A630D21, promptHandle, false) -- UiPromptSetEnabled

    Citizen.InvokeNative(0xF7AA2696A22AD8B9, promptHandle) -- UiPromptRegisterEnd


    local t = {handle = promptHandle, type= promptType, label = label}
	setmetatable(t, self)
	self.__index = self
	return t
end