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

--=====================--
-- tmp 폴더의 모든 파일 삭제
local lfs = require "lfs"
local tmpFolder = system.pathForFile("", system.TemporaryDirectory)
local iter, dir_obj = lfs.dir (tmpFolder)
local file = dir_obj:next()
while file do
	if tostring(file) ~= "." and tostring(file) ~= ".." then
		os.remove(tmpFolder..file)
	end
	file = dir_obj:next()
end
--=====================--

math.randomseed(os.time())
---------------------------------
-- 여기서부터 코딩하세요. 
--

-- 완전한 풀스크린을 위한 코드
-- native.setProperty( "androidSystemUiVisibility", "immersive" )

-- 전역 변수
__scaleFactor__ = 0.5 -- 모든 크기의 기준이 되는 비율 기준값

local ImageLoader = require "wonhada.managers.ImageLoader"
local TPSheetManager = require "wonhada.managers.TPSheetManager"
local composer = require "composer"

-- 이미지 동시 로딩 갯수
ImageLoader.maxMultiDownloadCount = 5

-- 모든 이미지 시트 초기화
--TPSheetManager.init("images", "asset", 0, 1)

-- 시작점
composer.gotoScene("MainSceneStarter")