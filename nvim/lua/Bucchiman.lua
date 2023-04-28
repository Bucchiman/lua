local Bucchiman = {}

Bucchiman.new = function()
    local self = setmetatable({}, {__index = Bucchiman})
    self.images = {}
    self.default_options = {
        wait_ms = 100,
        direction = "expand",
        count = 3,
    }
    return self
end

function Bucchiman:setup()
end
