core = loadstring(game:HttpGet('https://raw.githubusercontent.com/LostThisGame/Roblox/main/SandboxHatchersXv2.lua'))()
local Collectables = workspace.CollectablesFolder
local Collectables2 = workspace.CollectablesFolderW2
local Collectables3 = workspace.CollectablesFolderW3
while true do
    task.wait(.5)
    for i, v in next, Collectables:GetChildren() do
        if v.Name == 'Coin' and v.Transparency ~= 1 then
            core:gPlayer().Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
            task.wait()
            firetouchinterest(core:gPlayer().Character.HumanoidRootPart, v, 0)
            firetouchinterest(core:gPlayer().Character.HumanoidRootPart, v, 1)
        end
    end
    for i, v in next, Collectables2:GetChildren() do
        if v.Name == 'Coin' and v.Transparency ~= 1 then
            core:gPlayer().Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
            task.wait()
            firetouchinterest(core:gPlayer().Character.HumanoidRootPart, v, 0)
            firetouchinterest(core:gPlayer().Character.HumanoidRootPart, v, 1)
        end
    end
    for i, v in next, Collectables3:GetChildren() do
        if v.Name == 'Coin' and v.Transparency ~= 1 then
            core:gPlayer().Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
            task.wait()
            firetouchinterest(core:gPlayer().Character.HumanoidRootPart, v, 0)
            firetouchinterest(core:gPlayer().Character.HumanoidRootPart, v, 1)
        end
    end
end
