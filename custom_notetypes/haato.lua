function onCreate()
	precacheSound('haatoNote')
	precacheImage('splashes/HaatoSplash')
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'haato' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/NOTE_haato')
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'splashes/HaatoSplash')
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
				if not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
					setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
				end
			end
		end
	end

    local ui_x, ui_y = 0, (downscroll and 55 or 690)

end
function onSongStart()
    setProperty('UI_Health_CENTER.alpha',1)

	setProperty('UI_Health_CENTER.color',getColorFromHex('ff0000'))
	doTweenColor('UI_Health_CENTERFlash','UI_Health_CENTER',getProperty('UI_Health_LEFT.color'),0.7,'quartOut')
end
function onTimerCompleted(t)
	if t == 'UI_Health_CENTERFade' then
		doTweenColor('UI_Health_CENTERFlash','UI_Health_CENTER','ffffff',0.7,'quartOut')
	end
end
function onTweenCompleted(t)
	if t == 'UI_Health_CENTERFlash' then
		--runTimer('UI_Health_CENTERFade',2)
		doTweenColor('UI_Health_CENTERFade','UI_Health_CENTER','ff0000',0.6,'circOut')
	end
	if t == 'UI_Health_CENTERFade' then
		doTweenColor('UI_Health_CENTERFlash','UI_Health_CENTER',rgbToHex(getProperty("dad.healthColorArray")),0.7,'quartOut')
	end
end
local hit = 0
healthLimit = 0
function noteMiss(id, nd, nt, sus)
	if nt == 'haato' and not sus then
		hit = hit + 1
		cameraFlash('camHUD','000000',0.8,true)
		playSound('haatoNote',1.2)
		callScript('scripts/HUDManager','changeHealthOffset',{10})
		setProperty('healthBar.x',getProperty('healthBar.x')+ 150)
		setProperty('UI_Health_LEFT.x',getProperty('UI_Health_LEFT.x')+ (hit == 2 and 180 or 150))
		setProperty('UI_Health_CENTER._frame.frame.width',getProperty('UI_Health_CENTER._frame.frame.width') + 180)
		healthLimit = healthLimit + 20
		if hit == 4 then
			setHealth(0)
		end
	end
end
function onUpdate()
	if getProperty('healthBar.percent') < healthLimit then
		setHealth(0)
	end
end
function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end
function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end