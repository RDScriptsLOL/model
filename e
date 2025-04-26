---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
    Entity = {
        Name = "Dimensional eye",
        Asset = "rbxassetid://108269161773810",
        HeightOffset = 0
    },
    Lights = {
        Flicker = {
            Enabled = false,
            Duration = 1
        },
        Shatter = true,
        Repair = false
    },
    Earthquake = {
        Enabled = false
    },
    CameraShake = {
        Enabled = true,
        Range = 100,
        Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
    },
    Movement = {
        Speed = 1,
        Delay = 99999,
        Reversed = true
    },
    Rebounding = {
        Enabled = false,
        Type = "Ambush", -- "Blitz"
        Min = 1,
        Max = 1,
        Delay = 2
    },
    Damage = {
        Enabled = false,
        Range = 40,
        Amount = 125
    },
    Crucifixion = {
        Enabled = false,
        Range = 40,
        Resist = false,
        Break = true
    },
    Death = {
        Type = "Guiding", -- "Curious"
        Hints = {"Death", "Hints", "Go", "Here"},
        Cause = ""
    }
})

---====== Run entity ======---
entity:Run()

local running = true

coroutine.wrap(function()
    local hum = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local eyeModel = game.Workspace:FindFirstChild("Dimensional eye")
    local eyes = eyeModel and eyeModel:FindFirstChild("Eye")
    
    while running and eyeModel and eyes do
        local camera = workspace.CurrentCamera
        local _, onScreen = camera:WorldToViewportPoint(eyes.Position)
        
        if onScreen then
            hum.Health -= 1  -- 每帧减少1点血量
            if hum.Health <= 0 then
                game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Dimensional Eye"
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to Dimensional Eye.",
                    "It will appear above the door",
                    "Don't look at it"
                }, "Blue")
            end
        end
        task.wait(0.01)
    end
end)()

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
coroutine.wrap(function()
local eyeModel = game.Workspace:FindFirstChild("Dimensional eye")
    wait(10)
    running = false
    eyeModel:Destroy()
end)()
