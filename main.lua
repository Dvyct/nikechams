local dwEntities = game:GetService("Players")
local dwLocalPlayer = dwEntities.LocalPlayer
local dwRunService = game:GetService("RunService")

local settings_tbl = {
    ESP_Enabled = true,
    ESP_TeamCheck = false,
    Chams = true,
    Chams_Color = Color3.fromRGB(255, 0, 0),
    Chams_Glow_Color = Color3.fromRGB(0, 255, 0), -- Example color
    Chans_Transparency = 0.5, -- Example transparency
}

function destroy_chams(char)
    for k, v in ipairs(char:GetChildren()) do
        if v:IsA("BasePart") and v.Transparency ~= 1 then
            if v:FindFirstChild("Glow") and v:FindFirstChild("Chams") then
                v.Glow:Destroy()
                v.Chams:Destroy()
            end
        end
    end
end

dwRunService.Heartbeat:Connect(function()
    if settings_tbl.ESP_Enabled then
        for k, v in ipairs(dwEntities:GetPlayers()) do
            if v ~= dwLocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                for _, b in ipairs(v.Character:GetChildren()) do
                    if b:IsA("BasePart") and b.Transparency ~= 1 then
                        if settings_tbl.Chams then
                            if not b:FindFirstChild("Glow") and not b:FindFirstChild("Chams") then
                                local chams_box = Instance.new("BoxHandleAdornment", b)
                                chams_box.Name = "Chams"
                                chams_box.AlwaysOnTop = true
                                chams_box.ZIndex = 4
                                chams_box.Adornee = b
                                chams_box.Color3 = settings_tbl.Chams_Color
                                chams_box.Transparency = settings_tbl.Chans_Transparency
                                chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

                                local glow_box = Instance.new("BoxHandleAdornment", b)
          glow_box.Name = "Glow"
                                glow_box.AlwaysOnTop = false
                                glow_box.ZIndex = 3
                                glow_box.Adornee = b
                                glow_box.Color3 = settings_tbl.Chams_Glow_Color
                                glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)
                            end
                        else
                            destroy_chams(v.Character)
                        end
                    end
                end
            end
        end
    else
        for k, v in ipairs(dwEntities:GetPlayers()) do
            if v ~= dwLocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                destroy_chams(v.Character)
            end
        end
    end
end)
