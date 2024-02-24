--!strict
--!native

local RunService = game:GetService("RunService")

local Library = script.Parent

local Types = require(Library.Types)

type Event<T...> = Types.Event<T...>

local ClientEvent = require(script.Client)
local ServerEvent = require(script.Server)

local function Event<T...>(name): Event<T...>
    if RunService:IsClient() then
        return ClientEvent(name)
    end

    if RunService:IsServer() then
        return ServerEvent(name)
    end

    error("Invalid calling runtime, Event.new can only be called on the server or client")
end

return Event