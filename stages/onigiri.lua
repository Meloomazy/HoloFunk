function onCreate()
    local scale = 1
    local path = (songPath:find('sinner') and 'onigiri-evening' or 'onigiri')
    makeLuaSprite('sky','bgs/onigiri/sky',0,0)
    scaleObject('sky',scale,scale)
    addLuaSprite('sky')

    makeLuaSprite('schoolBuilding','bgs/'..path..'/school',78,220)
    scaleObject('schoolBuilding',scale,scale)
    addLuaSprite('schoolBuilding')

    makeLuaSprite('wall','bgs/'..path..'/wall',0,700)
    scaleObject('wall',scale,scale)
    setScrollFactor('wall',1.03,1.1)
    addLuaSprite('wall')

    makeLuaSprite('road','bgs/'..path..'/road',0,990)
    scaleObject('road',scale,scale)
    setScrollFactor('road',1.02,1.05)
    addLuaSprite('road')

    makeLuaSprite('leftShadow','bgs/onigiri/leftShadow',0,940)
    scaleObject('leftShadow',scale,scale)
    setScrollFactor('leftShadow',1.02,1.05)
    addLuaSprite('leftShadow')

    makeLuaSprite('rightShadow','bgs/onigiri/rightShadow',1580,830)
    scaleObject('rightShadow',scale,scale)
    setScrollFactor('rightShadow',1.02,1.05)
    addLuaSprite('rightShadow')

    makeLuaSprite('leftTree','bgs/'..path..'/leftTree',-25,200)
    scaleObject('leftTree',scale,scale)
    setScrollFactor('leftTree',1.03,1)
    addLuaSprite('leftTree')

    makeLuaSprite('leftGrass','bgs/'..path..'/leftGrass',-8,870)
    scaleObject('leftGrass',scale,scale)
    setScrollFactor('leftGrass',1.02,1.05)
    addLuaSprite('leftGrass')

    makeLuaSprite('rightTree','bgs/'..path..'/rightTree',1555,200)
    scaleObject('rightTree',scale,scale)
    setScrollFactor('rightTree',1.03,1)
    addLuaSprite('rightTree')

    makeLuaSprite('rightGrass','bgs/'..path..'/rightGrass',1777,865)
    scaleObject('rightGrass',scale,scale)
    setScrollFactor('rightGrass',1.02,1.05)
    addLuaSprite('rightGrass')

    --crowd
    local color = 'E3B3E0'
    makeAnimatedLuaSprite('choco','bgs/onigiri/choco',250,600)
    addAnimationByPrefix('choco','bop1','choco bop 1',6,true)
    addAnimationByPrefix('choco','bop2','choco bop 2',9,true)
    scaleObject('choco',0.95,0.95)
    setProperty('choco.color',getColorFromHex(color))
    addLuaSprite('choco')


    makeAnimatedLuaSprite('iofi','bgs/onigiri/iofi',500,600)
    addAnimationByPrefix('iofi','bop1','iofi bop 1',6,true)
    addAnimationByPrefix('iofi','bop2','iofi bop 2',9,true)
    scaleObject('iofi',0.95,0.95)
    setProperty('iofi.color',getColorFromHex(color))
    addLuaSprite('iofi')

    makeAnimatedLuaSprite('sana','bgs/onigiri/sana',850,510)
    addAnimationByPrefix('sana','bop1','azki bop 1',12,true)
    addAnimationByPrefix('sana','bop2','sana bop 2',9,true)
    scaleObject('sana',0.95,0.95)
    addLuaSprite('sana')

    makeAnimatedLuaSprite('reine','bgs/onigiri/reine',1550,530)
    addAnimationByPrefix('reine','bop1','reine bop 1',6,true)
    addAnimationByPrefix('reine','bop2','reine bop 2',9,true)
    scaleObject('reine',0.95,0.95)
    setProperty('reine.color',getColorFromHex(color))
    addLuaSprite('reine')

    makeAnimatedLuaSprite('shion','bgs/onigiri/shion',1750,660)
    addAnimationByPrefix('shion','bop1','shion bop 1',6,true)
    addAnimationByIndicesLoop('shion','bop2','shion idle','0,2,4,3,1',9)
    scaleObject('shion',0.95,0.95)
    setProperty('shion.color',getColorFromHex(color))
    addLuaSprite('shion')

    makeAnimatedLuaSprite('azki','bgs/onigiri/azki',1900,630)
    addAnimationByPrefix('azki','bop1','azki bop 1',6,true)
    addAnimationByPrefix('azki','bop2','azki bop 2',9,true)
    scaleObject('azki',0.95,0.95)
    setProperty('azki.color',getColorFromHex(color))
    addLuaSprite('azki')

    local animName = (songPath:find('sinner') and 'bop2' or 'bop1')
    playAnim('choco',animName,true)
    playAnim('iofi',animName,true)
    playAnim('azki',animName,true)


    --effect events
    makeLuaSprite("overlay", "", 0, 0)
    makeGraphic("overlay", 1280 * 3, 720 * 3, 'DF97BE')
    setBlendMode('overlay','add')
    setScrollFactor('overlay',0,0)
    setProperty('overlay.alpha',0.0)
    screenCenter("overlay")
    addLuaSprite("overlay", true)

    makeLuaSprite('mogu1','bgs/'..path..'/mogu',200,750)
    scaleObject('mogu1',0,0,false)
    setProperty('mogu1.angle',-30)
    addLuaSprite('mogu1',true)

    makeLuaSprite('mogu2','bgs/'..path..'/mogu',600,350)
    scaleObject('mogu2',0,0,false)
    setProperty('mogu2.angle',30)
    addLuaSprite('mogu2',true)

    makeLuaSprite('mogu3','bgs/'..path..'/mogu',950,300)
    scaleObject('mogu3',0.0,0.0,false)
    setProperty('mogu3.angle',30)
    addLuaSprite('mogu3',true)

    makeLuaSprite('mogu4','bgs/'..path..'/mogu',1450,650)
    scaleObject('mogu4',0.0,0.0,false)
    setProperty('mogu4.angle',-30)
    addLuaSprite('mogu4',true)
end
function onCreatePost()
    if songPath:find('senpai') then
        if boyfriendName:find('pixel') then
            runHaxeCode([[
                game.dad.y -= 50;
                game.dad.x += 50;

                game.boyfriend.y += 180;
                game.boyfriend.x += 180;

                game.gf.y += 430;
                game.gf.x += 160;
            ]])
        elseif dadName:find('roberu') then
            runHaxeCode([[
                game.boyfriend.y += 10;
                game.boyfriend.x -= 100;

                game.gf.y += 150;
                game.gf.x -= 100;
            ]])
        else
            runHaxeCode([[
                game.dad.y += 20;
                game.dad.x += 100;

                game.boyfriend.y += 10;
                game.boyfriend.x -= 100;

                game.gf.y += 150;
                game.gf.x -= 100;
            ]])
        end
    end
end
function opponentNoteHit()
    xx = 900
    yy = 800
    xx2 = (boyfriendName:find('holo') and 1450 or 1600)
    yy2 = (boyfriendName:find('holo') and 920 or 850)
end
function onBeatHit()
    if curBeat % 2 == 1 then
        --playAnim('shion','bop up',true)
    elseif curBeat % 2 == 0 then
        --playAnim('shion','bop down',true)
    end

    if songPath:find('sinner') then
        if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
            playAnim('boyfriend','idle',true)
        end
        if getProperty('dad.animation.curAnim.name') == 'idle' then
            playAnim('dad','idle',true)
        end
    end
end


local effectParticle = false
function onEvent(n,v1)
    if n == 'mogu' then
        if v1 == 'left' and v2 == '1' then
            setProperty('mog')
        end
    end
end
function onStepHit()
    if songPath == 'yummy' then
        if curStep == 320 then
            effectParticle = true
            cameraFlash('camHUD','ffffff',0.2)
            setProperty('overlay.alpha',0.1)
        end
        if curStep == 384 or curStep == 400 then
            doTweenAngle('mogu1Angle','mogu1',-10,0.6,'quartOut')
            doTweenX('mogu1ScaleX','mogu1.scale',0.4,0.6,'backOut')
            doTweenY('mogu1ScaleY','mogu1.scale',0.4,0.6,'backOut')
            runTimer('mogu1back',1.05)
        end
        if curStep == 388 or curStep == 404 then
            doTweenAngle('mogu2Angle','mogu2',10,0.7,'quartOut')
            doTweenX('mogu2ScaleX','mogu2.scale',0.4,0.6,'backOut')
            doTweenY('mogu2ScaleY','mogu2.scale',0.4,0.6,'backOut')
            runTimer('mogu2back',1.05)
        end
        if curStep == 512 or curStep == 528 then
            doTweenAngle('mogu3Angle','mogu3',-10,0.7,'quartOut')
            doTweenX('mogu3ScaleX','mogu3.scale',0.4,0.6,'backOut')
            doTweenY('mogu3ScaleY','mogu3.scale',0.4,0.6,'backOut')
            runTimer('mogu3back',1.05)
        end
        if curStep == 516 or curStep == 532 then
            doTweenAngle('mogu4Angle','mogu4',10,0.7,'quartOut')
            doTweenX('mogu4ScaleX','mogu4.scale',0.4,0.6,'backOut')
            doTweenY('mogu4ScaleY','mogu4.scale',0.4,0.6,'backOut')
            runTimer('mogu4back',1.05)
        end
    end

    if effectParticle then
        if curStep % 3 == 0 then
            particle()
        end
    end
end
function onTimerCompleted(t)
    if t == 'mogu1back' then
        doTweenAngle('mogu1Angle','mogu1',-30,0.7,'quartOut')
        doTweenX('mogu1ScaleX','mogu1.scale',0,0.6,'quartOut')
        doTweenY('mogu1ScaleY','mogu1.scale',0,0.6,'quartOut')
    end
    if t == 'mogu2back' then
        doTweenAngle('mogu2Angle','mogu2',30,0.7,'quartOut')
        doTweenX('mogu2ScaleX','mogu2.scale',0,0.6,'quartOut')
        doTweenY('mogu2ScaleY','mogu2.scale',0,0.6,'quartOut')
    end
    if t == 'mogu3back' then
        doTweenAngle('mogu3Angle','mogu3',30,0.7,'quartOut')
        doTweenX('mogu3ScaleX','mogu3.scale',0,0.6,'quartOut')
        doTweenY('mogu3ScaleY','mogu3.scale',0,0.6,'quartOut')
    end
    if t == 'mogu4back' then
        doTweenAngle('mogu4Angle','mogu4',-30,0.7,'quartOut')
        doTweenX('mogu4ScaleX','mogu4.scale',0,0.6,'quartOut')
        doTweenY('mogu4ScaleY','mogu4.scale',0,0.6,'quartOut')
    end
end
local partics = 0
function particle()
    partics = partics + 1
    local tag = 'sparkle'..partics
    makeLuaSprite(tag,'bgs/onigiri/sparkle',1400,getRandomInt(-1,721))
    setObjectCamera(tag,'camOther')
    scaleObject(tag,getRandomFloat(0.7,1),getRandomFloat(0.7,1))
    setProperty(tag..'.velocity.x',getRandomInt(-150,-50))
    addLuaSprite(tag)
end
xx = 1230
yy = 800
xx2 = 1230
yy2 = 800
local ofs = 30
local followchars = true;
function onUpdate(elapsed)
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'danceLeft' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'danceRight' then
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
            if getProperty('boyfriend.animation.curAnim.name') == 'danceLeft' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'danceRight' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end

    if songPath == 'son' then
        if curStep == 54 then      
            xx = 1600
            yy = 820
            xx2 = 1500
            yy2 = 820
        end
        if curStep == 78 then      
            xx = 900
            yy = 800
            xx2 = 1500
            yy2 = 820
        end
        if curStep == 86 then      
            xx = 1220
            yy = 800
            ofs = 0
        end
        if curStep > 142 then
            setProperty('boyfriend.skipDance',true)
        end
    end
end