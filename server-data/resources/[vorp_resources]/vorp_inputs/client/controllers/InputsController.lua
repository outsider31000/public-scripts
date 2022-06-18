RegisterNetEvent('vorpinputs:getInput', InputsService.GetInputs)
RegisterNetEvent('vorpinputs:getInputsWithInputType', InputsService.GetInputsWithInputType)
RegisterNetEvent('vorpinputs:advancedInput', InputsService.OnAdvancedInput)

RegisterNUICallback("submit", InputsService.SetSubmit)
RegisterNUICallback("close", InputsService.CloseInput)

RegisterCommand("closeinput", InputsService.CloseInput, false)

-- Init
SetNuiFocus(false, false)
