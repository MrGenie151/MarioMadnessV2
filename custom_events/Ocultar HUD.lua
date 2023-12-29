---@funkinScript
---@module "header.lua"

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
    if eventName == "Ocultar HUD" then
        doTweenAlpha("ocultar-haha","camHUD",value1,1,"linear")
    end
end
