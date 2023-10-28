--!strict
local Types = require(script.Parent.Types)

local RunService = game:GetService("RunService")

local ClientFunction = require(script.Client)
local ServerFunction = require(script.Server)

local Function = {}

function Function.new<R, T...>(name): Types.Function<R, T...>
    if RunService:IsServer() then
        return ServerFunction.new(name)
    end

    if RunService:IsClient() then
        return ClientFunction.new(name)
    end

    error("Invalid calling runtime, Function.new can only be called on the server or client")
end

return Function