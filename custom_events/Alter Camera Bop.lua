local _interval = 0
local _intensity = 0
function onEvent(n,v1,v2)
	if n == "Alter Camera Bop" then
		_intensity = tonumber(v1)
		_interval = tonumber(v2)
		isBop = true
		if v1 == '0' or v2 == '0' then
			isBop = false
		end
	end
end

function onBeatHit()
	if curBeat % _interval == 0 and isBop and getProperty('camZooming') then
		triggerEvent("Add Camera Zoom",0.015*_intensity,0.03*_intensity)
	end
end