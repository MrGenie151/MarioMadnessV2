---@funkinScript
xx = 500
yy = 220

xx2 = 1000
yy2 = 120

---
--- @param character string
---
function onMoveCamera(character)
    if character == "boyfriend" then
        debugPrint('lol')
        triggerEvent("Camera Follow Pos", xx2, yy2)
    else
        triggerEvent("Camera Follow Pos", xx, yy)
    end
end