---@module 'header'
---@module 'headerUMM'
-- passing a table like {255, 100, 20}

--[[function rgbToHex(r,g,b)
    -- EXPLANATION:
    -- The integer form of RGB is 0xRRGGBB
    -- Hex for red is 0xRR0000
    -- Multiply red value by 0x10000(65536) to get 0xRR0000
    -- Hex for green is 0x00GG00
    -- Multiply green value by 0x100(256) to get 0x00GG00
    -- Blue value does not need multiplication.

    -- Final step is to add them together
    -- (r * 0x10000) + (g * 0x100) + b =
    -- 0xRR0000 +
    -- 0x00GG00 +
    -- 0x0000BB =
    -- 0xRRGGBB
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return string.format("%x", rgb)
end]]

local hotterTable = {}
local los = ''

function onUpdatePost() -- HP bar doesn't exist on "onCreate"

   hotterTable = getProperty('dad.healthColorArray')

   los = rgb_to_hex(hotterTable)

   --debugPrint(los)

   setProperty("timeBar.leftBar.color",getColorFromHex(los))

end


function rgb_to_hex(rgb)

    return string.format('%x', (rgb[1] * 0x10000) + (rgb[2] * 0x100) + rgb[3])

end
