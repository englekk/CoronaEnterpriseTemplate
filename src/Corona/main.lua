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

-- 시작점
local composer = require "composer"
composer.gotoScene("MainSceneStarter")