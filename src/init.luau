--!strict

local Types = require(script.Types)

export type Function<R, T...> = Types.Function<R, T...>
export type Event<T...> = Types.Event<T...>

local Function = require(script.Function)
local Event = require(script.Event)

local Net = {
    Function = Function,
    Event = Event,
}

return Net