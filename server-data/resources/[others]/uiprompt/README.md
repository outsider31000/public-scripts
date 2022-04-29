# uiprompt

Object-oriented library for UI prompts in RedM.

## features

- Simplified prompt creation with the `Uiprompt` and `UipromptGroup` classes
- Callbacks for prompt events such as `onControlJustPressed` and `onHoldModeJustCompleted`
- Automatic cleanup of prompts

## installing

1. Create a folder called `uiprompt` in your resources directory.
2. Copy `fxmanifest.lua` and `uiprompt.lua` to this folder.
3. Add `start uiprompt` to `server.cfg`.

## using

In any resources where you want to use this library, add `@uiprompt/uiprompt.lua` as a client script in `fxmanifest.lua`:

```lua
fx_version "cerulean"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
	"@uiprompt/uiprompt.lua",
	"client.lua"
}
```

## example

```lua
local promptGroup = UipromptGroup:new("Test")

local prompt1 = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Test 1", promptGroup)
prompt1:setHoldMode(true)

local prompt2 = Uiprompt:new(`INPUT_RELOAD`, "Test 2", promptGroup)
prompt2:setHoldMode(true)

promptGroup:setOnHoldModeJustCompleted(function(group, prompt)
	TriggerEvent("chat:addMessage", {args={"You held " .. prompt:getText() .. "!"}})
end)

UipromptManager:startEventThread()
```

Further documentation and code examples are provided here: https://kibook.github.io/redm-uiprompt
