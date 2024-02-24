--!strict
--!native

local RunService = game:GetService("RunService")

local function GetInstance(parent: Instance, name: string, type: string, timeout: number?): Instance
    if RunService:IsServer() then
        local instance: Instance? = parent:FindFirstChild(name)

        if not instance then
            instance = Instance.new(type)

            if not instance then
                error("Failed to create an instance of type '{type}'.")
            end

            instance.Parent = parent
            instance.Name = name
        end

        if not instance then
            error("Failed to create or find an instance called '{name}'.")
        end

        if not instance:IsA(type) then
            error(`Expected instance of type '{type}' but found an instance of type {instance.ClassName}.`)
        end

        return instance
    end

    if RunService:IsClient() then
        local instance = if timeout then parent:WaitForChild(name, timeout) else parent:WaitForChild(name)

        if not instance then
            error(`Did not find an instance called '{name}'.`)
        end

        if not instance:IsA(type) then
            error(`Expected instance of type '{type}' but found an instance of type {instance.ClassName}.`)
        end

        return instance
    end

    error("Invalid calling runtime, GetInstance can only be called on the server or client")
end

local function Folder(parent: Instance, name: string): Folder
    return GetInstance(parent, name, "Folder") :: Folder
end

local MainFolder = Folder(workspace, "__NET__REMOTES")

local Folders = {
    Event = Folder(MainFolder, "Event"),
    Function = Folder(MainFolder, "Function"),
    Value = Folder(MainFolder, "Value"),
}

export type EventObjectKind = "Event" | "Value"

local function RemoteEvent(kind: EventObjectKind, name: string): RemoteEvent
    return GetInstance(Folders[kind], name, "RemoteEvent") :: RemoteEvent
end

local function RemoteFunction(name: string): RemoteFunction
    return GetInstance(Folders.Function, name, "RemoteFunction") :: RemoteFunction
end

local Instances = {
    RemoteEvent = RemoteEvent,
    RemoteFunction = RemoteFunction,
}

return Instances