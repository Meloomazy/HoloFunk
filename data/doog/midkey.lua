
local tag = "strumMID"
function onCreatePost()
    luaDebugMode = true
    runHaxeCode([[
        game.strumLineNotes.members[4].x -= 50;
        game.strumLineNotes.members[5].x -= 50;
        game.strumLineNotes.members[6].x += 50;
        game.strumLineNotes.members[7].x += 50;
    ]])
	makeAnimatedLuaSprite(tag, 'mechanics/MIDStrum', getPropertyFromGroup('playerStrums',1,'x') + 85,getPropertyFromGroup('playerStrums',1,'y') - 30)
	addAnimationByPrefix(tag, 'keyConfirm', 'space confirm', 24, false)
    addOffset(tag,'keyConfirm',20,20)
	addAnimationByPrefix(tag, 'keyPressed', 'space press', 24, false)
    addOffset(tag,'keyPressed',0,0)
	addAnimationByPrefix(tag, 'keyArrow', 'arrow static', 24, false)
    addOffset(tag,'keyArrow',0,-1)
	scaleObject(tag,0.7,0.7)
	addLuaSprite(tag,true)
    runHaxeCode("game.getLuaObject('"..tag.."').camera = strumHUD")
    debugPrint('krill yourself')

    for i = 0,getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'MID Note' then
            setPropertyFromGroup('unspawnNotes',i,'texture','mechanics/MIDStrum')
            setPropertyFromGroup('unspawnNotes',i,'blockHit',true)
            setPropertyFromGroup('unspawnNotes',i,'ignoreNote',true)
        end
    end
end
function onSongStart()
    playAnim(tag,'keyArrow',true)
end
local allowedtouch = false
function onUpdatePost()
	for i=0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', i, 'noteType') == 'MID Note' then
            
		 noteX = getPropertyFromGroup('notes', i, 'x')
		 noteY = getPropertyFromGroup('notes', i, 'y')

			hitbox = 50;
			
			noteData = getPropertyFromGroup('notes', i, 'noteData');
			
			strumY = getProperty(tag..'.y')	

			noteX = getProperty(tag..'.x')
	
            setPropertyFromGroup('notes', i, 'copyX', false)
			setPropertyFromGroup('notes', i, 'x', noteX + (getPropertyFromGroup('notes', i, 'isSustainNote') and 60 or 21))
            if math.abs(noteY - strumY) <= hitbox then
                allowedtouch = true
				if keyboardPressed("SPACE") then
					playAnim(tag, 'keyConfirm', true)
					removeFromGroup('notes', i)
                    setProperty('boyfriend.holdTimer',0)
                    playAnim('boyfriend','singMID',true)
				end
            else
                allowedtouch = false
			end
		end
	end
    if keyboardPressed("SPACE") and not allowedtouch then
        playAnim(tag, 'keyPressed', true)
    end
    if getProperty('strumMID.animation.curAnim.name') == 'keyPressed' and getProperty('strumMID.animation.curAnim.finished') or getProperty('strumMID.animation.curAnim.name') == 'keyConfirm' and getProperty('strumMID.animation.curAnim.finished') then
        playAnim(tag, 'keyArrow', true)
    end
end
