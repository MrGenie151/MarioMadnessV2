---@funkinScript

stuff1 = {}
stuff2 = nil

nummynum = 1
length = string.len("cameraChain")

function mysplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function onCreatePost()
    local test = mysplit("deah,life",",")
    debugPrint(test)
end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
    if eventName == "Camera Zoom Chain" then
        
        stuff1a = mysplit(value1, ",")
        stuff2 = mysplit(value2, ",")
        debugPrint("Stuff 1:")
        debugPrint(stuff1a)
        debugPrint("Stuff 2:")
        debugPrint(stuff2)
        table.insert(stuff1,nummynum,stuff1a)
        runTimer("cameraChain"..tostring(nummynum), stuff2[2], stuff2[1])
        --nummynum = nummynum + 1
    end
end

---
--- @param tag string
--- @param loops integer
--- @param loopsLeft integer
---
function onTimerCompleted(tag, loops, loopsLeft)
    if string.sub(tag,1,length) == "cameraChain" then
        local numberIs = string.sub(tag,length+1)
        debugPrint(numberIs)
        numberIs = tonumber(numberIs)
        triggerEvent("Add Camera Zoom", stuff1[numberIs][1], stuff1[numberIs][2])
        debugPrint('yeehaw')
    end
end
