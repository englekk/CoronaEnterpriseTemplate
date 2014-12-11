----------------------------------------
-- 코로나 SDK 유료 계정 35% 할인 문의: englekk@naver.com
-- @Author 아폴로케이션 원강민 대표
-- @Website http://apollocation.com, http://wonhada.com
----------------------------------------

--[[
    사용법 >>
    local TPSheetManager = require "managers.TPSheetManager"
    TPSheetManager.init("images", "asset", 0, 2)
    local img = TPSheetManager.createImage(nil, "sampleImage", 0.5)
    local s = TPSheetManager.createSprite(nil, "sampleSprite0", 2, 1000, 0, "forward", 0.5) -- sampleSprite0부터 2개를 1초동안 무한 반복
    s:play()
]]

local Class = {}

Class.init = function (imgFolderName, fileNamePrefix, beginIdx, endIdx)
    for i=beginIdx,endIdx do
        local AssetClass = require (imgFolderName.."."..fileNamePrefix..i)
        local sheet = graphics.newImageSheet(imgFolderName.."/"..fileNamePrefix..i..".png", AssetClass.sheet)
        for k,v in pairs(AssetClass.frameIndex) do
            Class[k] = {sheet=sheet, frame=v, framesOfSheet=#AssetClass.sheet.frames}
        end
    end 
end

-- 한 장의 이미지 생성
Class.createImage = function (_parent, name, scaleFactor)
    if scaleFactor == nil then scaleFactor = 0.5 end
    
    local img = display.newImage(Class[name].sheet, Class[name].frame)
    if _parent ~= nil then _parent:insert(img) end
    if scaleFactor ~= 1 then
        img.width, img.height = img.width * scaleFactor, img.height * scaleFactor
    end
    return img
end

-- nameForStart의 프레임부터 count까지의 스프라이트 생성
Class.createSprite = function (_parent, nameForStart, count, time, loopCount, loopDirection, scaleFactor)
    if scaleFactor == nil then scaleFactor = 0.5 end
    
    if loopCount == nil then loopCount = 0 end
    if loopDirection == nil then loopDirection = "forward" end
    
    local _C = Class[nameForStart]
    
    local sequenceData = {name=nameForStart, count=count, time=time, loopCount=loopCount, loopDirection=loopDirection}
    sequenceData.sheet = _C.sheet
    sequenceData.start = _C.frame
    
    local _s = display.newSprite(_C.sheet, sequenceData)
    if _parent ~= nil then _parent:insert(_s) end
    if scaleFactor ~= 1 then
        _s:scale(scaleFactor, scaleFactor)
    end
    return _s
end

return Class