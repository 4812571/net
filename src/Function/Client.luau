--!strict
--!native

local Library = script.Parent.Parent

local Types = require(Library.Types)

type Function<T, V...> = Types.Function<T, V...>
type Cleanup = Types.Cleanup
type Handler<T, V...> = Types.Handler<T, V...>

local Instances = require(Library.Instances)

local function Handle<T, V...>(self: Function<T, V...>, callback: Handler<T, V...>): Cleanup
    error(`Attempt to call :Handle on a client-side function.`)
end

local function Invoke<T, V...>(self: Function<T, V...>, ...: V...): T
    return self.RemoteFunction:InvokeServer(...)
end

local function ClientFunction<R, A...>(name: string): Function<R, A...>
    local remote = Instances.RemoteFunction(name)

    local clientFunction = {
        Name = name,
        RemoteFunction = remote,
        Invoke = Invoke,
        Handle = Handle,
    }

    return (clientFunction :: any) :: Function<R, A...>
end

return ClientFunction