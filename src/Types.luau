-- Note: better types for promise cannot exist until luau supports them.
export type Promise<T...> = {
    [any]: any
}

export type CleanupFn = () -> ()
export type Handler<R, T...> = (Player, T...) -> R
export type Callback<T...> = (T...) -> ()

type SharedFunctionTrait = {
    _name: string,
    _remoteFunction: RemoteFunction,
    Name: (SharedFunctionTrait) -> string,
}

type ServerFunctionTrait<R, T...> = {
    Handle: (ServerFunctionTrait<R, T...>, Handler<R, T...>) -> (),
}

type ClientFunctionTrait<R, T...> = {
    Invoke: (ClientFunctionTrait<R, T...>, T...) -> Promise<R>,
}

type SharedEventTrait = {
    _name: string,
    _remoteEvent: RemoteEvent,
    Name: (SharedEventTrait) -> string,
}

type ServerEventTrait<T...> = {
    Fire: (ServerEventTrait<T...>, Player, T...) -> (),
    FireExcept: (ServerEventTrait<T...>, Player, T...) -> (),
    FireAll: (ServerEventTrait<T...>, T...) -> (),
}

type ClientEventTrait<T...> = {
    Connect: (ClientEventTrait<T...>, (T...) -> ()) -> CleanupFn,
    Once: (ClientEventTrait<T...>, (T...) -> ()) -> CleanupFn,
}

export type ServerFunction<R, T...> = ServerFunctionTrait<R, T...> & SharedFunctionTrait
export type ClientFunction<R, T...> = ClientFunctionTrait<R, T...> & SharedFunctionTrait
export type Function<R, T...> = ServerFunction<R, T...> | ClientFunction<R, T...>

export type ServerEvent<T...> = ServerEventTrait<T...> & SharedEventTrait
export type ClientEvent<T...> = ClientEventTrait<T...> & SharedEventTrait
export type Event<T...> = ServerEvent<T...> | ClientEvent<T...>

return nil