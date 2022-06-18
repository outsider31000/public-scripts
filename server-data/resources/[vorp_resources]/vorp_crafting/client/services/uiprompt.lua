UIPrompt = {}

local promptGroup = GetRandomIntInRange(0, 0xffffff)

UIPrompt.activate = function(title)
    local label = CreateVarString(10, 'LITERAL_STRING', title)
    PromptSetActiveGroupThisFrame(promptGroup, label)
end

UIPrompt.initialize = function()
    local str = _U('CraftText')
    CraftPrompt = PromptRegisterBegin()
    PromptSetControlAction(CraftPrompt, keys["G"])
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(CraftPrompt, str)
    PromptSetEnabled(CraftPrompt, 1)
    PromptSetVisible(CraftPrompt, 1)
    PromptSetStandardMode(CraftPrompt, 1)
    PromptSetGroup(CraftPrompt, promptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, CraftPrompt, true)
    PromptRegisterEnd(CraftPrompt)
end