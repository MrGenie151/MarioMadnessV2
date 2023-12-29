---@funkinScript
print("lol")

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
    if eventName == "Triggers Universal" then
        debugPrint('dawg, thas a nice trigger')
        debugPrint(value1)
        if songName == "starman-slaughter" then
            if value1 == "2" then
                --doTweenY("sketetween1", "gf", -500, 1.0, "linear")
            end
        end
    end
end