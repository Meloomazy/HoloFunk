local eventArray = {} 
local videoSprites = {}
function onCreate()
    addHaxeLibrary('VideoHandler', 'hxcodec')
    addHaxeLibrary('Event', 'openfl.events')

    local scale = 1.55
    makeLuaSprite('backgrond','bgs/camellia-bob/jurassic',-500,-200)
    scaleObject('backgrond',scale,scale)
    setScrollFactor('backgrond',0.5,0.5)
    addLuaSprite('backgrond')

    makeLuaSprite('wal','bgs/camellia-bob/wall',-250,-100)
    scaleObject('wal',scale,scale)
    addLuaSprite('wal')

    makeLuaSprite('flor','bgs/camellia-bob/flor',-250,-100)
    scaleObject('flor',scale,scale)
    setScrollFactor('flor',0.9,0.9)
    addLuaSprite('flor')

    makeLuaSprite('glow_bf','bgs/camellia-bob/BF_GLOW',-300,150)
    scaleObject('glow_bf',1.2,1.2)
    addLuaSprite('glow_bf')

    makeLuaSprite('glow_cam','bgs/camellia-bob/CAMELLIA_GLOW',-415,500)
    scaleObject('glow_cam',1.2,1.2)
    addLuaSprite('glow_cam')

    makeAnimatedLuaSprite('glass','bgs/camellia-bob/Glass_Boom',0,0)
    addAnimationByPrefix('glass','break','Break',32,false)
    screenCenter('glass')
    setObjectCamera('glass','camOther')
    setProperty('glass.alpha',0.00001)
    addLuaSprite('glass')

    luaDebugMode = true
    local json = dofile('mods/'..currentModDirectory..'/scripts/JSONLIB.lua')
    local jsonTable = json.parse(getTextFromFile('data/toast/event.json'))
    
    for _, event in ipairs(jsonTable.events) do
        local eventData = {
            step = event.step,
            name = event.name,
            args = event.args
        }
        table.insert(eventArray, eventData)
    end
    runHaxeCode([[
        game.initLuaShader('pixel');
        pixel = game.createRuntimeShader('pixel');
        pixel.setFloat('pixelly',0.1);
    ]])
end

function onStepHit()
    for _, event in ipairs(eventArray) do
        if event.step == curStep then
            if event.name == 'funnyLTGevent' then
                makeVideoSprite(event.args[1],event.args[1])
            elseif event.name == 'funnyVideoEvent' then
                makeVideoHUDSprite(event.args[1],event.args[1])
            elseif event.name == 'changeBPM' then
                debugPrint('changeBPM Event :scream:')
            elseif event.name == 'changeChar' then
                debugPrint('changeChar Event :imp:')
            end
        end
    end
    if curStep == 4460 then
        runHaxeCode([[
            game.camHUD.setFilters([new ShaderFilter(pixel)]);
            game.camGame.setFilters([new ShaderFilter(pixel)]);
        ]])
    end
    if curStep == 4512 then
        runHaxeCode([[
            game.camHUD.setFilters([]);
            game.camGame.setFilters([]);
        ]])
    end
    if curStep == 5172 then
        setProperty('glass.alpha',1)
        playAnim('glass','break',true)
    end
    if curStep == 5216 then
        doTweenAlpha('glassgone','glass',0,0.5)
    end
end

function onCreatePost()
    setProperty('gf.visible',false)
    runHaxeCode([[
		BFPos = [game.boyfriend.x,game.boyfriend.y];
      	DadPos = [game.dad.x,game.dad.y];

		reflectBF = new Boyfriend(BFPos[0] + 0, BFPos[1] + 390, ']]..boyfriendName..[[');
		game.addBehindBF(reflectBF);

		reflectDAD = new Character(DadPos[0] - 0, DadPos[1] + 500, ']]..dadName..[[');
		game.addBehindDad(reflectDAD);

		reflectDAD.alpha = 0.1;
		reflectBF.alpha = 0.1;
        reflectDAD.flipY = true;
		reflectBF.flipY = true;
	]])
end
local yes = false
function onEvent(n,v1,v2)
    if n == 'Change Character' then
        if v2 == 'camellia' and not yes then
            runHaxeCode'game.dad.y -= 200'
            yes = true
        end
    end
end
function onUpdatePost()
    if dadName == 'bobmellia' and boyfriendName:find('bf') then
        runHaxeCode([[
            reflectBF.animation.copyFrom(game.boyfriend.animation);
            reflectBF.animation.curAnim.curFrame = game.boyfriend.animation.curAnim.curFrame;
            if (reflectBF.animation.curAnim.name == 'singDOWN')
                reflectBF.offset.set(game.boyfriend.animOffsets.get(game.boyfriend.animation.curAnim.name)[0], game.boyfriend.animOffsets.get(game.boyfriend.animation.curAnim.name)[1] * 0.0);
            else
                reflectBF.offset.set(game.boyfriend.animOffsets.get(game.boyfriend.animation.curAnim.name)[0], game.boyfriend.animOffsets.get(game.boyfriend.animation.curAnim.name)[1] * 0.0);

            reflectDAD.animation.copyFrom(game.dad.animation);
            reflectDAD.animation.curAnim.curFrame = game.dad.animation.curAnim.curFrame;
            reflectDAD.offset.set(game.dad.animOffsets.get(game.dad.animation.curAnim.name)[0], game.dad.animOffsets.get(game.dad.animation.curAnim.name)[1]);
            if (reflectDAD.animation.curAnim.name == 'singDOWN')
                reflectDAD.offset.set(game.dad.animOffsets.get(game.dad.animation.curAnim.name)[0], game.dad.animOffsets.get(game.dad.animation.curAnim.name)[1] * 0.0);
            else
                reflectDAD.offset.set(game.dad.animOffsets.get(game.dad.animation.curAnim.name)[0], game.dad.animOffsets.get(game.dad.animation.curAnim.name)[1] * 0.0);
        ]])
     end

    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            if (game.getLuaObject("]]..__..[[") != null)
            {
            game.getLuaObject("]]..__..[[").loadGraphic(]]..__..[[.bitmapData);
            ]]..__..[[.volume = 0;
            }
        ]])
    end
end

function onBeatHit()
    if curBeat % 4 == 2 and getProperty('camZooming') then
        runHaxeCode([[
            FlxG.camera.zoom += 0.015 * game.camZoomingMult;
            game.camHUD.zoom += 0.03 * game.camZoomingMult;
        ]])
    end
end

function makeVideoSprite(tag, videoPath)
    makeLuaSprite(tag, nil, 28,97)
    setObjectCamera(tag, 'camGame')
    setObjectOrder(tag, getObjectOrder('backgrond')+1)
    setScrollFactor(tag,0.5,0.5)
    scaleObject(tag,1.55,1.55)
    addLuaSprite(tag)
    runHaxeCode([[
        ]]..tag..[[= new VideoHandler();
        ]]..tag..[[.playVideo(Paths.video("toast/]]..videoPath..[["));
        ]]..tag..[[.visible = false; 
        FlxG.stage.removeEventListener("enterFrame", ]]..tag..[[.update);
        ]]..tag..[[.finishCallback = function()
            { 
                game.remove(game.getLuaObject("]]..tag..[[")); 
            }
    ]])
    table.insert(videoSprites, tag)
end
function makeVideoHUDSprite(tag, videoPath)
    makeLuaSprite(tag, nil, -320, -180)
    setObjectCamera(tag, 'camHUD')
    scaleObject(tag, 0.67, 0.67)
    setObjectOrder(tag, 0)
    addLuaSprite(tag)

    runHaxeCode([[
        ]]..tag..[[= new VideoHandler();
        ]]..tag..[[.playVideo(Paths.video("toast/]]..videoPath..[["));
        ]]..tag..[[.visible = false; 
        FlxG.stage.removeEventListener("enterFrame", ]]..tag..[[.update);
        ]]..tag..[[.finishCallback = function()
            { 
                game.remove(game.getLuaObject("]]..tag..[[")); 
            }

    ]])
    table.insert(videoSprites, tag)
end
xx = 1250
yy = 730
xx2 = 1250
yy2 = 730
local ofs = 20
local followchars = true;
function onUpdate(elapsed)
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
        else
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
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