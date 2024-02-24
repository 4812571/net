--!strict
--!native

local Library = script.Parent

local Types = require(Library.Types)

type Function<R, A...> = Types.Function<R, A...>

local RunService = game:GetService("RunService")

local ClientFunction = require(script.Client)
local ServerFunction = require(script.Server)

local function Function<R, A...>(name): Function<R, A...>
    if RunService:IsServer() then
        return ServerFunction(name) :: any  
    end

    if RunService:IsClient() then
        return ClientFunction(name) :: any
    end

    error("Invalid calling runtime, Function.new can only be called on the server or client")
end

return Function