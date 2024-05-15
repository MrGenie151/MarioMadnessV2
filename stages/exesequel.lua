---@funkinScript
---@module "header"

function makeSprite(tag,image,posx,posy,scrollx,scrolly,front)
    scrollx = scrollx or 1
    scrolly = scrolly or 1
    front = front or false

    makeLuaSprite(tag,image,posx,posy)
    setScrollFactor(tag,scrollx,scrolly)
    addLuaSprite(tag,front)
end

function onCreate()
    --[[makeLuaSprite("bg3", "mario/EXE1/starman/SS_sky", -750, -600)
    setScrollFactor("bg3", 0.1, 0.1)
    addLuaSprite("bg3", false)]]
    makeSprite("bg3","mario/EXE1/starman/SS_sky", -750, -600,0.1,0.1)
    makeLuaSprite("bg4", "mario/EXE1/starman/SS_castle", -1100, -600)
    setScrollFactor("bg4", 0.5, 0.5)
    addLuaSprite("bg4", false)

    --makeAnimatedLuaSprite("bgfire1","mario/EXE1/starman/Starman_BG_Fire_Assets",-500,-500)
    --addLuaSprite("bgfire1",false)
    --setObjectOrder("bgfire1",1)
    --setScrollFactor("bgfire1",0.6,0.6)
    --addAnimationByPrefix("bgfire1","haha-firefunny","fire anim effects",24,true)

    makeLuaSprite("bg5", "mario/EXE1/starman/SS_farplatforms", -1100, -600)
    setScrollFactor("bg5", 0.7, 0.7)
    addLuaSprite("bg5", false)
    setObjectOrder("bg5", 2)
    makeLuaSprite("bg6", "mario/EXE1/starman/SS_midplatforms", -1200, -600)
    setScrollFactor("bg6", 0.9, 0.9)
    addLuaSprite("bg6", false)
    setObjectOrder("bg6", 3)
    makeLuaSprite("bg1", "mario/EXE1/starman/SS_floor", -750, -600)
    addLuaSprite("bg1", false)
    setObjectOrder("bg1", 4)
    --addBehindDad("bg1")
    makeAnimatedLuaSprite("ssgf", "characters/SS_GF_scared_Assets", 1800, 400)
    addLuaSprite("ssgf", false)
    addAnimationByPrefix("ssgf", "bop", "GF Dancing Beat", bpm/4, true)

    makeAnimatedLuaSprite("peachFRICKINGdies", "characters/Peach_EXE_Cuts_New", -450, -200)
    addLuaSprite("peachFRICKINGdies")
    addAnimationByPrefix("peachFRICKINGdies", "dies", "PeachDIES", 24, false)
    setScale("peachFRICKINGdies",0.9,0.9)
    setProperty("peachFRICKINGdies.visible", false)

    makeLuaSprite("bg2", "mario/EXE1/starman/SS_foreground", -1200, -600)
    setScrollFactor("bg2", 1.1, 1.1)
    addLuaSprite("bg2", true)
    setObjectOrder("bg2", 999)
    --debugPrint('stage')
    precacheImage("characters/Peach_EXE_Cuts_New")
end

function onCreatePost()
    triggerEvent("Change Character", "gf", "yoshi-exe")
    triggerEvent("Change Character", "gf", "sskoopa")
end

function onBeatHit()
    playAnim("ssgf", "bop", false)
end

function setPos(tag,x,y)
    setProperty(tag..".x", x)
    setProperty(tag..".y", y)
end

function setScale(tag,x,y)
    setProperty(tag..".scale.x", x)
    setProperty(tag..".scale.y", y)
end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, value1, value2, strumTime)
    if eventName == "Triggers Universal" then
        debugPrint('dawg',value1)
        if value1 == "2" then
            debugPrint('the skelebone')
            setObjectOrder('gfGroup', 3);
            doTweenY("sketetween1", "gf", -200, 2.0, "expoOut")
        end
        if value1 == "5" then
            playAnim("dad","xd",true)
            doTweenY("xdfallin","dad",10000,1,"expoin")
            triggerEvent("Change Character", "gf", "yoshi-exe")
            setScrollFactor("gf", 0.7, 0.7)
            setObjectOrder('gfGroup', 3);
            setPos("gf",600,250)
        elseif value1 == "10" then
            setProperty("dad.visible", false)
            setProperty("peachFRICKINGdies.visible",true)
            --setPos("peachFRICKINGdies",getProperty("dad.x"),getProperty("dad.y"))
            playAnim("peachFRICKINGdies", "dies", true)
        end
        if value1 == "17" then
            cameraFlash("camGame", "ffffff", 0.5, true)
            setProperty("camHUD.alpha", 0)
            for i=1,6 do
                setProperty("bg"..tostring(i)..".visible", false)
            end
        end
    end
end

local animIndex = {
    "singLEFT";
    "singDOWN";
    "singUP";
    "singRIGHT";
}

---
--- @param membersIndex int
--- @param noteData int
--- @param noteType string
--- @param isSustainNote bool
---
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if noteType == "Yoshi Note" then
        playAnim("gf", animIndex[noteData+1], true)
    end
    if noteType == "GF Duet" then
        playAnim("gf", animIndex[noteData+1], true)
    end
end

---
--- @param elapsed float
---
function onUpdate(elapsed)
    if getProperty("gf.animation.curAnim.name") == "death" and getProperty("gf.animation.curAnim.finished") == true then
        setProperty("gf.visible", false)
    end
    if getProperty("peachFRICKINGdies.animation.curAnim.name") == "dies" and getProperty("peachFRICKINGdies.animation.curAnim.finished") == true then
        setProperty("peachFRICKINGdies.visible", false)
    end
    --setProperty("gf.animation.curAnim.framerate", 12)
    --debugPrint(getObjectOrder("bf"))
end
