local eventArray = {} 
local videoSprites = {}
function onCreate()
    addHaxeLibrary('VideoHandler', 'hxcodec')
    addHaxeLibrary('Event', 'openfl.events')

    local scale = 1.55
    makeLuaSprite('backgrond','bgs/camellia/BG_city',-500,-200)
    scaleObject('backgrond',scale,scale)
    setScrollFactor('backgrond',0.5,0.5)
    addLuaSprite('backgrond')

    makeLuaSprite('wal','bgs/camellia/BG_WALL',-250,-100)
    scaleObject('wal',scale,scale)
    addLuaSprite('wal')

    makeLuaSprite('flor','bgs/camellia/FG_Floor',-250,-100)
    scaleObject('flor',scale,scale)
    setScrollFactor('flor',0.9,0.9)
    addLuaSprite('flor')

    makeLuaSprite('glow_bf','bgs/camellia/BF_GLOW',-100,180)
    setProperty('glow_bg.alpha',0.5)
    scaleObject('glow_bf',1.2,1.2)
    addLuaSprite('glow_bf',true)

    makeLuaSprite('glow_cam','bgs/camellia/CAMELLIA_GLOW',-115,170)
    scaleObject('glow_cam',1.2,1.2)
    setProperty('glow_cam.alpha',0.5)
    addLuaSprite('glow_cam',true)
end

xx = 1250
yy = 730
local ofs = 20
function onCreatePost()
    setProperty('isCameraOnForcedPos',true)
    setProperty('camFollow.x',xx)
    setProperty('camFollow.y',yy)
    setProperty('camFollowPos.x',xx)
    setProperty('camFollowPos.y',yy)
    runHaxeCode([[
		BFPos = [game.boyfriend.x,game.boyfriend.y];
      	DadPos = [game.dad.x,game.dad.y];

		reflectBF = new Boyfriend(BFPos[0] + 0, BFPos[1] + 390, ']]..boyfriendName..[[');
		game.addBehindBF(reflectBF);
        
		reflectGF = new Character(game.gf.x - 0, game.gf.y + 640, ']]..gfName..[[');
		game.addBehindGF(reflectGF);

		reflectDAD = new Character(DadPos[0] - 0, DadPos[1] + 700, ']]..dadName..[[');
		game.addBehindDad(reflectDAD);


        reflectGF.alpha = 0.2;
		reflectDAD.alpha = 0.2;
		reflectBF.alpha = 0.2;

        reflectGF.flipY = true;
        reflectDAD.flipY = true;
		reflectBF.flipY = true;
	]])
end
function goodNoteHit(i,d)
    if d == 0 then setProperty('camFollow.x',xx - ofs) end
    if d == 1 then setProperty('camFollow.y',yy + ofs) end
    if d == 2 then setProperty('camFollow.y',yy - ofs) end
    if d == 3 then setProperty('camFollow.x',xx + ofs) end
end
function onUpdatePost()
    runHaxeCode([[
        reflectGF.animation.copyFrom(game.gf.animation);
        reflectGF.animation.curAnim.curFrame = game.gf.animation.curAnim.curFrame;
		reflectGF.offset.set(game.gf.animOffsets.get(game.gf.animation.curAnim.name)[0], game.gf.animOffsets.get(game.gf.animation.curAnim.name)[1]);

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