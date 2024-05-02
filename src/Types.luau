--!strict
--!native

local Libary = script.Parent
local Packages = Libary.Parent

local Signal = require(Packages.Signal)

type Signal<T...> = Signal.Signal<T...>

export type Cleanup = () -> ()
export type Handler<R, A...> = (player: Player, A...) -> R
export type Callback<T...> = (T...) -> ()

export type Event<T...> = {
    -- Shared
    Name: string,
    RemoteEvent: RemoteEvent,

    -- Client
    Connect: (self: Event<T...>, callback: Callback<T...>) -> Cleanup,
    Once: (self: Event<T...>, callback: Callback<T...>) -> Cleanup,

    -- Server
    Fire: (self: Event<T...>, player: Player, T...) -> (),
    FireExcept: (self: Event<T...>, player: Player, T...) -> (),
    FireAll: (self: Event<T...>, T...) -> (),
}

export type Function<R, A...> = {
    -- Shared
    Name: string,
    RemoteFunction: RemoteFunction,

    -- Server
    Handle: (self: Function<R, A...>, callback: Handler<R, A...>) -> Cleanup,

    -- Client
    Invoke: (self: Function<R, A...>, A...) -> any,
}

export type Value<T> = {
    -- Private
    _value: T,

    -- Shared
    Name: string,
    RemoteEvent: RemoteEvent,
    Get: (self: Value<T>) -> T,
    Observe: (self: Value<T>, callback: (T) -> Cleanup) -> Cleanup,
    Changed: Signal<T>,

    -- Server
    Set: (self: Value<T>, value: T) -> (),
}

return nil