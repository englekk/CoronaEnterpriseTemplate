local Class = {}

--- 포인트의 각도 구하기
-- @param pt
-- @return
Class.angleOfPoint = function ( pt )
	local x, y = pt.x, pt.y
	local radian = math.atan2(y,x)
	local angle = radian*180/math.pi
	if angle < 0 then angle = 360 + angle end
	return angle
end

--- 두 점간의 각도 구하기
-- @param centerX
-- @param centerY
-- @param targetX
-- @param targetY
-- @return

Class.angleBetweenPoints = function (centerX, centerY, targetX, targetY)
	local x, y = targetX - centerX, targetY - centerY
	return Class.angleOfPoint( { x=x, y=y } ) -- angle
end

-- 두 점간의 거리 구하기
-- @param centerX
-- @param centerY
-- @param targetX
-- @param targetY
-- @return
Class.getDistance = function (centerX, centerY, targetX, targetY)
	local x, y = targetX - centerX, targetY - centerY
	return math.sqrt((x * x) + (y * y))
end

--- 길이값에 맞는 퍼센트 반환
-- @param whole 전체 값
-- @param value 현재 값
-- @return
Class.getPercent = function (whole, value)
	return (100 * value ) / whole
end

--- 퍼센트에 따른 현재 값 반환
-- @param whole
-- @param percent
-- @return
Class.getValueByPercent = function (whole, percent)
	return (whole * percent) * 0.01
end

return Class