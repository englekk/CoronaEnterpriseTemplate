----------------------------------------
-- 코로나 SDK 유료 계정 35% 할인 문의: englekk@naver.com
-- @Author 아폴로케이션 원강민 대표
-- @Website http://apollocation.com, http://wonhada.com
----------------------------------------

--[[
	개발 편의를 위한 Global 변수들
	__statusBarHeight__ -- StatusBar 높이
	__appContentWidth__ -- application.content.width
	__appContentHeight__ -- application.content.height
	__isSimulator__ -- 시뮬레이터에서 실행중인지 여부
]]

-- 상태바 타입을 입력하세요.
local statusBarType = "hidden" -- 소문자로.. hidden, default, translucent, dark

--====================================--
-- 주의!! 아래 코드부터 수정하지 마세요.
if statusBarType == "hidden" then
	display.setStatusBar( display.HiddenStatusBar )

    __statusBarHeight__ = 0 -- StatusBar의 높이
else
	if statusBarType == "default" then display.setStatusBar( display.DefaultStatusBar )
	elseif statusBarType == "translucent" then display.setStatusBar( display.TranslucentStatusBar )
	elseif statusBarType == "dark" then display.setStatusBar( display.DarkStatusBar ) end
	
	__statusBarHeight__ = display.topStatusBarContentHeight -- StatusBar의 높이
end
-- App의 너비, 높이
__appContentWidth__ = display.actualContentWidth
__appContentHeight__ = display.actualContentHeight
__isSimulator__ = system.getInfo("environment") == "simulator"
--====================================--

-- Global 변수값 확인
-- print(__statusBarHeight__, __appContentWidth__, __appContentHeight__, __isSimulator__)

-- 앵커포인트 좌상단으로 세팅
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )