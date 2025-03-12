local banned = {}

local function csauJokerCheck(k)
    if not containsKey(banned, k) then
        if starts_with(k, "j_") then
            if not starts_with(k, "j_csau_") then
                banned[#banned+1] = { id = k }
            end
        end
    end
end

function csau_tucker_addBanned()
    for k, v in pairs(G.P_CENTERS) do
        csauJokerCheck(k)
    end
    for k, v in pairs(SMODS.Centers) do
        csauJokerCheck(k)
    end
end

local chalInfo = {
    rules = {
        custom = {
            {id = "csau_tucker" }
        }
    },
    restrictions = {
        banned_cards = banned,
    },
    unlocked = function(self)
        for k, v in pairs(SMODS.Achievements) do
            if k == 'ach_csau_win_vine'  then
                return v.earned
            end
        end
    end
}

return chalInfo