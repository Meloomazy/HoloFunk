--[[
    Made By BBPanzu
    Improved By Cherry
    A Bit Fix By Laztrix

    How To Use:
        Put script in scripts folder
        if you want to use it on a certain script add a local or global variable called video sprite which equals
        dofile("mods/scripts/videoSprite.lua")
        to make the sprite do 

            makeVideoSprite("tag", "path", x, y, "Camera")
        for the camera you can put
            -camHUD
            -camGame
            -other
]]--



-- [[the stuff ]] --
function onCreate()
    addHaxeLibrary('VideoHandler', 'hxcodec')
    addHaxeLibrary('Event', 'openfl.events')
end
local videoSprites = {}
function makeVideoSprite(tag, videoPath, x, y, camera)
    makeLuaSprite(tag, '', x, y)
    setObjectCamera(tag, camera)
    addLuaSprite(tag, false)
    if tag:find('visu') then
        setSpriteShader(tag,'green')
        scaleObject(tag,0.8,0.8)
    end
    runHaxeCode([[
        ]]..tag..[[= new VideoHandler();
        ]]..tag..[[.playVideo(Paths.video("]]..videoPath..[["));
        ]]..tag..[[.visible = false; 
        FlxG.stage.removeEventListener("enterFrame", ]]..tag..[[.update);
        ]]..tag..[[.finishCallback = function()
            { 
                game.remove(]]..tag..[[);
            }

    ]])
    table.insert(videoSprites, tag)
    --debugPrint('bro the video has been started!')
end
function onUpdatePost()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            if (game.getLuaObject("]]..__..[[") != null)
            {
            game.getLuaObject("]]..__..[[").loadGraphic(]]..__..[[.bitmapData);
            ]]..__..[[.volume = FlxG.sound.volume + 0.4;
            }
        ]])
    end
end
function onDestroy()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            if (game.getLuaObject("]]..__..[[") != null)
            {
                game.remove(]]..__..[[);
            }
        ]])
    end
end
function onPause()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            ]]..__..[[.pause();
        ]])
    end
end
function onResume()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            ]]..__..[[.resume();
        ]])
    end
end