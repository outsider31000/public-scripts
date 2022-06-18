NUIEvent = {}

local defaultNuiEvent = {
    type= "enableinput",
    style= nil,
    button= nil,
    placeholder= nil,
    inputType= nil
}


function NUIEvent:New(t)
    local data = Shallowcopy(defaultNuiEvent)
    if t ~= nil then
        for key, value in pairs(t) do
            data[key] = value
        end
    end

	setmetatable(data, self)
	self.__index = self
	return data
end

function Shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end