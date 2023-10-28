local function Child<T>(parent: Instance, name: string, callback: () -> T): T
    local instance = parent:FindFirstChild(name)

    if not instance then
        instance = callback()
        instance.Name = name
        instance.Parent = parent
    end

    return instance :: T
end

return Child