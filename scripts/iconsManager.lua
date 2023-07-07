
dad = {
    {20, 100}, --frame 0
    {0, 20}, --frame 1
    {20, 0}
}
bf = {
    {20, 0}, --frame 0
    {0, 20}, --frame 1
    {100, 20}
}
function onCreatePost()
    loadIcon()
end
function onUpdatePost()
    local icons = {'iconP1', 'iconP2'}
    for i=1, #icons do
        local icon = icons[i]
        setProperty(icon..'.offset.x', 0)
        setProperty(icon..'.offset.y', 0)
    end
    local hp = getProperty('healthBar.percent')
    if hp < 20 then
        setProperty('iconP2.animation.curAnim.curFrame', 2)
        setProperty('iconP1.animation.curAnim.curFrame', 1)
    elseif hp > 80 then
        setProperty('iconP2.animation.curAnim.curFrame', 1)
        setProperty('iconP1.animation.curAnim.curFrame', 2)
    else
        setProperty('iconP2.animation.curAnim.curFrame', 0)
        setProperty('iconP1.animation.curAnim.curFrame', 0)
    end
end
function onEvent(n)
    if n == 'Change Character' then
        loadIcon()
    end
end
function loadIcon()
    loadGraphic('iconP1','icons/'..getProperty('boyfriend.healthIcon'), 150)
    addAnimation('iconP1', 'main', {0, 1, 2}, 0, true)

    loadGraphic('iconP2','icons/'..getProperty('dad.healthIcon'), 150)
    addAnimation('iconP2', 'main', {0, 1, 2}, 0, true)
end