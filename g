game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LatestRoom = ReplicatedStorage.GameData.LatestRoom.Value
local Rooms = Workspace.CurrentRooms:FindFirstChild(tostring(LatestRoom)) 
local OGNodes = Rooms:FindFirstChild("PathfindNodes")
if OGNodes then
    local NewNodes = OGNodes:Clone()
    NewNodes.Parent = Rooms
    NewNodes.Name = "Nodes"
end

local currentLoadedRoom = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
local eyes = game:GetObjects("rbxassetid://108058013422462")[1]

local num = math.floor(#currentLoadedRoom.Nodes:GetChildren() / 2)
eyes.CFrame = (num == 0 and currentLoadedRoom.Base or currentLoadedRoom.Nodes[num]).CFrame + Vector3.new(0, 3, 0)
eyes.Parent = workspace

local Close = eyes.Attachment.Close  
local Open = eyes.Attachment.Open    
local Change = eyes.Change           

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hum = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- 伤害系统
local lastPosition = humanoidRootPart.Position
local lastDamageTime = 0
local isCounting = false
local damageAmount = 10

local function onHeartbeat()
    if Open.Enabled then
        local currentTime = tick()
        local currentPosition = humanoidRootPart.Position
        local isMoving = (currentPosition - lastPosition).Magnitude > 0.1
        
        if isMoving then
            if not isCounting then
                -- 第一次移动立即伤害
                hum.Health = hum.Health - damageAmount
                lastDamageTime = currentTime
                isCounting = true
            elseif currentTime - lastDamageTime >= 1 then
                -- 1秒后还在移动则再次伤害
                hum.Health = hum.Health - damageAmount
                lastDamageTime = currentTime
            end
            
            -- 死亡检查
            if hum.Health <= 0 then
                game:GetService("ReplicatedStorage").GameStats["Player_"..player.Name].Total.DeathCause.Value = "Blink"
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to Blink",
                    "Don't move with his eyes open!",
                    "Try again"
                }, "Blue")
            end
        else
            isCounting = false -- 重置计数
        end
        
        lastPosition = currentPosition
    end
end

-- 启动心跳检测
local blinkConnection = game:GetService("RunService").Heartbeat:Connect(onHeartbeat)

-- 眼睛开闭动画循环
coroutine.wrap(function()
    wait(2) -- 初始延迟
    while true do
        if not eyes.Parent then break end 
        Close.Enabled = true
        Open.Enabled = false
        Change:Play()
        wait(7) -- 眼睛闭合时间

        if not eyes.Parent then break end 
        Close.Enabled = false
        Open.Enabled = true
        Change:Play()
        wait(7) -- 眼睛睁开时间
    end
end)()

-- 房间切换时清理
game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Connect(function()
    if eyes.Parent then
        eyes:Destroy()
    end
    if blinkConnection then
        blinkConnection:Disconnect()
    end
end)
