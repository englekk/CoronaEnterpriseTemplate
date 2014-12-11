--[[
-- 이미지 로더
-- 싱글턴으로 할 경우 차례를 기다려야 해서 이미지 로딩이 느려지는 경우가 발생하므로 객체를 생성하도록 함.
-- @Author 원강민
-- @Example
	--=============== Image Loader Begin ===============--
	local ImageLoader = require "ImageLoader"
	local loader = ImageLoader.create(5, nil) -- maxMultiDownloadCount, enterpriseName
	local function on_ImageLoadComplete(img, destFileName, baseDirectory)
		-- 너무 빨리 움직이면 row가 사라지거나 insert 메소드가 nil이 됨
		if row ~= nil and row.insert ~= nil then
			row:insert(createRow(img, destFileName, system.TemporaryDirectory, params))
			bg:removeSelf()
		else img:removeSelf() end
	end
	loader.load(params.img, math.random()..".png", on_ImageLoadComplete)
	--=============== Image Loader End ===============--
]]

local Class = {}

Class.create = function (maxMultiDownloadCount, enterpriseName)
	maxMultiDownloadCount = maxMultiDownloadCount or 2
	if enterpriseName == "" then enterpriseName = nil end
	
	--############### 로더 생성 Begin ###############--
	local loader = {}
	
	-- 로더 생성, 로더 제거 및 새로운 로더 생성 (최대 갯수까지 루프 돌기 위함)
	local createLoader, removeAndCreateLoader = nil -- 실제 객체는 아님
	
	-- 한번 로드한 이미지는 다시 로드하지 않도록 하기 위함
	local imgExistsList = {} -- true or nil
	local imgStack = {} -- FIFO 방식의 이미지 스택
	
	local coroutineLoad = function (url, destFileName, callBack)
		local on_ImageLoadComplete = function (e)
			if not e.isError then
				imgExistsList[destFileName] = true -- 한번만 로드하도록 함

				local img = e.target
				callBack(img, destFileName, system.TemporaryDirectory)
				removeAndCreateLoader() -- 새로운 로더 생성
			end

			on_ImageLoadComplete = nil

			return nil
		end
		display.loadRemoteImage(url, "GET", on_ImageLoadComplete, destFileName, system.TemporaryDirectory)

		coroutineLoad = nil
	end
	
	-- 로컬은 모두 걸러지고 실제 외부 이미지만 로딩
	local function _realLoad(data)
		local url, destFileName, callBack = data.url, data.fileName, data.callBack

		if enterpriseName ~= nil then -- 엔터프라이즈라면 멀티쓰레드로 로딩
			local downloadFolder = system.pathForFile(nil, system.TemporaryDirectory)
			local function on_DownloadComplete(_downloadFolder, _fileName)
				local img = display.newImage(_downloadFolder.._fileName)
				callBack(img, destFileName, system.TemporaryDirectory)
				removeAndCreateLoader() -- 새로운 로더 생성
			end
			enterpriseName.downloadFile(url, downloadFolder, destFileName, on_DownloadComplete)
		else -- 엔터프라이즈가 아니라면 코로나로 로딩
			local co = coroutine.create(coroutineLoad)
			coroutine.resume(co, url, destFileName, callBack)
		end
	end

	local loaderCount = 0
	
	-- 로더 생성, 실제 눈에 보이는 객체는 아님
	createLoader = function ()
	-- print("------------",loaderCount, maxMultiDownloadCount, (loaderCount >= maxMultiDownloadCount))
		if #imgStack <= 0 or loaderCount >= maxMultiDownloadCount then return end
		
		loaderCount = loaderCount + 1
		
		-- 약간의 시간차를 둬서 퍼포먼스에 영향이 없도록 함
		local t = nil
		local on_StartLoading = function (e)
			local data = table.remove(imgStack, 1)
			_realLoad(data)
			
			on_StartLoading = nil
			t = nil
		end
		t = timer.performWithDelay((loaderCount <= 1 and 1 or 300), on_StartLoading, 1)
	end

	-- 새로운 로더 생성
	removeAndCreateLoader = function ()
		loaderCount = loaderCount - 1
		createLoader()
	end
	
	-- 모든 이미지는 여기를 통과하도록 하면 됩니다.
	loader.load = function (url, destFileName, callBack, isLoadFirst)
		local img = nil
		if string.find(url, "://") == nil then -- 로컬 이미지
			img = display.newImage(url)
			callBack(img, url, system.ResourceDirectory)
		else -- 원격 이미지 (처음엔 로드, 다음부터는 로컬 이미지로)
			if imgExistsList[destFileName] ~= true then -- 로딩
				local value = {url=url, fileName=destFileName, callBack=callBack}
				if isLoadFirst == true then -- 먼저 로드해야 한다면
					table.insert(imgStack, 1, value)
				else
					imgStack[#imgStack + 1] = value
				end
				
				createLoader()
			else -- 로컬 이미지
				img = display.newImage(destFileName, system.TemporaryDirectory)
				callBack(img, destFileName, system.TemporaryDirectory)
			end
		end
	end
	
	return loader
	--############### 로더 생성 End ###############--
end

return Class