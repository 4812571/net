--!strict
local Library = script.Parent.Parent

local Types = require(Library.Types)

local Constants = require(script.Parent.Parent.Constants)

local ClientEvent = {}
ClientEvent.__index = ClientEvent

function ClientEvent.new<T...>(name: string): Types.ClientEvent<T...>
    local self = setmetatable({}, ClientEvent)
    self._name = name
    
    -- Wait for the server to create the remotes folder
    local remotes = workspace:WaitForChild(Constants.RemoteFolderName)

    -- Wait for the server to create the remote event
    self._remoteEvent = remotes:WaitForChild(name)
    
    return (self :: any) :: Types.ClientEvent<T...>
end

function ClientEvent.Name<T...>(self: Types.ClientEvent<T...>)
    return self._name
end

function ClientEvent.Connect<T...>(self: Types.ClientEvent<T...>, callback: (T...) -> ()): () -> ()
    local connection = self._remoteEvent.OnClientEvent:Connect(callback)

    return function()
        connection:Disconnect()
    end
end

function ClientEvent.Once<T...>(self: Types.ClientEvent<T...>, callback: (T...) -> ()): () -> ()
    local connection = self._remoteEvent.OnClientEvent:Once(callback)

    return function()
        connection:Disconnect()
    end
end

return ClientEvent