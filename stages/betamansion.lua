---@funkinScript
---@module "header"

local sinner = 0
local mansionFocus = false
local cam = nil
if stringStartsWith(version, '0.7') then
	cam = 'camGame.scroll'
else
	cam = 'camFollowPos'
end

local hiddenTable = {
    "healthBar";
    "MYHEALTHBAR";
    --"gf";
    "boyfriend";
    "ghostgf";
    "iconP1";
    "iconP2";
    "timeBar";
    "timeTxt";
    "scoreTxt";
}

function makeSprite(tag,image,posx,posy,scrollx,scrolly,front)
    scrollx = scrollx or 1
    scrolly = scrolly or 1
    front = front or false

    makeLuaSprite(tag,image,posx,posy)
    setScrollFactor(tag,scrollx,scrolly)
    addLuaSprite(tag,front)
end

function setPos(tag,x,y)
    setProperty(tag..".x", x)
    setProperty(tag..".y", y)
end

function setScale(tag,x,y)
    setProperty(tag..".scale.x", x)
    setProperty(tag..".scale.y", y)
end

function onCreatePost()
    setVar("camenabled", true)
    makeSprite("bg1","mario/LuigiBeta/BackBG",-1000,-900,0.7,0.7)
    makeSprite("bg2","mario/LuigiBeta/FrontBG",-1000,-900)
    makeLuaSprite("startBlocker","characters/BOYFRIEND",0,0)
    makeGraphic("startBlocker",1920,1080,"000000")
    setObjectCamera("startBlocker","camOther")
    addLuaSprite("startBlocker",true)
    setProperty("camGame.zoom",1.3)
    setProperty("gf.alpha",0)
    --setProperty("boyfriend.alpha",0)
    makeAnimatedLuaSprite("ghostgf","characters/Beta_Luigi_GF_Assets",500,100)
    addAnimationByPrefix("ghostgf","bop","GFIdle",24,true)
    addLuaSprite("ghostgf")
    --setProperty("ghostgf.alpha",0)
    --setProperty("healthBar.alpha",0)
    --setProperty("MYHEALTHBAR.alpha",0)
    for i=0,3 do
        setPropertyFromGroup("playerStrums",i,"alpha",0)
    end
    for idx, thingy in pairs(hiddenTable) do
        setProperty(thingy..".alpha",0)
    end
    ghostgfdfx = getProperty("ghostgf.x")
    ghostgfdfy = getProperty("ghostgf.y")
    hooraybfy = getProperty("boyfriend.y")
end

function onSongStart()
    doTweenAlpha("blockerOut","startBlocker",0,5,"linear")
    doTweenZoom("zoomOut","camGame",0.8,5,"quadout")
end

---
--- @param elapsed float
---
function onUpdate(elapsed)
    setPos("ghostgf",ghostgfdfx + math.sin(sinner*0.02)*100,ghostgfdfy + math.cos(sinner*0.02)*20)
    setProperty("boyfriend.y", hooraybfy + math.sin((sinner + 5) * 0.01)*5)
    sinner = sinner + 1

    if mansionFocus then
        setPos(cam,0,-500)
    end
end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
    if eventName == "Triggers Universal" then
        --debugPrint('dawg',value1)
        if value1 == "6" then
            --doTweenAlpha("bftween1","boyfriend",1,1,"linear")
            --doTweenAlpha("gftween1","ghostgf",1,1,"linear")
            --doTweenAlpha("hptween1","MYHEALTHBAR",1,1,"linear")
            --doTweenAlpha("hptween2","healthBar",1,1,"linear")
            for idx, thingy in pairs(hiddenTable) do
                --setProperty(thingy..".alpha",0)
                doTweenAlpha(thingy.."tween",thingy,1,1,"linear")
            end
            --[[for i=4,7 do
                --setPropertyFromGroup("playerStrums",i,"alpha",0)
                noteTweenAlpha("noteAlphaTween"..tostring(i),i,1,'linear')
            end]]
            for idx2=0,1,0.01 do
                for i=0,3 do
                    setPropertyFromGroup("playerStrums",i,"alpha",idx2)
                end
            end
        end
    end
    if eventName == "Triggers Alone" then
        --mansionFocus = true
        runTimer("focusTimer",1.5)
        setVar("camenabled",false)
        --setPos(cam,0,-500)
        triggerEvent("Camera Follow Pos",500,-500)
    end
end

---
--- @param tag string
--- @param loops integer
--- @param loopsLeft integer
---
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "focusTimer" then
        setVar("camenabled",true)
        mansionFocus = false
        triggerEvent("Camera Follow Pos")
    end
end
