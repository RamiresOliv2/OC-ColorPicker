-- simple converter
local function hexToRGB(hex)
    local r = (hex >> 16) & 0xFF
    local g = (hex >> 8) & 0xFF
    local b = hex & 0xFF
    return r, g, b
end
-- rgb to hex again
local function rgbToHex(r, g, b)
    return string.format("0x%02X%02X%02X", r, g, b)
end

-- palette maker
-- ref: https://ocdoc.cil.li/_media/api:oc-256-color.png?w=768&tok=c72b34
local levelsB = {0x00, 0x40, 0x80, 0xC0, 0xFF}
local levelsG = {0x00, 0x24, 0x49, 0x6D, 0x92,0xB6, 0xDB, 0xFF}
local levelsR = {0x00, 0x33, 0x66, 0x99, 0xCC, 0xFF}
local palette = {}
for ig = 1, 8 do
  for ir = 1, 6 do
    for ib = 1, 5 do
      table.insert(palette, {r=levelsR[ir], g=levelsG[ig], b=levelsB[ib]})
    end
  end
end
local gray = {0x0F, 0x1E,0x2D,0x3C,0x4B,0x5A,0x69,0x78,0x87,0x96,0xA5,0xB4,0xC3,0xD2,0xE1,0xF0}
for i, v in ipairs(gray) do
    table.insert(palette, {r=v, g=v, b=v})
end

-- Finds closest
function closestPaletteColor(hex)
    local r, g, b = hexToRGB(hex)
    local minDist, best = math.huge
    for i, color in ipairs(palette) do
        local dr = color.r - r
        local dg = color.g - g
        local db = color.b - b
        local dist = dr*dr + dg*dg + db*db
        if dist < minDist then
            minDist = dist
            best = color
        end
    end
    return rgbToHex(best.r, best.g, best.b)
end

-- calling
local hex = closestPaletteColor(0x4754c9)
print(hex)
print(#palette)
