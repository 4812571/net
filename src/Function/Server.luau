--!strict
--!native

local Library = script.Parent.Parent

local Types = require(Library.Types)

type Function<R, A...> = Types.Function<R, A...>
type Handler<R, A...> = Types.Handler<R, A...>

local Instances = require(Library.Instances)

local function Handle<R, A...>(self: Function<R, A...>, handler: Handler<R, A...>)
    self.RemoteFunction.OnServerInvoke = handler
end

local function Invoke<R, A...>(self: Function<R, A...>): R
    error(`Attempt to call invoke from the server.`)
end

local function ServerFunction<R, A...>(name: string): Function<R, A...>
    local remoteFunction = Instances.RemoteFunction(name)

    local serverFunction = {
        Name = name,
        RemoteFunction = remoteFunction,
        Handle = Handle,
        Invoke = Invoke,
    }

    return (serverFunction :: any) :: Function<R, A...>
end

return ServerFunction