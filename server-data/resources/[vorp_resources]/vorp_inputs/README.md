# vorp_inputs-lua
inputs for vorp framework


## instalation
- `ensure vorp_inputs`
- start your server


# how to use

- available in the DOCS
- advanced inputs shown bellow
```lua
local myInput = {
    type = "enableinput", -- dont touch
    inputType = "input", -- or text area for sending messages
    button = "confirm", -- button name
    placeholder = "insertamount", --placeholdername
    style = "block", --- dont touch
    attributes = {
        inputHeader = "amount", -- header
        type = "number", -- inputype text, number,date.etc if number comment out the pattern
        pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
        title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
    }
}
TriggerEvent("vorpinputs:advancedInput", json.encode(myInput),function(result)
    local qty = tonumber(result)

    if qty ~= "" and qty ~= 0 and qty > 0 then

        TriggerServerEvent("eventname",  qty) --result
    else
        TriggerEvent("vorp:TipRight", "insertamount", 3000)
    end


end)
                
```

# Credits
- [Local9](https://github.com/Local9)
- C# [vorp_inputs](https://github.com/VORPCORE/VORP-Inputs)
- converted BY [Emollit](https://github.com/Emolitt)
