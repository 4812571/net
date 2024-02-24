--!strict
--!native

local Types = require(script.Types)

export type Function<R, T...> = Types.Function<R, T...>
export type Event<T...> = Types.Event<T...>
export type Value<T> = Types.Value<T>

local Function = require(script.Function)
local Event = require(script.Event)
local Value = require(script.Value)

local Net = {
    Function = Function,
    Event = Event,
    Value = Value,
}

return Net