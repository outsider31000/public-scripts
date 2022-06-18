InputsService = {}
local text = nil

InputsService.CloseInput = function()
    SetNuiFocus(false, false)
    SendNUIMessage(NUIEvent:New({ style = "none" }))
end

---@param result table
InputsService.SetSubmit = function(result)
    text = result.stringtext
end

---@param result table
InputsService.SetClose = function(result)
    text = result.stringtext
end

---@param title string
---@param placeHolder string
---@param cb function
InputsService.GetInputs = function(title, placeHolder, cb)
    InputsService.WaitForInputs(title, placeHolder, cb)
end

---@param title string
---@param placeHolder string
---@param inputType string
---@param cb function
InputsService.GetInputsWithInputType = function(title, placeHolder, inputType, cb)
    InputsService.WaitForInputs(title, placeHolder, cb, inputType)
end

---@param inputConfig string
---@param cb function
InputsService.OnAdvancedInput = function(inputConfig, cb)
    SetNuiFocus(true, true)
    SendNUIMessage(json.decode(inputConfig))

    while text == nil do
        Wait(1)
    end

    cb(text)

    Wait(1)
    text = nil

    InputsService.CloseInput()
end

---@param button string
---@param placeHolder string
---@param cb function
---@param inputType string
InputsService.WaitForInputs = function(button, placeHolder, cb, inputType)
    inputType = inputType or "input" or "textarea"

    SetNuiFocus(true, true)
    SendNUIMessage(NUIEvent:New({
        style = "block",
        button = button,
        placeholder = placeHolder,
        inputType = inputType,
    }))

    while text == nil do
        Wait(1)
    end

    cb(text)
    Wait(1)
    text = nil

    InputsService.CloseInput()
end
