---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Smiley",
		Asset = "rbxassetid://72343617413913",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
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
		Values = {3.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 300,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 5,
		Max = 5,
		Delay = 0.1
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = false
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"You died to Smiley", "It's like Rush", "Need to hide", "Keep going"},
		Cause = ""
	}
})

---====== Debug entity ======---
entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
	else
    game:GetService("Workspace").Smiley.SmileyNew.SpawnSound.Volume = "10"
    game:GetService("Workspace").Smiley.SmileyNew.SpawnSound.RollOffMinDistance = "50"
    game:GetService("Workspace").Smiley.SmileyNew.SpawnSound.RollOffMaxDistance = "100000"
    game:GetService("Workspace").Smiley.SmileyNew.SpawnSound:Play()
	if game.Workspace:FindFirstChild("Smiley") then
		game.Workspace.Smiley.SmileyNew.Attachment.ParticleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.47058823529, 0.47058823529)),
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.47058823529, 0.47058823529)),
            ColorSequenceKeypoint.new(0.470588, Color3.new(1, 0.47058823529, 0.47058823529)),
            ColorSequenceKeypoint.new(0.470588, Color3.new(1, 0.47058823529, 0.47058823529)),
            ColorSequenceKeypoint.new(1, Color3.new(1, 0.47058823529, 0.47058823529))
        })
	require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Smiley is angry!",true)
	end
	end
end)
---====== Run entity ======---

entity:Run()
