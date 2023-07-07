local _interval = 0
local _intensity = 0
function onEvent(n,v1,v2)
	if n == "Character Bopa" then
		_intensity = tonumber(v1)
		_interval = tonumber(v2)
		isBop = true
		if v1 == '0' or v2 == '0' then
			isBop = false
		end
	end
end

function onBeatHit()
	if curBeat % _interval == 0 and isBop then
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			playAnim('boyfriend','idle',true)
		end
		if getProperty('dad.animation.curAnim.name') == 'idle' then
			playAnim('dad','idle',true)
		end
	end
end