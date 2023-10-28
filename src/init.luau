local Types = require(script.Types)

export type Function<R, T...> = Types.Function<R, T...>
export type Event<T...> = Types.Event<T...>

local Function = require(script.Function)
local Event = require(script.Event)

local Net = {}

-- Create a new shared remote function
function Net.Function<R, T...>(name: string): Types.Function<R, T...>
    return (Function.new(name) :: any) :: Types.Function<R, T...>
end

-- Create a new shared remote event
function Net.Event<T...>(name: string): Types.Event<T...>
    return (Event.new(name) :: any) :: Types.Event<T...>
end

return Net