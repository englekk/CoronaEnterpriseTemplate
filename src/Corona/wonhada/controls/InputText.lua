----------------------------------------
-- 입력 텍스트 (디바이스에서만 입력 가능)
-- 코로나 SDK 유료 계정 35% 할인 문의: englekk@naver.com
-- @Author 아폴로케이션 원강민 대표
-- @Website http://apollocation.com, http://wonhada.com
-- @Example
--	local InputTextClass = require "InputText"
--	local txt = InputTextClass.create("", 200, 30, native.systemFont, 20, "FF0000", "Input here", "default", 0)
--	txt.bg.defaultBg:setFillColor(1, 1, 1, 1) -- 기본 배경 사각형의 색상 변경, 디자인 적용시 bg에 insert 
----------------------------------------

local createBg, createStaticText, createNativeTextField

local function hexToPercent (hex)
	local r = tonumber(hex:sub(1, 2), 16) / 255
	local g = tonumber(hex:sub(3, 4), 16) / 255
	local b = tonumber(hex:sub(5, 6), 16) / 255
	local a = 255
	if #hex == 8 then a = tonumber(hex:sub(7, 8), 16) / 255 end
	return r, g, b, a
end

-- 내용이 없으면 Placeholder를 보여줌
local function checkPlaceholder(mainGText, staticTxt, placeholderStr, color)
	if mainGText == "" then -- 내용이 없다면
		staticTxt:setFillColor(hexToPercent("a3a3a3"))
		staticTxt.text = placeholderStr
	else staticTxt:setFillColor(color[1], color[2], color[3], color[4]) end
end

--##############################  Main Code Start  ##############################--

local Class = {}

--[[
	inputType :: default, number, decimal, phone, url, email
]]
Class.create = function (text, width, height, font, size15, colorHex000000FF, placeholderStr, inputType, maxLength0)
	text = text or ""
	width = width or 100
	height = height or 20
	font = font or native.systemFont
	size15 = size15 or 15
	local r, g, b, a = 0, 0, 0, 1
	if colorHex000000FF ~= nil then r, g, b, a = hexToPercent(colorHex000000FF) end
	placeholderStr = placeholderStr or ""
	inputType = inputType or "default"
	maxLength0 = maxLength0 or 0
	
	--###############################--
	
	local mainG = display.newGroup()
	mainG.bg = display.newGroup() -- mainG.bg.defaultBg, 커스텀 이미지는 bg에 넣기
	mainG.text = text
	
	createBg(mainG.bg, width, height) -- 크기를 파악하기 위한 defaultBg
	mainG:insert(mainG.bg)
	
	local padding = 5 -- 텍스트필드 기준으로는 좌우측 마진값
	
	-- 화면에 보이는 고정 텍스트
	local staticTxtContainer = display.newContainer(mainG, width - (padding * 2), height)
	staticTxtContainer.anchorX, staticTxtContainer.anchorY = 0.5, 0.5
	staticTxtContainer.x, staticTxtContainer.y = width * 0.5, height * 0.5
	local staticTxt = createStaticText(staticTxtContainer, text, staticTxtContainer.width, staticTxtContainer.height, font, size15, {r, g, b, a}) -- 일반 텍스트필드 생성
	checkPlaceholder(mainG.text, staticTxt, placeholderStr, {r, g, b, a})
	
	--========== Cursor ==========--
	local cursor = display.newRect(staticTxtContainer, 0, 0, 1, staticTxt.height - 4)
	cursor.anchorX, cursor.anchorY = 0.5, 0.5
	cursor:setFillColor(r, g, b, a)
	cursor.isVisible = false
	
	local blinkTimer = nil
	local function on_Blink(e)
		cursor.isVisible = not cursor.isVisible
	end
	
	local function blinkCursor()
		if mainG.text ~= "" then cursor.x = staticTxt.x + staticTxt.width + 1
		else cursor.x = -staticTxtContainer.width * 0.5 + 1 end
		cursor.isVisible = true
		blinkTimer = timer.performWithDelay(400, on_Blink, -1)
	end
	
	local function stopBlinkingCursor()
		timer.cancel(blinkTimer)
		cursor.isVisible = false
	end
	--========== Cursor ==========--
	
	 -- 네이티브 텍스트인풋, 화면에 보이지 않고 이벤트만 전달
	local nativeTxt = createNativeTextField(mainG, text, 1, 1, height, font, 1, {r, g, b, a}, inputType)
	nativeTxt.y = -1000
	nativeTxt.isEditable = false
	
	--##################  이벤트 시작  ##################--
	
	local endEditting = nil
	
	-- 터치하면 글 쓰기 시작
	local function on_InputTextReady(e)
		native.setKeyboardFocus(nativeTxt)
	end
	mainG:addEventListener("tap", on_InputTextReady)
	
	-- 사용자 입력
	local function on_CancelEditing(e) -- 빈 공간 터치하여 취소
		if e.phase == "ended" then
			local localX, localY = mainG:contentToLocal(e.x, e.y)

			-- mainG 외부를 누르면 에디팅 중지
			if localX < 0 or localX > mainG.width or localY < 0 or localY > mainG.height then
				endEditting(true) --취소
			end
		end
	end
	
	endEditting = function (isCanceled)
		Runtime:removeEventListener("touch", on_CancelEditing)
		
		local _text = nativeTxt.text
		
		mainG.text = _text
		staticTxt.text = _text
		checkPlaceholder(_text, staticTxt, placeholderStr, {r, g, b, a})
		
		staticTxt.x = -staticTxtContainer.width * 0.5 -- 편집을 마치면 왼쪽 끝에 맞춤
		
		nativeTxt.isEditable = false
		native.setKeyboardFocus(nil)
		
		stopBlinkingCursor()
		
		if isCanceled == true then mainG:dispatchEvent({name="inputText", phase="canceled"}) end -- Canceled Event
		mainG:dispatchEvent({name="inputText", phase="ended"}) -- Ended Event
	end
	
	local function on_UserInput(e)
		local phase = e.phase
		local _text = nil
		
		if (phase == "began") then
			Runtime:addEventListener("touch", on_CancelEditing)
			
			_text = mainG.text
			
			nativeTxt.text = _text
			nativeTxt.isEditable = true
			nativeTxt:setSelection(#_text, #_text)
			
			staticTxt:setFillColor(r, g, b, a)
			staticTxt.text = _text
			
			blinkCursor()
		elseif (phase == "editing") then -- newCharacters, oldText, startPosition, text
			_text = e.text
			
			-- 최대 길이가 무한이거나 텍스트 길이가 최대 길이 이하라면..
			if maxLength0 <= 0 or #_text <= maxLength0 then
				mainG.text = _text
				staticTxt.text = _text
			else -- 최대 길이보다 크면..
				local staticStr = staticTxt.text
				nativeTxt.text = staticStr
				nativeTxt:setSelection(#staticStr, #staticStr)
			end
		end
		
		-- 마스크보다 커지면 끝자리 보여줌
		local c = staticTxtContainer
		if c.width < staticTxt.width then
			staticTxt.x = (c.width * 0.5) - staticTxt.width - 15
		else staticTxt.x = -c.width * 0.5 end
		
		-- 커서 위치 조정
		if e.text ~= "" then cursor.x = staticTxt.x + staticTxt.width + 1
		else cursor.x = -staticTxtContainer.width * 0.5 + 1 end
		
		-- 이벤트 발생
		if (phase == "began") then
			mainG:dispatchEvent({name="inputText", phase="began"}) -- Began Event
		elseif (phase == "editing") then
			mainG:dispatchEvent({name="inputText", phase="editing"}) -- Editing Event
		elseif (phase == "ended" or phase == "submitted") then -- Ended 이벤트는 endEditting()에서..
			endEditting(false) -- 정상적으로 에디팅 마침
		end
	end
	nativeTxt:addEventListener("userInput", on_UserInput)
	
	--##################  이벤트 끝 ##################--
	
	return mainG
end

--##############################  Main Code End  ##############################--

--==========================--
--
-- Private Methods (UI)
--
--==========================--

-- 크기를 파악하기 위한 defaultBg
createBg = function (parent, width, height)
	parent.defaultBg = display.newRect(parent, 0, 0, width, height)
	parent.defaultBg.anchorX, parent.defaultBg.anchorY = 0, 0
	parent.defaultBg:setFillColor(0, 0, 0, 0)
	return parent.defaultBg
end

-- 표시용 텍스트필드
createStaticText = function (parent, text, width, height, font, size, color)
	local txt = display.newText(parent, " ", 0, 0, font, size)
	txt.anchorX, txt.anchorY = 0, 0
	txt:setFillColor(color[1], color[2], color[3], color[4])
	txt.x, txt.y = -width * 0.5, -txt.height * 0.5
	txt.text = text
	return txt
end

-- 입력용 텍스트필드
createNativeTextField = function (parent, text, width, height, parentHeight, font, size, color, inputType)
	local txt = native.newTextField(0, 0, width, height)
	txt.anchorX, txt.anchorY = 0, 0
	txt.font = native.newFont(font, size)
	txt:setTextColor(color[1], color[2], color[3], color[4])
	txt.text = " "
	txt.hasBackground = false
	txt.inputType = inputType
	txt.text = text
	return txt
end

return Class