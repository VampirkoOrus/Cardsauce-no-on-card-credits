local tagInfo = {
    name = 'Spirit Tag',
    config = {type = 'immediate'},
    alerted = true,
    part = 'jojo',
}

tagInfo.apply = function(self, tag, context)
    if context.type == self.config.type then
        tag:yep('+', G.C.STAND,function()
            G.FUNCS.new_stand(false)
            return true
        end)
        tag.triggered = true
        return true
    end
end


return tagInfo