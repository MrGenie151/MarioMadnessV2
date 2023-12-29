---@funkinScript
local ratingNameTable = {
	"F";
	"C-";
	"C";
	"C+";
	"B-";
	"B";
	"B+";
	"A-";
	"A";
	"S";
	"S+";
}

local ratingTable = {}
GlobalRating = 0

local ratingValue = {
    ["shit"] = 0.25;
    ["bad"] = 0.5;
    ["good"] = 0.75;
    ["sick"] = 1;
}

local function average()
    local funky = 0
    if #ratingTable >= 1 then
        for i,v in pairs(ratingTable) do
            funky = funky + v
        end
        
        return funky / #ratingTable
    else
        return 1.0000
    end
end

---
--- @param membersIndex int
--- @param noteData int
--- @param noteType string
--- @param isSustainNote bool
---
function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    table.insert(ratingTable,0)
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	local rating = getPropertyFromGroup('notes', membersIndex, 'rating')
	--if rating == 'shit' or rating == 'bad' then
	table.insert(ratingTable,ratingValue[rating])
	--end
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function shortenNumber(num)
    num = num * 100
    local numstring = tostring(num)
    return string.sub(numstring,1,2).."."..string.sub(numstring,3,4)
end

function onCreate()
    --setProperty('skipCountdown', true)
end

function onStartCountdown()
	-- countdown started, duh
	-- return Function_Stop if you want to stop the countdown from happening (Can be used to trigger dialogues and stuff! You can trigger the countdown with startCountdown())
	return Function_Continue;
end

function onCreatePost()
    --setProperty('camZooming', false)
    --runHaxeCode("PlayState.camZooming = false")
	--setTextFont("scoreTxt","Pixel.ttf")
	setTextBorder("scoreTxt",2,"000000")
    setTextColor("scoreTxt", "f42626")
    setTextSize("scoreTxt", 15)
    setTextSize("timeTxt", 20)
	setProperty("ratingFC","???")

    setProperty("healthBar.bg.visible",false)
    makeLuaSprite("MYHEALTHBAR", "healthBarNEW", getProperty("healthBar.x") - 45, getProperty("healthBar.y")- 5)
    setObjectCamera("MYHEALTHBAR", 'hud')
    addLuaSprite("MYHEALTHBAR", true)
    setObjectOrder("MYHEALTHBAR", 50)
    setObjectOrder("iconP1", 51)
    setObjectOrder("iconP2", 52)

    setTextString("botplayTxt", "LUIGI")
    setTextColor("botplayTxt", "03af03")

    --doTweenZoom("haha", "camGame", 999, 0.0, "linear")

    --< DEBUG TIME >--
    --setPropertyFromClass("PlayState", "chartingMode", true

end

function onUpdatePost(elapsed)
    local rateCalc = average()
    --debugPrint(rateCalc)
    setRatingPercent(rateCalc)
    --setProperty("ratingPercent",1)
    GlobalRating = rateCalc

	local ratingNameThing = ratingNameTable[math.floor(rating*10)+1]
	local scoreTemplate = "Score: %s      Misses: %s      Rating: %s (%s%s)"
	--GlobalRating = getGlobalFromScript("scripts/newRatingSystem","GlobalRating")
	local scorecalc = string.format(scoreTemplate,score,misses,ratingNameThing,"%",round(rating*100,2))
	setTextString("scoreTxt",scorecalc)
    --setProperty('camZooming', false)
end
