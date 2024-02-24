--!strict
--!native

local Players = game:GetService("Players")

local Library = script.Parent.Parent

local Types = require(Library.Types)

type Event<T...> = Types.Event<T...>
type Callback<T...> = Types.Callback<T...>

local Instances = require(Library.Instances)

local function Connect<T...>(self: Event<T...>, callback: Callback<T...>)
    error("Attempt to call :Connect on a server-side event.")
end

local function Once<T...>(self: Event<T...>, callback: Callback<T...>)
    error("Attempt to call :Once on a server-side event.")
end

local function Fire<T...>(self: Event<T...>, player: Player, ...: T...)
    self.RemoteEvent:FireClient(player, ...)
end

local function FireExcept<T...>(self: Event<T...>, player: Player, ...: T...)
    for _, otherPlayer in Players:GetPlayers() do
        if otherPlayer == player then
            continue
        end

        self.RemoteEvent:FireClient(player, ...)
    end
end

local function FireAll<T...>(self: Event<T...>, ...: T...)
    self.RemoteEvent:FireAllClients(...)
end

local function ServerEvent<T...>(name: string): Event<T...>
    local remote = Instances.RemoteEvent("Event", name)

    local serverEvent = {
        Name = name,
        RemoteEvent = remote,
        Connect = Connect,
        Once = Once,
        Fire = Fire,
        FireAll = FireAll,
        FireExcept = FireExcept,
    }

    return (serverEvent :: any) :: Event<T...>
end

return ServerEvent