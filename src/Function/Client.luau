--!strict
local Types = require(script.Parent.Parent.Types)

local Promise = require(script.Parent.Parent.Parent.Promise)

local Constants = require(script.Parent.Parent.Constants)

local ClientFunction = {}
ClientFunction.__index = ClientFunction

function ClientFunction.new<R, T...>(name: string): Types.ClientFunction<R, T...>
    local self = setmetatable({}, ClientFunction)
    self._name = name
    
    -- Wait for the server to create the remotes folder
    local remotes = workspace:WaitForChild(Constants.RemoteFolderName)

    -- Wait for the server to create the remote event
    self._remoteFunction = remotes:WaitForChild(name)
    
    return (self :: any) :: Types.ClientFunction<R, T...>
end

function ClientFunction.Name<R, T...>(self: Types.ClientFunction<R, T...>)
    return self._name
end

function ClientFunction.Invoke<R, T...>(self: Types.ClientFunction<R, T...>, ...: T...): Types.Promise<R>
    return Promise.try(function(...)
        return self._remoteFunction:InvokeServer(...)
    end, ...)
end

return ClientFunction