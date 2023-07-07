function onCreate()
    addHaxeLibrary('Application', 'lime.app')
    addHaxeLibrary('Image','lime.graphics')
    addHaxeLibrary('ClientPrefs')
    precacheImage('splashes/holoSplash')
    createUi()


    savedWindowTitle = getPropertyFromClass('lime.app.Application',"current.window.title")
    setPropertyFromClass('lime.app.Application',"current.window.title","HoloFunk: Psych Edition")
    addHaxeLibrary('Application', 'lime.app')
    addHaxeLibrary('Image','lime.graphics')
    runHaxeCode([[
        var icon = Image.fromFile(Paths.modFolders('images/app/iconFoob.png'));
        Application.current.window.setIcon(icon);
    ]])
end
function onDestroy()
    setPropertyFromClass('lime.app.Application',"current.window.title","Friday Night Funkin': Psych Engine")
    runHaxeCode([[
        var Icon = Image.fromFile(Paths.modFolders('images/app/iconOG.png'));
        Application.current.window.setIcon(Icon);
    ]])
end
local savedOPTex
local savedPLTex
local healthOffset = 35
function onCreatePost()
    checkCharacter()

    setProperty('scoreTxt.visible',false)
    setProperty('camZoomingMult',1.2)
    setProperty('camZoomingDecay',2)

    setTextFont('timeTxt', fontName)
    setTextSize('timeTxt', 27)

    setProperty('timeBarBG.color', getColorFromHex'ffffff')
    scaleObject('timeBarBG', 1.07, 1)

    scaleObject('timeBar', 1.06, 0.68)
    scaleObject('healthBar', 1.05, 1)
    scaleObject('healthBarBG', 1.05, 1)
    runHaxeCode([[
        
        strumHUD = new FlxCamera();
		strumHUD.bgColor = 0x00000000;
        FlxG.cameras.add(strumHUD,false);
        FlxG.cameras.add(game.camOther,false);
        game.variables.set('strumHUD', strumHUD);

        if (game.modchartTexts.get('UI_Original_Text') != null)
            game.modchartTexts.get('UI_Original_Text').cameras = [game.camOther];
        if (game.modchartTexts.get('UI_Chart_Text') != null)
            game.modchartTexts.get('UI_Chart_Text').cameras = [game.camOther];
        game.modchartTexts.get('UI_Song_Text').cameras = [game.camOther];
        game.modchartTexts.get('UI_Arrange_Text').cameras = [game.camOther];

        for (i in 0...4) game.strumLineNotes.members[i].x += 50;
        for (i in 4...8) game.strumLineNotes.members[i].x -= 50;
        for (i in 0...8) game.strumLineNotes.members[i].cameras = [strumHUD];
        for (splash in game.grpNoteSplashes) splash.cameras = [strumHUD];
        for (note in game.unspawnNotes) 
        {
            note.cameras = [strumHUD];
            if (note.isSustainNote) note.cameras = [game.camHUD];
        };

        game.timeBar.createGradientBar(
            [0xFF000000]
           ,[0xFF]]..rgbToHex(getProperty('boyfriend.healthColorArray'))..[[, 0xFF]]..rgbToHex(getProperty('dad.healthColorArray'))..[[]
        );
        game.timeBar.offset.x -= 2;
        game.timeBar.offset.y -= 3;
        game.timeBar.x -= 70;
        game.timeBar.y += (ClientPrefs.downScroll ? 5 : -12);
        game.timeTxt.y += (ClientPrefs.downScroll ? 7 : -12);

        game.healthBar.x -= 18;
        game.healthBar.visible = false;
        game.healthBarBG.destroy();
    ]])
end
function onUpdatePost(e)
    runHaxeCode([[
        for (sp in game.grpNoteSplashes)
        {
            sp.cameras = [strumHUD];
            sp.offset.x = -20;
            sp.offset.y = 0;
        }
    ]])
	curHealth = getProperty('health')/2;
	setProperty('UI_Health_LEFT._frame.frame.width', healthOffset + (math.lerp(700, 0, curHealth)))

    setTextString('timeTxt', '('..formatTime(songLength - (getSongPosition() - noteOffset))..')')
    setProperty('strumHUD.zoom',getProperty('camHUD.zoom'))
    setProperty('strumHUD.x',getProperty('camHUD.x'))
    setProperty('strumHUD.y',getProperty('camHUD.y'))
    setProperty('strumHUD.alpha',getProperty('camHUD.alpha'))
end 
function onUpdateScore()
    setTextString('UI_Score_Txt', score)
    setTextString('UI_Breaks_Txt', misses)
    if score > 0 then
        setTextString('UI_Accuracy_Txt', round((getProperty('ratingPercent') * 100), 2) ..'%')
        setTextString('UI_Rank_Txt', score > 0 and ratingFC or 'Clear')
    end
end
function goodNoteHit(id,dir,nt,sus)
    if not sus then
        pulse('ffffff')
    end
end
function opponentNoteHit(id,dir,nt,sus)
    if sus and holdDisable then
        setProperty('dad.holdTimer', 0)
    end
end
function noteMiss(id,dir,nt,sus)
    if not sus then
        pulse('ff0000')
    end
end
function onEvent(n,v1,v2)
    if n == 'Change Character' then
        checkCharacter()
    end
end
function onSpawnNote(i, d, t, s)
    if not disableSkin then
        if getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'normal' then
            if getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'texture', savedPLTex)
                setPropertyFromGroup('notes', i, 'noteSplashTexture', savedSplashPLTex)
            else
                setPropertyFromGroup('notes', i, 'texture', savedOPTex)
                setPropertyFromGroup('notes', i, 'noteSplashTexture', savedSplashOPTex)
            end
        end
    end
end
function onCountdownTick(ti)
    if ti == 1 then
        scaleObject('countdownReady',0.5,0.5)
        screenCenter('countdownReady')
    elseif ti == 2 then
        scaleObject('countdownSet',0.5,0.5)
        screenCenter('countdownSet')
    elseif ti == 3 then
        scaleObject('countdownGo',0.5,0.5)
        screenCenter('countdownGo')
    end
end


--- functions
local disableSkin = false
function createUi()
    local ui_x, ui_y = 0, (downscroll and 55 or 610)
    if week == 'Camellia' then
        ui = 'ui/myth/'
        fontName = 'Montserrat.ttf'
    else
        ui = 'ui/fantasy/'
        fontName = 'Krungthep.ttf'
    end

    makeLuaSprite('UI_Health_RIGHT', ui..'health_Bar', ui_x, ui_y+1)
    screenCenter('UI_Health_RIGHT', 'x')
    setObjectCamera('UI_Health_RIGHT', 'camHUD')
    addLuaSprite('UI_Health_RIGHT')

        -- for something else
    makeLuaSprite('UI_Health_CENTER', ui..'health_Bar', ui_x, ui_y+1)
    screenCenter('UI_Health_CENTER', 'x')
    setObjectCamera('UI_Health_CENTER', 'camHUD')
    addLuaSprite('UI_Health_CENTER')

    setProperty('UI_Health_CENTER._frame.frame.width',1)
    setProperty('UI_Health_CENTER.alpha',0)

    makeLuaSprite('UI_Health_LEFT', ui..'health_Bar', ui_x, ui_y+1)
    screenCenter('UI_Health_LEFT', 'x')
    setObjectCamera('UI_Health_LEFT', 'camHUD')
    addLuaSprite('UI_Health_LEFT')

    makeLuaSprite('UI_Health_Frame', ui..'health_border', ui_x, ui_y)
    screenCenter('UI_Health_Frame', 'x')
    setObjectCamera('UI_Health_Frame', 'camHUD')
    addLuaSprite('UI_Health_Frame')

---------
    local meta = ''
    local original = ''
    local arrange = ''
    local charted = ''

    if week == 'Camellia' then
        local json = dofile('mods/'..currentModDirectory..'/scripts/JSONLIB.lua')
        local jsonTable = json.parse(getTextFromFile('data/'..songPath..'/meta.json'))
        arrange = jsonTable.artist
        charted = ''
    elseif week:find('HoloFunk') then
        meta = getTextFromFile('data/'..songPath..'/meta.txt')
        original, arrange, charted = meta:match("Original:(.-)\nArrange:(.-)\nChart:(.-)$")
    end

    local y = (screenHeight)
    local textSize = 18
    if original:find('none') then
    else
        makeLuaText('UI_Original_Text', 'Original: '..original, 1280, 5, y-100)
        setTextAlignment('UI_Original_Text','left')
        setTextFont('UI_Original_Text', fontName)
        setTextSize('UI_Original_Text', textSize)
        setTextBorder('UI_Original_Text',1,'000000')
        addLuaText('UI_Original_Text')
    end
    makeLuaText('UI_Arrange_Text', arrange, 1280, 5, y-78)
    setTextAlignment('UI_Arrange_Text','left')
    setTextFont('UI_Arrange_Text', fontName)
    setTextSize('UI_Arrange_Text', textSize)
    setTextBorder('UI_Arrange_Text',1,'000000')
    addLuaText('UI_Arrange_Text')
    
    if charted == '' then
    else
        makeLuaText('UI_Chart_Text', 'Charted by: '..charted, 1280, 5, y-55)
        setTextAlignment('UI_Chart_Text','left')
        setTextFont('UI_Chart_Text', fontName)
        setTextSize('UI_Chart_Text', textSize)
        setTextBorder('UI_Chart_Text',1,'000000')
        addLuaText('UI_Chart_Text')
    end

    makeLuaText('UI_Song_Text', songName..' - '..difficultyName, 1280, 5, y-30)
    setTextAlignment('UI_Song_Text','left')
    setTextFont('UI_Song_Text', fontName)
    setTextSize('UI_Song_Text', textSize)
    setTextBorder('UI_Song_Text',1,'000000')
    addLuaText('UI_Song_Text')
-------

    makeLuaSprite('UI_Score_Box', ui..'score_box', ui_x, ui_y + 45)
    screenCenter('UI_Score_Box', 'x')
    setObjectCamera('UI_Score_Box', 'camHUD')
    addLuaSprite('UI_Score_Box')
---
    local boxX, boxY = getProperty('UI_Score_Box.x'), getProperty('UI_Score_Box.y')
    local textSize = 20
    makeLuaText('UI_Score_Text', 'SCORE', 0, boxX + 25, boxY + 10)
    setTextFont('UI_Score_Text', fontName)
    setTextSize('UI_Score_Text', textSize)
    setTextBorder('UI_Score_Text',0,'000000')
    addLuaText('UI_Score_Text')

    makeLuaText('UI_Accuracy_Text', 'ACCURACY', 0, boxX + 230, boxY + 10)
    setTextFont('UI_Accuracy_Text', fontName)
    setTextSize('UI_Accuracy_Text', textSize)
    setTextBorder('UI_Accuracy_Text',0,'000000')
    addLuaText('UI_Accuracy_Text')

    makeLuaText('UI_Breaks_Text', 'BREAKS', 0, boxX + 460, boxY + 10)
    setTextFont('UI_Breaks_Text', fontName)
    setTextSize('UI_Breaks_Text', textSize)
    setTextBorder('UI_Breaks_Text',0,'000000')
    addLuaText('UI_Breaks_Text')

    makeLuaText('UI_Rank_Text', 'RANK', 0, boxX + 600, boxY + 10)
    setTextFont('UI_Rank_Text', fontName)
    setTextSize('UI_Rank_Text', textSize)
    setTextBorder('UI_Rank_Text',0,'000000')
    addLuaText('UI_Rank_Text')
--
    local textSize = 27
    makeLuaText('UI_Score_Txt', '0', 1280, boxX - 1050, boxY + 3)
    setTextAlignment('UI_Score_Txt', 'right')
    setTextFont('UI_Score_Txt', fontName)
    setTextSize('UI_Score_Txt', textSize)
    setTextBorder('UI_Score_Txt',0,'000000')
    addLuaText('UI_Score_Txt')

    makeLuaText('UI_Accuracy_Txt', '100%', 1280, boxX - 818, boxY + 3)
    setTextAlignment('UI_Accuracy_Txt', 'right')
    setTextFont('UI_Accuracy_Txt', fontName)
    setTextSize('UI_Accuracy_Txt', textSize)
    setTextBorder('UI_Accuracy_Txt',0,'000000')
    addLuaText('UI_Accuracy_Txt')

    makeLuaText('UI_Breaks_Txt', '0', 1280, boxX - 680, boxY + 3)
    setTextAlignment('UI_Breaks_Txt', 'right')
    setTextFont('UI_Breaks_Txt', fontName)
    setTextSize('UI_Breaks_Txt', textSize)
    setTextBorder('UI_Breaks_Txt',0,'000000')
    addLuaText('UI_Breaks_Txt')

    makeLuaText('UI_Rank_Txt', 'Clear', 1280, boxX + 45, boxY + 3)
    setTextFont('UI_Rank_Txt', fontName)
    setTextSize('UI_Rank_Txt', textSize)
    setTextBorder('UI_Rank_Txt',0,'000000')
    scaleObject('UI_Rank_Txt',0.75,1,false)
    addLuaText('UI_Rank_Txt')
end
function checkCharacter()
    setProperty('UI_Health_LEFT.color', getIconColor('dad'))
    setProperty('UI_Health_RIGHT.color', getIconColor('boyfriend'))
    
    if week == 'Camellia' then
        setProperty('ratingsData[0].image', 'ui/judgements-camellia/sick')
        setProperty('ratingsData[1].image', 'ui/judgements-camellia/good')
        setProperty('ratingsData[2].image', 'ui/judgements-camellia/bad')
        setProperty('ratingsData[3].image', 'ui/judgements-camellia/shit')
    else
        setProperty('ratingsData[0].image', 'ui/judgements-holofunk/sick')
        setProperty('ratingsData[1].image', 'ui/judgements-holofunk/good')
        setProperty('ratingsData[2].image', 'ui/judgements-holofunk/bad')
        setProperty('ratingsData[3].image', 'ui/judgements-holofunk/shit')
    end
    
    local texStrumsOP
    local texStrumsPL
    if week == 'Camellia' or week:find('HoloFunk') then
        if boyfriendName == 'bf' or boyfriendName == 'vigilante' then
            texStrumsPL = 'NOTE_assets'
            texSplashPL = 'noteSplashes'
        else
            texStrumsPL = 'notes/HOLONOTE_assets'
            texSplashPL = 'splashes/holoSplash'
        end
        if dadName == 'bobmellia' then
            texStrumsOP = 'NOTE_assets'
            texSplashOP = 'splashes/camelliaSplash'
        elseif dadName == 'camellia' then
            texStrumsOP = 'notes/Stepmania'
            texSplashOP = 'splashes/camelliaSplash'
        else
            texSplashOP = 'splashes/holoSplash'
            texStrumsOP = 'notes/HOLONOTE_assets'
        end
    else
        disableSkin = true
    end
    for i = 0,3 do
        if not disableSkin then
        setPropertyFromGroup('playerStrums', i, 'texture', texStrumsPL)
        setPropertyFromGroup('opponentStrums', i, 'texture', texStrumsOP)
        end
    end
    for i = 0,getProperty('unspawnNotes.length') - 1 do
        local nt = getPropertyFromGroup('unspawnNotes', i, 'noteType')
        local mp = getPropertyFromGroup('unspawnNotes', i, 'mustPress')
        local sus = getPropertyFromGroup('unspawnNotes', i, 'isSustainNote')
        if not disableSkin then
            if mp then
                setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', texSplashPL)
            else
                setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', texSplashOP)
            end
        end
        if dadName:find('camellia') then
            holdDisable = true
            if not mp and sus then
                setPropertyFromGroup('unspawnNotes' ,i, 'noAnimation', true)
            end
        else
            holdDisable = true
            if not mp and sus then
                setPropertyFromGroup('unspawnNotes' ,i, 'noAnimation', false)
            end
        end
    end
    savedOPTex = texStrumsOP
    savedPLTex = texStrumsPL
    savedSplashOPTex = texSplashOP
    savedSplashPLTex = texSplashPL
end
function changeHealthOffset(x)
    healthOffset = healthOffset + x
end
curPul = 0
function pulse(col)
    curPul = curPul + 1
    if curPul > 30 then
        curPul = 1
    end
    local tag = 'UI_Health_Frame_PULSE'..curPul
    makeLuaSprite(tag, ui..'health_border_pulse', 0, (downscroll and 57 or 692))
    screenCenter(tag, 'x')
    setObjectCamera(tag, 'camHUD')
    setObjectOrder(tag,getObjectOrder('UI_Health_Frame')-1)
    setProperty(tag..'.color',getColorFromHex(col))
    addLuaSprite(tag)
    doTweenX('UI_HealthPULSE_SCALEX'..curPul,tag..'.scale',1.2,1,'quartOut')
    doTweenAlpha('UI_HealthPULSE_ALPHA'..curPul,tag,0,1,'quartOut')
end

--library
function math.lerp(a, b, t)
	return a + t * (b - a);
end
function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end
function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)  
end
function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end