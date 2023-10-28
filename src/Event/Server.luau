--!strict
local Players = game:GetService("Players")

local Types = require(script.Parent.Parent.Types)

local Child = require(script.Parent.Parent.Child)
local Constants = require(script.Parent.Parent.Constants)

local ServerEvent = {}
ServerEvent.__index = ServerEvent

function ServerEvent.new<T...>(name: string): Types.ServerEvent<T...>
    local self = setmetatable({}, ServerEvent)
    self._name = name
    
    local remotesFolder = Child(workspace, Constants.RemoteFolderName, function()
        return Instance.new("Folder")
    end)

    local remoteEvent = Child(remotesFolder, name, function()
        return Instance.new("RemoteEvent")
    end)

    self._remoteEvent = remoteEvent

    return (self :: any) :: Types.ServerEvent<T...>
end

function ServerEvent.Name<T...>(self: Types.ServerEvent<T...>)
    return self._name
end

function ServerEvent.Fire<T...>(self: Types.ServerEvent<T...>, player: Player, ...: T...)
    self._remoteEvent:FireClient(player, ...)
end

function ServerEvent.FireExcept<T...>(self: Types.ServerEvent<T...>, player: Player, ...: T...)
    for _, otherPlayer in Players:GetPlayers() do
        if otherPlayer ~= player then
            self._remoteEvent:FireClient(otherPlayer, ...)
        end
    end
end

function ServerEvent.FireAll<T...>(self: Types.ServerEvent<T...>, ...: T...)
    for _, player in Players:GetPlayers() do
        self._remoteEvent:FireClient(player, ...)
    end
end

return ServerEvent