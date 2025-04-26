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

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("I must crouch",true)
wait(0.5)
local enableDamage = true
local eyes = game:GetObjects("rbxassetid://125171553498127")[1]
local hum = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
local humanoidRootPart = hum.Parent:FindFirstChild("HumanoidRootPart")
local Crouch = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.Healthbar.Effects.Crouching
local lastPosition = humanoidRootPart.lastPosition
local currentLoadedRoom = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
local num = math.floor(#currentLoadedRoom.Nodes:GetChildren() / 2)
eyes.CFrame = (num == 0 and currentLoadedRoom.Base or currentLoadedRoom.Nodes[num]).CFrame + Vector3.new(0, 10, 0)
eyes.Parent = workspace

ModuleEvents = require(game:GetService("ReplicatedStorage").ClientModules.Module_Events)
ModuleEvents.shatter(workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value])

game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Connect(function()
    if eyes.Parent then
        eyes:Destroy()
    end
    enableDamage = false
end)

while true and enableDamage do
    if not game.Workspace:FindFirstChild("Silence") then break end
    local currentPosition = humanoidRootPart.Position
    local isMoving = (currentPosition - lastPosition).Magnitude > 0.1

    if not Crouch.Visible and isMoving then
        hum.Health -= 5
        if hum.Health <= 0 then
            game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Silence"
            firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                "You died to Silence",
                "You should keep quiet",
                "It needs quiet"
            }, "Blue")
        end
    end

    lastPosition = currentPosition
    task.wait(1)
end
