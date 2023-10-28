--!strict
local Types = require(script.Parent.Types)

local RunService = game:GetService("RunService")

local ClientEvent = require(script.Client)
local ServerEvent = require(script.Server)

local Event = {}

function Event.new<T...>(name): Types.Event<T...>
    if RunService:IsClient() then
        return ClientEvent.new(name)
    end

    -- Why is this not type-correct?
    if RunService:IsServer() then
        return (ServerEvent.new(name) :: any) :: Types.Event<T...>
    end

    error("Invalid calling runtime, Event.new can only be called on the server or client")
end

return Event