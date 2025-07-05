local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local cameraShaker = require(game.ReplicatedStorage.CameraShaker)
local camera = workspace.CurrentCamera

local camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
    camera.CFrame = camera.CFrame * cf
end)

local function GetGitSound(GithubSnd,SoundName)
    local url=GithubSnd
    if not isfile(SoundName..".mp3") then
        writefile(SoundName..".mp3", game:HttpGet(url))
    end
    local sound=Instance.new("Sound")
    sound.SoundId=(getcustomasset or getsynasset)(SoundName..".mp3")
    sound.Parent = workspace
    return sound
end

local function IsVisible()
    local Model = workspace.Dread:FindFirstChild("RushNew")
    if not Model then return false end

    local vec, found = workspace.CurrentCamera:WorldToViewportPoint(Model.Position)
    local onscreen = found and vec.Z > 0
    
    if not onscreen then return false end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {Model}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local rayOrigin = workspace.CurrentCamera.CFrame.Position
    local rayDirection = (Model.Position - rayOrigin).Unit * (rayOrigin - Model.Position).Magnitude
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if not raycastResult or raycastResult.Instance:IsDescendantOf(Players.LocalPlayer.Character) then
        return true
    end
    
    return false
end
local function hasModel(name)
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant.Name == name then
            return true
        end
    end
    return false
end
if not hasModel("SeekMovingNewClone") and not hasModel("FigureRig") and not hasModel("GrumbleRig") and not hasModel("TrueSeek") then
    ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local LatestRoomValue = ReplicatedStorage.GameData.LatestRoom.Value
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
        
    local Rooms = Workspace.CurrentRooms[LatestRoomValue]
    local OGNodes = Rooms:FindFirstChild("PathfindNodes")

    if OGNodes then
        local NewNodes = OGNodes:Clone()
        NewNodes.Parent = Rooms
        NewNodes.Name = "Nodes"
    end

    local currentLoadedRoom = workspace.CurrentRooms[LatestRoomValue]
    local success, eyes = pcall(function()
        return game:GetObjects("rbxassetid://12654337720")[1]
    end)

    local nodes = currentLoadedRoom:FindFirstChild("Nodes") or currentLoadedRoom:FindFirstChild("PathfindNodes")
    local numChildren = #nodes:GetChildren()
    local num = math.floor(numChildren / 2)
    local targetNode = num == 0 and currentLoadedRoom:FindFirstChild("Base") or nodes:GetChildren()[num]

    eyes:PivotTo(targetNode.CFrame + Vector3.new(0, 3, 0))
    eyes.Parent = workspace
    camShake:Start()
    camShake:ShakeOnce(2,10,1,1)

    local Ambience_Dread = Instance.new("ColorCorrectionEffect")
    Ambience_Dread.Name = "Ambience_Dread"
    Ambience_Dread.Parent = Lighting

    TweenService:Create(Ambience_Dread, TweenInfo.new(2), {
        Brightness = 0.1,
        Contrast = 0.2,
        Saturation = -0.7
    }):Play()

    coroutine.wrap(function()
        local Dread = workspace:FindFirstChild("Dread")
        if not Dread then return end
        
        while true do
            if IsVisible() then
                Ambience_Dread.Enabled = false
                local maingame = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
                maingame.stopcam = true
                
                local cam = workspace.CurrentCamera
                local ccf = cam.CFrame
                local player = Players.LocalPlayer
                local character = player and player.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart then
                    local tweencam = TweenService:Create(cam, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        CFrame = CFrame.lookAt(ccf.p, humanoidRootPart.Position)
                    })
                    tweencam:Play()
                    wait(0.15)
                    local c = GetGitSound("https://github.com/XAtomMaster339871/dkrsoilcfrkjghfhgrthngnrtuyghrtuhngur/blob/main/death.mp3?raw=true","i work at burging king")
                    c:Play()
                    tweencam:Pause()
                    
                    for _,v in pairs(workspace:GetDescendants()) do
                        if v.ClassName == "ParticleEmitter" then
                            v.TimeScale = 0
                        end
                    end
                    
                    wait(2)
                    Lighting.MainColorCorrection.Brightness = -1
                    Lighting.MainColorCorrection.Contrast = -4
                    Lighting.MainColorCorrection.Saturation = -1
                    
                    for _,v in pairs(Dread:GetDescendants()) do
                        if v.Name == "PointLight" then
                            v:Destroy()
                        end
                    end

                    camShake:Start()
                    camShake:ShakeOnce(10,100,0.1,1)
                    wait(1)
                    
                    maingame.stopcam = false
                    maingame.freemouse = false
                    wait(0.4)
                    
                    loadstring(game:HttpGet(("https://raw.githubusercontent.com/XAtomMaster339871/dkrsoilcfrkjghfhgrthngnrtuyghrtuhngur/main/erfz"),true))()
                    local player = Players.LocalPlayer
                    ReplicatedStorage.GameStats["Player_"..player.Name].Total.DeathCause.Value = "Dread"
                    firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                        "You died to Dread...",
                        "Its presence is summoned when the clock hits 12...",
                        "Do not observe it! You may lose your sanity!"
                        },
                        "Blue")
                    break
                end
            end
            task.wait(0.5)
        end
    end)()

    coroutine.wrap(function()
        game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Wait()
        task.wait()
        game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Wait()
        task.wait()
        game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Wait()
        
        local Dread = workspace:FindFirstChild("Dread")
        if Dread then
            Dread:Destroy()
            Ambience_Dread:Destroy()
        end
    end)()
end
