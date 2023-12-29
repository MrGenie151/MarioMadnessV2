---@funkinScript
---@module "header"

---
--- @param elapsed float
---
function onUpdate(elapsed)
    if mustHitSection then
        setProperty("boyfriend.visible",true)
        setProperty("gf.visible",true)
        setProperty("dad.visible",false)
    else
        setProperty("boyfriend.visible",false)
        setProperty("gf.visible",false)
        setProperty("dad.visible",true)
    end
end