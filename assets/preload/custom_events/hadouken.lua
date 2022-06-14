local canDodge = false;
local ismugman = false;

function onCreate()
    makeAnimatedLuaSprite('Hadokeninvisible', 'bull/CupheadHadoken', getProperty('dad.x') - 400, getProperty('dad.y'));
    addAnimationByPrefix('Hadokeninvisible', 'burstfx', 'Hadolen instance 1', 25, true);
    objectPlayAnimation('Hadokeninvisible', 'burstfx');
    addLuaSprite('Hadokeninvisible', true); 
    setProperty('Hadokeninvisible.alpha', 0)
end

function onEvent(n,v1,v2)
    if n == 'hadouken' then
        ismugman = v1 == "true"
        setProperty('dad.specialAnim', true);
        characterPlayAnim('dad', 'hadoken', true);
        runTimer('doevent', 0.6, 1)
        canDodge = true;
        Dodged = false
        -- runTimer('goback', 0.5, 1)
    end
end


function onTimerCompleted(t, l, ll) 
    if t == 'doevent' then
        makeAnimatedLuaSprite('Hadoken', 'bull/CupheadHadoken', getProperty('dad.x') - 400, getProperty('dad.y') - 150);
        addAnimationByPrefix('Hadoken', 'burstfx', 'Hadolen instance 1', 25, true);
        addAnimationByPrefix('Hadoken', 'burstfxreal', 'BurstFX instance 1', 25, false);
        objectPlayAnimation('Hadoken', 'burstfx');
        addLuaSprite('Hadoken', true); 
        scaleObject('Hadoken', 4, 4)
        setProperty('Hadokeninvisible.x', getProperty('dad.x') - 400)
        if not ismugman then
        doTweenX('weeeee1', 'Hadoken', getProperty('boyfriend.x') + 800, 1.3, 'sineInOut')
        else
            doTweenX('weeeee1', 'Hadoken', getProperty('boyfriend.x') + 500, 0.6, 'sineInOut')
        end
        doTweenX('weeeee2', 'Hadokeninvisible', getProperty('boyfriend.x') - 400, 0.4, 'sineInOut')
        runTimer('dodge', 0.4, 1)
        -- playSound('shoot', 1)
    end
    if t == 'dodge' then
        setProperty('boyfriend.specialAnim', true);
        characterPlayAnim('boyfriend', 'dodge', true);
    end
end

function onUpdate()
    if getProperty('Hadokeninvisible.x') == getProperty('boyfriend.x') - 400 then
      if not Dodged then
      if getProperty('cpuControlled') == false then
      setProperty('health', 0);
      end
      end
    --   characterPlayAnim('boyfriend', 'dodge', true);
      setProperty('Hadokeninvisible.x', getProperty('dad.x') - 1)
    --   runTimer('goback', 0.3, 1)
    end
    if getProperty('Hadoken.animation.curAnim.name') == 'burstfxreal' then
        if getProperty('Hadoken.animation.curAnim.finished') then
            removeLuaSprite('Hadoken', false)
        end
    end
    if canDodge == true and (getMouseX('camHUD') > 0 and getMouseX('camHUD') < 209) and (getMouseY('camHUD') > 506 and getMouseY('camHUD') < 1280 and mouseClicked('left')) then
   
        Dodged = true;
        
        -- removeLuaSprite('spacebar');
        canDodge = false

        objectPlayAnimation('dodgebutton', 'dodgeclick')
        
    end
end

function onTweenCompleted(t) 
   if t == 'weeeee1' then
    if not ismugman then
    removeLuaSprite('Hadoken', false)
    else
        setProperty('Hadoken.y', getProperty('Hadoken.y') - 500)
        objectPlayAnimation('Hadoken', 'burstfxreal');
        playSound('hurt', 0.6)
        objectPlayAnimation('mugman', 'familyguydeadpose')
    end
   end
--    if t == 'weeeee2' then
--     removeLuaSprite('Hadokeninvisible', false)
--    end

end
