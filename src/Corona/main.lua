----------------------------------------
-- 코로나 SDK 유료 계정 35% 할인 문의: englekk@naver.com
-- @Author 아폴로케이션 원강민 대표
-- @Website http://apollocation.com, http://wonhada.com
----------------------------------------

---------------------------------
-- 기본 세팅
-- __statusBarHeight__ : 상단 StatusBar의 높이
-- __appContentWidth__ : App의 너비
-- __appContentHeight__ : App의 높이
-- 앵커포인트는 좌상단 
require("CommonSettings")
---------------------------------
-- 여기서부터 코딩하세요. 

-- 완전한 풀스크린을 위한 코드
-- native.setProperty( "androidSystemUiVisibility", "immersive" )

local function on_SystemEvent(e)
	local _type = e.type
	if _type == "applicationStart" then -- 앱이 시작될 때
		-- 시작점
		local composer = require "composer"
		composer.gotoScene("MainSceneStarter")
--	elseif _type == "applicationExit" then -- 앱이 완전히 종료될 때
--	elseif _type == "applicationSuspend" then -- 전화를 받거나 홈 버튼 등을 눌러서 앱을 빠져나갈 때
--	elseif _type == "applicationResume" then -- Suspend 후 다시 돌아왔을 때
	end
end
Runtime:addEventListener("system", on_SystemEvent)