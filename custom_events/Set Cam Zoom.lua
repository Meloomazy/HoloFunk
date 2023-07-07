function onCreatePost()
	ogZoom = getProperty('defaultCamZoom')
	ogZoomTween = getProperty('camGame.zoom')
end
function onEvent(n,v1,v2)
    if n == "Set Cam Zoom" then
		valZoom = (v1 == '' and ogZoom or ogZoom + v1)
		setProperty('camZooming',false)
		doTweenZoom('camz','camGame',valZoom,1,'quartOut')   
		setProperty("defaultCamZoom",valZoom) 
    end
end

function onTweenCompleted(n)
	if n == 'camz' then
		setProperty("defaultCamZoom",getProperty('camGame.zoom')) 
		setProperty('camZooming',true)
		ogZoomTween = getProperty('camGame.zoom')
	end
end