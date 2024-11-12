function Card:vic_add_speech_bubble(text_key, align, loc_vars, extra)
    if self.children.speech_bubble then self.children.speech_bubble:remove() end
    self.config.speech_bubble_align = {align=align or 'bm', offset = {x=0,y=0},parent = self}
    self.children.speech_bubble = 
    UIBox{
        definition = G.UIDEF.vic_speech_bubble(text_key, loc_vars, extra),
        config = self.config.speech_bubble_align
    }
    self.children.speech_bubble:set_role{
        role_type = 'Minor',
        xy_bond = 'Weak',
        r_bond = 'Strong',
        major = self,
    }
    self.children.speech_bubble.states.visible = false
end

function Card:vic_remove_speech_bubble()
    if self.children.speech_bubble then self.children.speech_bubble:remove(); self.children.speech_bubble = nil end
end

function Card:vic_say_stuff(n, not_first, def_speed, voice, playVoice)
    voice = voice or nil
    playVoice = playVoice or 1
    local speed, delayMult = 1, 1
    if not def_speed then
        speed = G.SPEEDFACTOR
    else
        delayMult = G.SPEEDFACTOR
    end
    self.talking = true
    if not not_first then 
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1*delayMult,
            func = function()
                if self.children.speech_bubble then self.children.speech_bubble.states.visible = true end
                self:vic_say_stuff(n, true, def_speed, voice, playVoice)
              return true
            end
        }))
    else
        if n <= 0 then self.talking = false; return end
        local new_said = math.random(1, 11)
        while new_said == self.last_said do 
            new_said = math.random(1, 11)
        end
        self.last_said = new_said
        if not voice then
            play_sound('voice'..math.random(1, 11), speed*(math.random()*0.2+1), 0.5)
        else
            if playVoice == 1 then
                voice:play(1, (G.SETTINGS.SOUND.volume/100.0) * (G.SETTINGS.SOUND.game_sounds_volume/50.0),true);
                playVoice = 2
            end
        end

        self:juice_up()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            blockable = false, blocking = false,
            delay = 0.13*delayMult,
            func = function()
                self:vic_say_stuff(n-1, true, def_speed, voice, playVoice)
            return true
            end
        }), 'tutorial')
    end
end