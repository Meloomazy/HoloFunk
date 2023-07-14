function onCreate()
    local objects = {'room','bed','table-tv','bookshelf','carpet','clock','ddto-poster','plat'}
    for i = 1,#objects do
        makeLuaSprite(objects[i],'bgs/nene-room/'..objects[i],-200,50)
        scaleObject(objects[i],1.3,1.3)
        addLuaSprite(objects[i])
    end
    luaDebugMode = true

    for i = 0,getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'chainsawAttack' then
            setPropertyFromGroup('unspawnNotes',i,'texture','mechanics/HurtPulse')
        end
    end
end
function onCreatePost()
    setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup')+1)
end
function onBeatHit()
end
function goodNoteHit(i,d,n,s)
    if n == 'chainsawAttack' then
        for i = 0,getProperty('notes.length')-1 do
            setPropertyFromGroup('notes',i,'noAnimation',true)
        end
        playSound('koroneswing2',1.2)
        setProperty('dad.skipDance',true)
        setProperty('boyfriend.skipDance',true)
        playAnim('dad','chainsawAttack',true)
        playAnim('boyfriend','dodge',true)
        runTimer('skipDance',0.5)
    end
end
local shakeLoop = false
function opponentNoteHit(i,d,n,s)
    if curStep > 256 then
        if not s then
            runHaxeCode([[
                game.camHUD.shake(0.004,0.25,null,true);
                strumHUD.shake(0.003,0.25,null,true);
            ]])
        end
        if not shakeLoop then
            shakeLoop = true
        end
        runTimer('shakeLoop',0.5)
    end
end

function onTimerCompleted(t)
    if t == 'shakeLoop' then shakeLoop = false end
    if t == 'skipDance' then
        for i = 0,getProperty('notes.length')-1 do
            setPropertyFromGroup('notes',i,'noAnimation',false)
        end
     setProperty('dad.skipDance',false)
     setProperty('boyfriend.skipDance',false)
    end
end
local xx = 1000
local yy = 800
local xx2 = 1350
local yy2 = 950
local ofs = 20
local followchars = true;
function onUpdate(elapsed)
    if shakeLoop then
        setProperty('camGame.targetOffset.y',10 *math.sin(getSongPosition()/21))
    end
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