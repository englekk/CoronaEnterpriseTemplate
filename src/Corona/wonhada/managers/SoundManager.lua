----------------------------------------
-- 코로나 SDK 유료 계정 35% 할인 문의: englekk@naver.com
-- @Author 아폴로케이션 원강민 대표
-- @Website http://apollocation.com, http://wonhada.com
----------------------------------------

local Class = {}

Class.create = function (channel)
    local manager = {} -- Sound Manager
    manager.channel = channel
    manager.soundList = {}
    manager.isPaused = false
    
    -- 사운드 파일 추가
    function manager:add(filePathOrHandle, name)
        if type(filePathOrHandle) == "string" then
            self.soundList[name] = {name=name, type="path", value=filePathOrHandle, channel=nil}
        else
            self.soundList[name] = {name=name, type="handle", value=filePathOrHandle, channel=nil}
        end
    end
    
    -- 사운드 플레이
    function manager:play(name, options, useDelay, delayCallBack, isForce)
        local canPlay = (isForce == true) or (self.isPaused == false)
        
        if canPlay == true then
            local sound = self.soundList[name]
            if sound.channel ~= nil then self:stop(sound.name) end

            options = options or {}
            options.channel = audio.findFreeChannel()
            if options.onComplete ~= nil then options.onComplete2 = options.onComplete end
            options.onComplete = function (e)
                if sound.channel ~= nil and audio.isChannelPlaying(sound.channel) == false then
                    sound.channel = nil
                end
                if options.onComplete2 ~= nil then options.onComplete2(e) end
            end

            local handle = nil
            if sound.type == "path" then -- 경로 문자열은 새로 생성. 생성된 후에는 다시 생성 안함.
                handle = audio.loadStream(sound.value)
                sound.type = "handle"
                sound.value = handle
            else -- 핸들은 처음으로 돌려서 다시 재생
                audio.rewind(sound.value)
                handle = sound.value
            end

            if useDelay == true then --딜레이를 주는 이유는 페이드아웃 타임과 겹치면 플레이가 안되기 때문.
                local t = nil
                local function on_Timer(e)
                    timer.cancel(t)
                    t = nil

                    sound.channel = audio.play(handle, options)
                    if delayCallBack ~= nil then delayCallBack(sound) end
                end
                t = timer.performWithDelay(1, on_Timer, 1)
            else -- 딜레이를 주지 않는다면
                sound.channel = audio.play(handle, options)
                return sound
            end
        end
    end
    
    -- 사운드 일시정지
    function manager:pause()
        if self.isPaused == false then
            self.isPaused = true
            audio.pause(0)
        end
    end
    
    -- 사운드 재개
    function manager:resume()
        if self.isPaused == true then
            self.isPaused = false
            audio.resume(0)
        end
    end
    
    -- 사운드 정지
    function manager:stop(name)
        local sound = self.soundList[name]
        if sound.channel ~= nil then
            audio.stop(sound.channel)
            sound.channel = nil
        end
    end
    
    -- 모든 사운드 정지
    function manager:stopAll()
        for k, v in pairs(self.soundList) do
            self:stop(v.name)
        end
    end
    
    -- 채널 볼륨 페이드 아웃
    function manager:fadeOut(name, _time, endVolume, callBack)
        local sound = self.soundList[name]
        if sound.channel == nil then return end
        
        local n = audio.fadeOut({channel=sound.channel, time=_time})
        
        local t = nil
        local function on_Timer(e)
            timer.cancel(t)
            t = nil

            audio.setVolume(endVolume, {channel=sound.channel})
            self:stop(sound.name)
            if callBack ~= nil then callBack(sound, n) end
        end
        t = timer.performWithDelay(_time, on_Timer, 1)
    end
    
    -- 모든 채널 볼륨 페이드 아웃
    function manager:fadeOutAll(_time, endVolume, callBack)
        for k, v in pairs(self.soundList) do
            self:fadeOut(v.name, _time, endVolume, callBack)
        end
    end
    
    -- 사운드 객체 제거
    function manager:dispose(name)
        self:stop(name)
        
        local sound = self.soundList[name]
        audio.dispose(sound.value)
        
        self.soundList[name] = nil
    end
    
    return manager
end

return Class