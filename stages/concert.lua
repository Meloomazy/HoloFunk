
local dataStage = {
    x = -275,
    y = 5
}

function onCreate()
    local scale = 0.85
    makeLuaSprite('sky','bgs/concert/sky', -1275, -625)
    scaleObject('sky',scale,scale)
    addLuaSprite('sky')

    makeLuaSprite('farBuildings','bgs/concert/farbuildings', -1275, -625)
    scaleObject('farBuildings',scale,scale)
    addLuaSprite('farBuildings')

    makeLuaSprite('buildings','bgs/concert/buildings', -1275, -625)
    scaleObject('buildings',scale,scale)
    addLuaSprite('buildings')

    makeLuaSprite('glowWin','bgs/concert/win1', -1275, -625)
    scaleObject('glowWin',scale,scale)
    addLuaSprite('glowWin')

    makeLuaSprite('backcrowd','bgs/concert/backcrowd', -1275, -625)
    scaleObject('backcrowd',scale,scale)
    addLuaSprite('backcrowd')

    makeLuaSprite('stage','bgs/concert/stage', -1275, -625)
    scaleObject('stage',scale,scale)
    addLuaSprite('stage')

    makeAnimatedLuaSprite('speakerLeft','bgs/concert/speaker_left', -655, 5)
    addAnimationByPrefix('speakerLeft','bop','speaker 2',24,false)
    scaleObject('speakerLeft',0.75,0.75)
    addLuaSprite('speakerLeft')

        makeAnimatedLuaSprite('speakerLeftRE','bgs/concert/speaker_left', -650, 600)
        addAnimationByPrefix('speakerLeftRE','bop','speaker 2',24,false)
        scaleObject('speakerLeftRE',0.75,0.75)
        setProperty('speakerLeftRE.flipY',true)
        setProperty('speakerLeftRE.alpha',0.1)
        addLuaSprite('speakerLeftRE')

    makeAnimatedLuaSprite('speakerLeftMini','bgs/concert/speakerleft', -335, 170)
    addAnimationByPrefix('speakerLeftMini','bop','speaker',24,false)
    scaleObject('speakerLeftMini',0.5,0.5)
    addLuaSprite('speakerLeftMini')
        
        makeAnimatedLuaSprite('speakerLeftMiniRE','bgs/concert/speakerleft', -325, 560)
        addAnimationByPrefix('speakerLeftMiniRE','bop','speaker',24,false)
        scaleObject('speakerLeftMiniRE',0.5,0.5)
        setProperty('speakerLeftMiniRE.flipY',true)
        setProperty('speakerLeftMiniRE.alpha',0.1)
        addLuaSprite('speakerLeftMiniRE')

    makeAnimatedLuaSprite('speakerRight','bgs/concert/speaker_right', 1020, 5)
    addAnimationByPrefix('speakerRight','bop','speaker 1',24,false)
    scaleObject('speakerRight',0.75,0.75)
    addLuaSprite('speakerRight')

        makeAnimatedLuaSprite('speakerRightRE','bgs/concert/speaker_right', 1020, 560)
        addAnimationByPrefix('speakerRightRE','bop','speaker 1',24,false)
        addOffset('speakerRightRE','bop',0,0)
        scaleObject('speakerRightRE',0.75,0.75)
        setProperty('speakerRightRE.flipY',true)
        setProperty('speakerRightRE.alpha',0.1)
        addLuaSprite('speakerRightRE')

    makeAnimatedLuaSprite('speakerRightMini','bgs/concert/speakerleft', 730, 170)
    addAnimationByPrefix('speakerRightMini','bop','speaker',24,false)
    scaleObject('speakerRightMini',0.5,0.5)
    setProperty('speakerRightMini.flipX',true)
    addLuaSprite('speakerRightMini')

        makeAnimatedLuaSprite('speakerRightMiniRE','bgs/concert/speakerleft', 730, 630)
        addAnimationByPrefix('speakerRightMiniRE','bop','speaker',24,false)
        scaleObject('speakerRightMiniRE',0.5,0.5)
        setProperty('speakerRightMiniRE.flipX',true)
        setProperty('speakerRightMiniRE.flipY',true)
        setProperty('speakerRightMiniRE.alpha',0.1)
        addLuaSprite('speakerRightMiniRE')

    makeLuaSprite('frontcrowd','bgs/concert/frontcrowd', -1275, -105) --625
    scaleObject('frontcrowd',scale,scale)
    addLuaSprite('frontcrowd',true)

    --makeLuaSprite('jabibi_amogus','bgs/concert/jabibi_amogus', -1275, -625)
    --scaleObject('jabibi_amogus',scale,scale)
    --addLuaSprite('jabibi_amogus')

    setProperty('glowWin.color',getColorFromHex('12fa05'))
end
local speakers = {'speakerLeft','speakerRight','speakerLeftMini','speakerRightMini','speakerLeftRE','speakerRightRE','speakerLeftMiniRE','speakerRightminiRE'}
local colors = {'c24b99','00ffff','12fa05','f9393f'}
local curColor = 3
function onBeatHit()
    if curBeat % 4 == 0 then
        for s = 1,#speakers do
            playAnim(speakers[s],'bop',true)
        end
        curColor = curColor + 1
        if curColor > 4 then
            curColor = 1
        end
        setProperty('glowWin.color',getColorFromHex(colors[curColor]))
    end
    if curBeat % 2 == 0 then
        scaleObject('frontcrowd',0.88,0.92,false)
        scaleObject('backcrowd',0.88,0.92,false)
        doTweenX('frontcrowdX','frontcrowd.scale',0.85,0.8,'expoOut')
        doTweenY('frontcrowdY','frontcrowd.scale',0.85,0.8,'expoOut')
        doTweenX('backcrowdX','backcrowd.scale',0.85,0.8,'expoOut')
        doTweenY('backcrowdY','backcrowd.scale',0.85,0.8,'expoOut')
    end
end

function onCreatePost()
    runHaxeCode([[

		BFPos = [game.boyfriend.x,game.boyfriend.y];
      	DadPos = [game.dad.x,game.dad.y];

		reflectBF = new Boyfriend(BFPos[0] + 0, BFPos[1] + 390, ']]..boyfriendName..[[');
		game.addBehindBF(reflectBF);

		reflectGF = new Character(game.gf.x - 0, game.gf.y + 730, ']]..gfName..[[');
		game.addBehindGF(reflectGF);

		reflectDAD = new Character(DadPos[0] - 0, DadPos[1] + 700, ']]..dadName..[[');
		game.addBehindDad(reflectDAD);

		reflectDAD.alpha = 0.1;
		reflectBF.alpha = 0.1;
        reflectDAD.flipY = true;
		reflectBF.flipY = true;

		reflectGF.alpha = 0.1;
		reflectGF.flipY = true;
	]])
end

function onUpdatePost()
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


        reflectGF.animation.copyFrom(game.gf.animation);
        reflectGF.animation.curAnim.curFrame = game.gf.animation.curAnim.curFrame;
		reflectGF.offset.set(game.gf.animOffsets.get(game.gf.animation.curAnim.name)[0], game.gf.animOffsets.get(game.gf.animation.curAnim.name)[1]);
    ]])
end
function onEvent(n,v1,v2)
    if n == 'camelliaZoom' then
        if v1 == 'out' then
            doTweenY('frontcrowd','frontcrowd',-585,2,'expoInOut')
        else
            doTweenY('frontcrowd','frontcrowd',-125,2,'expoInOut')
        end
    end
end
local xx = 420
local yy = 290
local xx2 = 420
local yy2 = 290
local ofs = 25
local followchars = true
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