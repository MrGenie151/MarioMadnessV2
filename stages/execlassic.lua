---@funkinScript

function onCreate()
    makeLuaSprite("bg3", "mario/EXE1/Castillo fondo de hasta atras", -1000, -900)
    setScrollFactor("bg3", 0.3, 0.3)
    addLuaSprite("bg3", false)
    makeLuaSprite("bg4", "mario/EXE1/CLadrillosPapus", -1000, -900)
    setScrollFactor("bg4", 0.5, 0.5)
    addLuaSprite("bg4", false)
    makeLuaSprite("bg1", "mario/EXE1/floor", -1000, -900)
    addLuaSprite("bg1", false)
    makeLuaSprite("bg2", "mario/EXE1/Arboles y sombra", -1000, -900)
    addLuaSprite("bg2", false)
end
