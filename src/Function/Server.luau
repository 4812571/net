--!strict
local Types = require(script.Parent.Parent.Types)

local Child = require(script.Parent.Parent.Child)
local Constants = require(script.Parent.Parent.Constants)

local ServerFunction = {}
ServerFunction.__index = ServerFunction

function ServerFunction.new<R, T...>(name: string): Types.ServerFunction<R, T...>
    local self = setmetatable({}, ServerFunction)
    self._name = name

    local remotesFolder = Child(workspace, Constants.RemoteFolderName, function()
        return Instance.new("Folder")
    end)

    local remoteFunction = Child(remotesFolder, name, function()
        return Instance.new("RemoteFunction")
    end)

    self._remoteFunction = remoteFunction

    return (self :: any) :: Types.ServerFunction<R, T...>
end

function ServerFunction.Name<R, T...>(self: Types.ServerFunction<R, T...>)
    return self._name
end

function ServerFunction.Handle<R, T...>(self: Types.ServerFunction<R, T...>, handler: Types.Handler<R, T...>)
    self._remoteFunction.OnServerInvoke = handler
end

return ServerFunction