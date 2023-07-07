theease = 'expoInOut'
extrazoom = 0.16
function onEvent(name,value1,value2)
    if name == "camelliaZoom" then
		setProperty('camZooming',false)
        if value1 == 'out' then
			out = true
      	    setProperty("defaultCamZoom",getProperty('defaultCamZoom')-extrazoom)
			doTweenZoom('camz','camGame',getProperty('camGame.zoom')-extrazoom,2,theease)
			doTweenZoom('camze','camHUD',getProperty('camHUD.zoom')-extrazoom,2,theease)
		elseif value1 == 'in' then
			out = false
			setProperty("defaultCamZoom",getProperty('defaultCamZoom')+extrazoom)
			doTweenZoom('camz','camGame',getProperty('camGame.zoom')+extrazoom,2,theease)
			doTweenZoom('camze','camHUD',getProperty('camHUD.zoom')+extrazoom,2,theease)
	    end 
    end
end
function onUpdatePost()
	if getProperty('camZooming') then
		if out then
			setProperty('camHUD.zoom',getProperty('camHUD.zoom') / 1.01)
		end
	end
end
function onTweenCompleted(name)
    if name == 'camz' then
		setProperty('camZooming',true)
      	setProperty("defaultCamZoom",getProperty('camGame.zoom')) 
    end
end