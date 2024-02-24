--!strict
--!native

local Library = script.Parent

local Types = require(Library.Types)

type Value<T> = Types.Value<T>

local RunService = game:GetService("RunService")

local ClientValue = require(script.Client)
local ServerValue = require(script.Server)

local function Value<T>(name: string, value: T): Value<T>
    if RunService:IsServer() then
        return ServerValue(name, value) :: any
    end

    if RunService:IsClient() then
        return ClientValue(name, value) :: any
    end

    error("Invalid calling runtime, Value can only be called on the server or client")
end

return Value