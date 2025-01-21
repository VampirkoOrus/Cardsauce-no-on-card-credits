local tagInfo = {
    name = 'Spirit Tag',
    config = {type = 'immediate'},
    alerted = true,
}

tagInfo.apply = function(self, tag, context)
    if context.type == self.config.type then
        tag:yep('+', G.C.STAND,function()
            new_stand()
            return true
        end)
        tag.triggered = true
        return true
    end
end


return tagInfo