--!strict
--!native

local Library = script.Parent.Parent
local Packages = Library.Parent

local Signal = require(Packages.Signal)
local Observe = require(Packages.Observe)

local Types = require(Library.Types)

type Cleanup = Types.Cleanup
type Value<T> = Types.Value<T>

local Instances = require(Library.Instances)

local function Set<T>(self: Value<T>, value: T)
    if self._value == value then
        return
    end

    self._value = value
    self.Changed:Fire(value)
    self.RemoteEvent:FireAllClients(value)
end

local function Get<T>(self: Value<T>): T
    return self._value
end

local function ObserveValue<T>(self: Value<T>, callback: (T) -> Cleanup): Cleanup
    return Observe.ChangedSignal(self._value, self.Changed :: any, callback)
end

local function ClientValue<T>(name: string, value: T): Value<T>
    local remote = Instances.RemoteEvent("Value", name)

    local clientValue = {
        _value = value,

        Name = name,
        RemoteEvent = remote,
        Get = Get,
        Observe = ObserveValue,
        Changed = Signal.new(),
        Set = Set,
    }

    return (clientValue :: any) :: Value<T>
end

return ClientValue