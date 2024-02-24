--!strict
--!native

local Library = script.Parent.Parent

local Types = require(Library.Types)

type Event<T...> = Types.Event<T...>
type Callback<T...> = Types.Callback<T...>
type Cleanup = Types.Cleanup

local Instances = require(Library.Instances)

local function Connect<T...>(self: Event<T...>, callback: Callback<T...>): Cleanup
    local connection = self.RemoteEvent.OnClientEvent:Connect(callback)

    return function()
        connection:Disconnect()
    end
end

local function Once<T...>(self: Event<T...>, callback: Callback<T...>): Cleanup
    local connection = self.RemoteEvent.OnClientEvent:Once(callback)

    return function()
        connection:Disconnect()
    end
end

local function Fire<T...>(self: Event<T...>, ...: T...)
    error(`Attempt to call :Fire on a client-side event.`)
end

local function FireAll<T...>(self: Event<T...>, ...: T...)
    error(`Attempt to call :FireAll on a client-side event.`)
end

local function FireExcept<T...>(self: Event<T...>, ...: T...)
    error(`Attempt to call :FireExcept on a client-side event.`)
end

local function ClientEvent<T...>(name: string): Event<T...>
    local remote = Instances.RemoteEvent("Event", name)

    if not remote then
        error(`Remote '{name}' does not exist.`)
    end

    if not remote:IsA("RemoteEvent") then
        error(`Expected '{name}' to be a RemoteEvent, was a {remote.ClassName}.`)
    end

    local clientEvent = {
        Name = name,
        RemoteEvent = remote,
        Connect = Connect,
        Once = Once,
        Fire = Fire,
        FireAll = FireAll,
        FireExcept = FireExcept,
    }

    return clientEvent
end

return ClientEvent