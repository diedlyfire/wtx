-- ================================================
--     WAR TYCOON X  v3  |  by SWare
--     Rayfield UI | Fixed Aimbot + ESP
-- ================================================

-- ================================================
--              KEY SYSTEM
-- ================================================

-- !!! ЗАМЕНИ ЭТИ ДВЕ СТРОКИ !!!
local KEY_URL     = "https://raw.githubusercontent.com/USERNAME/REPO/main/key.txt"
local VALID_KEY   = "WTX-SWARE-2024"
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

local Players_ks  = game:GetService("Players")
local UIS_ks      = game:GetService("UserInputService")
local TweenSvc_ks = game:GetService("TweenService")
local CoreGui_ks  = game:GetService("CoreGui")
local LP_ks       = Players_ks.LocalPlayer

-- Сохранённый ключ (чтобы не вводить каждый раз)
local savedKeyFile = "WTX_key.txt"
local function LoadSavedKey()
    if isfile and isfile(savedKeyFile) then
        return readfile(savedKeyFile)
    end
    return nil
end
local function SaveKey(key)
    if writefile then writefile(savedKeyFile, key) end
end

-- Проверка ключа через GitHub
local function FetchKeyFromGitHub()
    local ok, result = pcall(function()
        return game:HttpGet(KEY_URL)
    end)
    if ok and result then
        return result:gsub("%s+", "") -- убираем пробелы/переносы
    end
    return nil
end

local keyVerified = false

local function RunKeySystem(onSuccess)

    -- Проверяем сохранённый ключ сначала
    local saved = LoadSavedKey()
    if saved then
        local remote = FetchKeyFromGitHub()
        if remote and saved == remote and saved == VALID_KEY then
            keyVerified = true
            onSuccess()
            return
        end
    end

    -- Создаём GUI окно
    if CoreGui_ks:FindFirstChild("WTX_KeyGui") then
        CoreGui_ks:FindFirstChild("WTX_KeyGui"):Destroy()
    end

    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "WTX_KeyGui"
    KeyGui.ResetOnSpawn = false
    KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeyGui.Parent = CoreGui_ks

    -- Затемнение фона
    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1,0,1,0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Overlay.BackgroundTransparency = 0.4
    Overlay.BorderSizePixel = 0
    Overlay.ZIndex = 1
    Overlay.Parent = KeyGui

    -- Главный контейнер
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 420, 0, 280)
    Main.Position = UDim2.new(0.5, -210, 0.5, -140)
    Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Main.BorderSizePixel = 0
    Main.ZIndex = 2
    Main.Parent = KeyGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(60, 60, 75)
    MainStroke.Thickness = 1
    MainStroke.Parent = Main

    -- Анимация появления
    Main.Position = UDim2.new(0.5, -210, 0.6, -140)
    Main.BackgroundTransparency = 1
    TweenSvc_ks:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5,-210,0.5,-140),
        BackgroundTransparency = 0
    }):Play()

    -- Акцентная линия сверху
    local TopAccent = Instance.new("Frame")
    TopAccent.Size = UDim2.new(1, 0, 0, 3)
    TopAccent.BackgroundColor3 = Color3.fromRGB(90, 150, 255)
    TopAccent.BorderSizePixel = 0
    TopAccent.ZIndex = 3
    TopAccent.Parent = Main

    local TopAccentCorner = Instance.new("UICorner")
    TopAccentCorner.CornerRadius = UDim.new(0, 8)
    TopAccentCorner.Parent = TopAccent

    -- Градиент акцента
    local AccentGrad = Instance.new("UIGradient")
    AccentGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60,120,255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120,180,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60,120,255)),
    })
    AccentGrad.Parent = TopAccent

    -- Логотип / название
    local Logo = Instance.new("TextLabel")
    Logo.Size = UDim2.new(1,0,0,50)
    Logo.Position = UDim2.new(0,0,0,18)
    Logo.BackgroundTransparency = 1
    Logo.Text = "WAR TYCOON X"
    Logo.TextColor3 = Color3.fromRGB(255,255,255)
    Logo.Font = Enum.Font.GothamBold
    Logo.TextSize = 22
    Logo.ZIndex = 3
    Logo.Parent = Main

    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1,0,0,20)
    Sub.Position = UDim2.new(0,0,0,52)
    Sub.BackgroundTransparency = 1
    Sub.Text = "Введи ключ для доступа"
    Sub.TextColor3 = Color3.fromRGB(110,110,130)
    Sub.Font = Enum.Font.Gotham
    Sub.TextSize = 12
    Sub.ZIndex = 3
    Sub.Parent = Main

    -- Разделитель
    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(0.8,0,0,1)
    Divider.Position = UDim2.new(0.1,0,0,82)
    Divider.BackgroundColor3 = Color3.fromRGB(45,45,60)
    Divider.BorderSizePixel = 0
    Divider.ZIndex = 3
    Divider.Parent = Main

    -- Поле ввода (контейнер)
    local InputBox = Instance.new("Frame")
    InputBox.Size = UDim2.new(0.84,0,0,42)
    InputBox.Position = UDim2.new(0.08,0,0,100)
    InputBox.BackgroundColor3 = Color3.fromRGB(28,28,36)
    InputBox.BorderSizePixel = 0
    InputBox.ZIndex = 3
    InputBox.Parent = Main

    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 6)
    InputCorner.Parent = InputBox

    local InputStroke = Instance.new("UIStroke")
    InputStroke.Color = Color3.fromRGB(55,55,70)
    InputStroke.Thickness = 1
    InputStroke.Parent = InputBox

    -- Иконка ключа
    local KeyIcon = Instance.new("TextLabel")
    KeyIcon.Size = UDim2.new(0,30,1,0)
    KeyIcon.Position = UDim2.new(0,8,0,0)
    KeyIcon.BackgroundTransparency = 1
    KeyIcon.Text = "🔑"
    KeyIcon.TextSize = 16
    KeyIcon.ZIndex = 4
    KeyIcon.Parent = InputBox

    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(1,-46,1,0)
    Input.Position = UDim2.new(0,36,0,0)
    Input.BackgroundTransparency = 1
    Input.Text = ""
    Input.PlaceholderText = "Введи ключ..."
    Input.TextColor3 = Color3.fromRGB(220,220,230)
    Input.PlaceholderColor3 = Color3.fromRGB(70,70,90)
    Input.Font = Enum.Font.Gotham
    Input.TextSize = 13
    Input.TextXAlignment = Enum.TextXAlignment.Left
    Input.ClearTextOnFocus = false
    Input.ZIndex = 4
    Input.Parent = InputBox

    -- Подсветка при фокусе
    Input.Focused:Connect(function()
        TweenSvc_ks:Create(InputStroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(90,150,255)
        }):Play()
    end)
    Input.FocusLost:Connect(function()
        TweenSvc_ks:Create(InputStroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(55,55,70)
        }):Play()
    end)

    -- Статус лейбл
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(0.84,0,0,18)
    StatusLabel.Position = UDim2.new(0.08,0,0,148)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(255,80,80)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 11
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.ZIndex = 3
    StatusLabel.Parent = Main

    -- Кнопка подтверждения
    local ConfirmBtn = Instance.new("TextButton")
    ConfirmBtn.Size = UDim2.new(0.84,0,0,40)
    ConfirmBtn.Position = UDim2.new(0.08,0,0,175)
    ConfirmBtn.BackgroundColor3 = Color3.fromRGB(70,120,220)
    ConfirmBtn.BorderSizePixel = 0
    ConfirmBtn.Text = "ПОДТВЕРДИТЬ"
    ConfirmBtn.TextColor3 = Color3.fromRGB(255,255,255)
    ConfirmBtn.Font = Enum.Font.GothamBold
    ConfirmBtn.TextSize = 13
    ConfirmBtn.ZIndex = 3
    ConfirmBtn.Parent = Main

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = ConfirmBtn

    -- Hover эффект кнопки
    ConfirmBtn.MouseEnter:Connect(function()
        TweenSvc_ks:Create(ConfirmBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(90,145,255)
        }):Play()
    end)
    ConfirmBtn.MouseLeave:Connect(function()
        TweenSvc_ks:Create(ConfirmBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(70,120,220)
        }):Play()
    end)

    -- Ссылка на Discord/где взять ключ
    local DiscordLabel = Instance.new("TextLabel")
    DiscordLabel.Size = UDim2.new(1,0,0,20)
    DiscordLabel.Position = UDim2.new(0,0,0,228)
    DiscordLabel.BackgroundTransparency = 1
    DiscordLabel.Text = "Ключ: discord.gg/yourserver"
    DiscordLabel.TextColor3 = Color3.fromRGB(70,70,90)
    DiscordLabel.Font = Enum.Font.Gotham
    DiscordLabel.TextSize = 10
    DiscordLabel.ZIndex = 3
    DiscordLabel.Parent = Main

    -- Логика проверки
    local function TryVerify()
        local inputKey = Input.Text:gsub("%s+","")

        if inputKey == "" then
            StatusLabel.Text = "⚠ Введи ключ!"
            StatusLabel.TextColor3 = Color3.fromRGB(255,200,50)
            return
        end

        StatusLabel.Text = "⏳ Проверяем..."
        StatusLabel.TextColor3 = Color3.fromRGB(150,150,170)
        ConfirmBtn.Text = "ПРОВЕРКА..."
        ConfirmBtn.BackgroundColor3 = Color3.fromRGB(50,50,70)

        task.spawn(function()
            local remoteKey = FetchKeyFromGitHub()

            if remoteKey == nil then
                -- Если GitHub недоступен — проверяем локально
                StatusLabel.Text = "⚠ GitHub недоступен, проверка локально"
                StatusLabel.TextColor3 = Color3.fromRGB(255,200,50)
                remoteKey = VALID_KEY
            end

            if inputKey == remoteKey and inputKey == VALID_KEY then
                -- Успех
                StatusLabel.Text = "✓ Ключ верный!"
                StatusLabel.TextColor3 = Color3.fromRGB(80,220,100)
                ConfirmBtn.Text = "✓ ДОСТУП ОТКРЫТ"
                ConfirmBtn.BackgroundColor3 = Color3.fromRGB(50,160,80)
                TopAccent.BackgroundColor3 = Color3.fromRGB(50,200,90)

                SaveKey(inputKey)

                task.wait(1.2)

                -- Анимация закрытия
                TweenSvc_ks:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.5,-210,0.4,-140),
                    BackgroundTransparency = 1
                }):Play()
                TweenSvc_ks:Create(Overlay, TweenInfo.new(0.3), {
                    BackgroundTransparency = 1
                }):Play()

                task.wait(0.35)
                KeyGui:Destroy()
                keyVerified = true
                onSuccess()
            else
                -- Неверный ключ
                StatusLabel.Text = "✗ Неверный ключ!"
                StatusLabel.TextColor3 = Color3.fromRGB(255,80,80)
                ConfirmBtn.Text = "ПОДТВЕРДИТЬ"
                ConfirmBtn.BackgroundColor3 = Color3.fromRGB(70,120,220)

                -- Shake анимация поля ввода
                local origPos = InputBox.Position
                for i = 1, 3 do
                    TweenSvc_ks:Create(InputBox, TweenInfo.new(0.05), {
                        Position = UDim2.new(origPos.X.Scale, origPos.X.Offset+6, origPos.Y.Scale, origPos.Y.Offset)
                    }):Play()
                    task.wait(0.05)
                    TweenSvc_ks:Create(InputBox, TweenInfo.new(0.05), {
                        Position = UDim2.new(origPos.X.Scale, origPos.X.Offset-6, origPos.Y.Scale, origPos.Y.Offset)
                    }):Play()
                    task.wait(0.05)
                end
                TweenSvc_ks:Create(InputBox, TweenInfo.new(0.05), {Position=origPos}):Play()
            end
        end)
    end

    ConfirmBtn.MouseButton1Click:Connect(TryVerify)

    -- Enter для подтверждения
    Input.FocusLost:Connect(function(enter)
        if enter then TryVerify() end
    end)
end

-- ================================================
-- Запускаем key system, и только после успеха — основной скрипт
-- ================================================
RunKeySystem(function()
    -- Основной скрипт загружается ТОЛЬКО после правильного ключа

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

------------------------------------------------ SERVICES
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local Lighting   = game:GetService("Lighting")
local RepStorage = game:GetService("ReplicatedStorage")
local CoreGui    = game:GetService("CoreGui")

local LP     = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse  = LP:GetMouse()

------------------------------------------------ CONFIG
getgenv().WTX = {
    -- Aimbot
    Aimbot        = false,
    AimbotBone    = "Head",
    AimbotKey     = "Toggle",   -- "Toggle" / "Hold"
    TeamCheck     = true,
    FOV           = 300,
    Smoothness    = 0.25,
    AimbotOn      = false,      -- внутренний стейт для toggle режима

    -- Player
    Speed         = false,
    Fly           = false,
    Noclip        = false,
    InfiniteJump  = false,
    GodMode       = false,
    WalkSpeed     = 50,
    FlySpeed      = 100,
    JumpPower     = 70,

    -- Ammo
    InfiniteAmmo  = false,
    NoReload      = false,

    -- Farm
    AutoFarm      = false,
    AutoCollect   = false,

    -- ESP
    ESPEnabled    = false,
    ESPNames      = true,
    ESPHealth     = true,
    ESPDistance   = true,
    ESPMaxDist    = 1500,
    ESPTeamColor  = true,
}

------------------------------------------------ WINDOW
local Window = Rayfield:CreateWindow({
    Name = "WAR TYCOON X  v3",
    LoadingTitle    = "War Tycoon X",
    LoadingSubtitle = "by SWare",
    ConfigurationSaving = {
        Enabled    = true,
        FolderName = "WarTycoonX",
        FileName   = "Config"
    }
})

------------------------------------------------ TABS
local CombatTab = Window:CreateTab("Combat")
local PlayerTab = Window:CreateTab("Player")
local AmmoTab   = Window:CreateTab("Ammo")
local FarmTab   = Window:CreateTab("Farm")
local VisualTab = Window:CreateTab("Visuals")
local TpTab     = Window:CreateTab("Teleports")
local MiscTab   = Window:CreateTab("Misc")

------------------------------------------------ UTILITY
local function GetChar()  return LP.Character end
local function GetRoot()  local c=GetChar(); return c and c:FindFirstChild("HumanoidRootPart") end
local function GetHum()   local c=GetChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function IsEnemy(p)
    if not getgenv().WTX.TeamCheck then return true end
    return p.Team ~= LP.Team
end
local function Notify(t,m,d) Rayfield:Notify({Title=t,Content=m,Duration=d or 3}) end

-- ================================================
--              AIMBOT  (полностью переписан)
-- ================================================
-- Принцип: ищем ближайшего к центру экрана врага
-- НЕ используем Mouse.Hit и НЕ требуем зажатия RMB

local lockedTarget  = nil
local lastBonePos   = nil

local function IsValidTarget(player)
    if not player or not player.Parent then return false end
    if not player.Character then return false end
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    local bone = player.Character:FindFirstChild(getgenv().WTX.AimbotBone)
    if not bone then return false end
    local _, vis = Camera:WorldToViewportPoint(bone.Position)
    return vis
end

local function FindClosestTarget()
    local best, bestDist = nil, getgenv().WTX.FOV
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and IsEnemy(v) then
            local hum = v.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local bone = v.Character:FindFirstChild(getgenv().WTX.AimbotBone)
                if bone then
                    local pos, vis = Camera:WorldToViewportPoint(bone.Position)
                    if vis then
                        local d = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if d < bestDist then
                            bestDist = d
                            best = v
                        end
                    end
                end
            end
        end
    end
    return best
end

-- Toggle aimbot по нажатию Z
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.Z and getgenv().WTX.Aimbot then
        getgenv().WTX.AimbotOn = not getgenv().WTX.AimbotOn
        if not getgenv().WTX.AimbotOn then
            lockedTarget = nil
            lastBonePos  = nil
        end
        Notify("Aimbot", getgenv().WTX.AimbotOn and "ON" or "OFF", 1)
    end
end)

RunService.RenderStepped:Connect(function(dt)
    if not getgenv().WTX.Aimbot then
        lockedTarget = nil; lastBonePos = nil; return
    end
    if not getgenv().WTX.AimbotOn then return end

    -- Если цель стала невалидной — ищем новую
    if not IsValidTarget(lockedTarget) then
        lockedTarget = FindClosestTarget()
        lastBonePos  = nil
    end

    if not lockedTarget or not lockedTarget.Character then return end
    local bone = lockedTarget.Character:FindFirstChild(getgenv().WTX.AimbotBone)
    if not bone then lockedTarget = nil; return end

    -- Предсказание движения цели
    local targetPos = bone.Position
    if lastBonePos and dt > 0 then
        local vel = (bone.Position - lastBonePos) / dt
        targetPos = bone.Position + vel * dt
    end
    lastBonePos = bone.Position

    -- Плавное наведение (только направление камеры, позиция не меняется)
    local camPos   = Camera.CFrame.Position
    local goalCF   = CFrame.new(camPos, targetPos)
    local smooth   = math.clamp(getgenv().WTX.Smoothness, 0.01, 1.0)
    Camera.CFrame  = Camera.CFrame:Lerp(goalCF, smooth)
end)

-- ================================================
--              SPEED / JUMP
-- ================================================
RunService.RenderStepped:Connect(function()
    local hum = GetHum(); if not hum then return end
    if getgenv().WTX.Speed then hum.WalkSpeed = getgenv().WTX.WalkSpeed end
    hum.JumpPower = getgenv().WTX.JumpPower
end)

-- ================================================
--              FLY
-- ================================================
local flying, flyBody = false, nil
local function StopFly()
    flying = false
    if flyBody then flyBody:Destroy(); flyBody = nil end
end
local function StartFly()
    local root = GetRoot(); if not root then return end
    flying = true
    if flyBody then flyBody:Destroy() end
    flyBody = Instance.new("BodyVelocity")
    flyBody.MaxForce = Vector3.new(1e9,1e9,1e9)
    flyBody.Velocity = Vector3.zero
    flyBody.Parent   = root
end
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.F and getgenv().WTX.Fly then
        if flying then StopFly() else StartFly() end
    end
end)
RunService.RenderStepped:Connect(function()
    if not (flying and flyBody) then return end
    local cf  = Camera.CFrame
    local vel = Vector3.zero
    local spd = getgenv().WTX.FlySpeed
    if UIS:IsKeyDown(Enum.KeyCode.W)           then vel = vel + cf.LookVector  * spd end
    if UIS:IsKeyDown(Enum.KeyCode.S)           then vel = vel - cf.LookVector  * spd end
    if UIS:IsKeyDown(Enum.KeyCode.A)           then vel = vel - cf.RightVector * spd end
    if UIS:IsKeyDown(Enum.KeyCode.D)           then vel = vel + cf.RightVector * spd end
    if UIS:IsKeyDown(Enum.KeyCode.Space)       then vel = vel + Vector3.new(0,spd,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vel = vel - Vector3.new(0,spd,0) end
    flyBody.Velocity = vel
end)

-- ================================================
--              NOCLIP
-- ================================================
RunService.Stepped:Connect(function()
    if not getgenv().WTX.Noclip then return end
    local char = GetChar(); if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = false end
    end
end)

-- ================================================
--              INFINITE JUMP
-- ================================================
UIS.JumpRequest:Connect(function()
    if getgenv().WTX.InfiniteJump then
        local hum = GetHum(); if hum then hum:ChangeState("Jumping") end
    end
end)

-- ================================================
--              GOD MODE
-- ================================================
RunService.Stepped:Connect(function()
    if not getgenv().WTX.GodMode then return end
    local hum = GetHum(); if hum then hum.Health = hum.MaxHealth end
end)

-- ================================================
--              AMMO PATCH
-- ================================================
local AMMO_KEYS   = {"ammo","bullet","shell","round","mag","clip","count","chamber","cartridge","magazine"}
local RELOAD_KEYS = {"reload","cooldown","firerate","firedelay","shootdelay","delay","interval"}

local function PatchObject(obj)
    for _, v in pairs(obj:GetDescendants()) do
        local n = string.lower(v.Name)
        if getgenv().WTX.InfiniteAmmo and (v:IsA("NumberValue") or v:IsA("IntValue")) then
            for _, kw in pairs(AMMO_KEYS) do
                if string.find(n, kw) then pcall(function() v.Value = 9999 end); break end
            end
        end
        if getgenv().WTX.NoReload and v:IsA("NumberValue") then
            for _, kw in pairs(RELOAD_KEYS) do
                if string.find(n, kw) then
                    pcall(function() if v.Value > 0.01 then v.Value = 0.01 end end); break
                end
            end
        end
        if getgenv().WTX.NoReload and v:IsA("BoolValue") then
            if string.find(string.lower(v.Name), "reload") then
                pcall(function() v.Value = false end)
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if not (getgenv().WTX.InfiniteAmmo or getgenv().WTX.NoReload) then return end
    pcall(function()
        for _, t in pairs(LP.Backpack:GetChildren()) do PatchObject(t) end
        local char = GetChar()
        if char then
            for _, t in pairs(char:GetChildren()) do
                if t:IsA("Tool") then PatchObject(t) end
            end
        end
    end)
end)

-- ================================================
--              AUTO FARM
-- ================================================
task.spawn(function()
    while task.wait(0.5) do
        if not getgenv().WTX.AutoCollect then continue end
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then fireproximityprompt(obj) end
                if obj:IsA("ClickDetector")   then fireclickdetector(obj) end
            end
            for _, v in pairs(RepStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local n = string.lower(v.Name)
                    if string.find(n,"collect") or string.find(n,"claim") or
                       string.find(n,"money")   or string.find(n,"cash")  then
                        v:FireServer()
                    end
                end
            end
        end)
    end
end)

local function GetFarmTargets()
    local targets = {}
    local kws = {"Coin","Money","Cash","Drop","Collect","Resource","Oil","Crate","Supply","Pickup","Reward","Credit","Loot"}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            for _, kw in pairs(kws) do
                if string.find(string.lower(obj.Name), string.lower(kw)) then
                    table.insert(targets, obj); break
                end
            end
        end
    end
    return targets
end

task.spawn(function()
    while task.wait(0.3) do
        if not getgenv().WTX.AutoFarm then continue end
        local root = GetRoot(); if not root then continue end
        for _, obj in pairs(GetFarmTargets()) do
            if not getgenv().WTX.AutoFarm then break end
            local pos
            if obj:IsA("Model") then
                local p = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if p then pos = p.Position end
            else pos = obj.Position end
            if pos then root.CFrame = CFrame.new(pos + Vector3.new(0,3,0)); task.wait(0.05) end
        end
    end
end)

-- ================================================
--              ESP  (полностью переписан)
--  Используем Drawing API вместо BillboardGui
--  Drawing рисуется поверх всего без лагов
-- ================================================

-- Очищаем старые ESP объекты
if CoreGui:FindFirstChild("WTX_ESP_Old") then
    CoreGui:FindFirstChild("WTX_ESP_Old"):Destroy()
end

-- Таблица Drawing объектов для каждого игрока
local espObjects = {}

local function GetESPColor(player)
    if getgenv().WTX.ESPTeamColor then
        return IsEnemy(player) and Color3.fromRGB(255,80,80) or Color3.fromRGB(80,255,120)
    end
    return Color3.fromRGB(255,80,80)
end

local function CreateESPForPlayer(player)
    if espObjects[player] then return end
    espObjects[player] = {
        box     = Drawing.new("Square"),
        name    = Drawing.new("Text"),
        health  = Drawing.new("Text"),
        dist    = Drawing.new("Text"),
        hpBar   = Drawing.new("Square"),
        hpFill  = Drawing.new("Square"),
    }
    local e = espObjects[player]

    e.box.Visible     = false
    e.box.Filled       = false
    e.box.Thickness    = 1
    e.box.Color        = Color3.fromRGB(255,80,80)

    e.name.Visible     = false
    e.name.Size        = 13
    e.name.Font        = Drawing.Fonts.UI
    e.name.Color       = Color3.fromRGB(255,255,255)
    e.name.Outline     = true
    e.name.Center      = true

    e.health.Visible   = false
    e.health.Size      = 11
    e.health.Font      = Drawing.Fonts.UI
    e.health.Color     = Color3.fromRGB(180,255,180)
    e.health.Outline   = true
    e.health.Center    = true

    e.dist.Visible     = false
    e.dist.Size        = 11
    e.dist.Font        = Drawing.Fonts.UI
    e.dist.Color       = Color3.fromRGB(180,180,180)
    e.dist.Outline     = true
    e.dist.Center      = true

    -- HP bar background
    e.hpBar.Visible    = false
    e.hpBar.Filled     = true
    e.hpBar.Color      = Color3.fromRGB(40,40,40)
    e.hpBar.Transparency = 0.4

    -- HP bar fill
    e.hpFill.Visible   = false
    e.hpFill.Filled    = true
    e.hpFill.Color     = Color3.fromRGB(80,220,80)
end

local function RemoveESPForPlayer(player)
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            pcall(function() obj:Remove() end)
        end
        espObjects[player] = nil
    end
end

local function HideESP(player)
    if not espObjects[player] then return end
    local e = espObjects[player]
    e.box.Visible    = false
    e.name.Visible   = false
    e.health.Visible = false
    e.dist.Visible   = false
    e.hpBar.Visible  = false
    e.hpFill.Visible = false
end

-- Инициализируем ESP для уже существующих игроков
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP then CreateESPForPlayer(p) end
end

Players.PlayerAdded:Connect(function(p)
    CreateESPForPlayer(p)
end)
Players.PlayerRemoving:Connect(function(p)
    RemoveESPForPlayer(p)
end)

-- Основной цикл ESP через Drawing
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LP then continue end

        if not espObjects[player] then CreateESPForPlayer(player) end
        local e = espObjects[player]

        -- Скрываем если ESP выключен или игрока нет
        if not getgenv().WTX.ESPEnabled or not player.Character then
            HideESP(player); continue
        end

        local char = player.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum  = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then HideESP(player); continue end

        -- Дистанция
        local camPos = Camera.CFrame.Position
        local dist   = (camPos - root.Position).Magnitude
        if dist > getgenv().WTX.ESPMaxDist then HideESP(player); continue end

        -- Получаем bounding box персонажа на экране
        -- Используем Head и ноги для вычисления высоты бокса
        local head = char:FindFirstChild("Head")
        local hrp  = root

        local headPos, headVis = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.8, 0))
        local feetPos, feetVis = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.0, 0))

        if not headVis and not feetVis then HideESP(player); continue end

        -- Размеры бокса
        local boxH = math.abs(headPos.Y - feetPos.Y)
        local boxW = boxH * 0.5
        local boxX = headPos.X - boxW/2
        local boxY = math.min(headPos.Y, feetPos.Y)

        -- Минимальный размер
        if boxH < 5 then HideESP(player); continue end

        local color = GetESPColor(player)

        -- BOX
        e.box.Visible    = true
        e.box.Position   = Vector2.new(boxX, boxY)
        e.box.Size       = Vector2.new(boxW, boxH)
        e.box.Color      = color

        -- HP BAR (слева от бокса)
        local barW   = 3
        local barX   = boxX - barW - 2
        local hpPct  = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
        local barH   = boxH

        e.hpBar.Visible    = true
        e.hpBar.Position   = Vector2.new(barX, boxY)
        e.hpBar.Size       = Vector2.new(barW, barH)

        e.hpFill.Visible   = true
        e.hpFill.Position  = Vector2.new(barX, boxY + barH * (1 - hpPct))
        e.hpFill.Size      = Vector2.new(barW, barH * hpPct)
        -- Цвет HP bar: зелёный→жёлтый→красный
        e.hpFill.Color     = Color3.fromRGB(
            math.floor(255 * (1 - hpPct)),
            math.floor(255 * hpPct),
            0
        )

        -- NAME
        if getgenv().WTX.ESPNames then
            e.name.Visible   = true
            e.name.Position  = Vector2.new(headPos.X, boxY - 15)
            e.name.Text      = player.Name
            e.name.Color     = color
        else
            e.name.Visible = false
        end

        -- HEALTH TEXT
        if getgenv().WTX.ESPHealth then
            e.health.Visible  = true
            e.health.Position = Vector2.new(headPos.X, boxY + boxH + 1)
            e.health.Text     = math.floor(hum.Health).." HP"
            e.health.Color    = e.hpFill.Color
        else
            e.health.Visible = false
        end

        -- DISTANCE
        if getgenv().WTX.ESPDistance then
            e.dist.Visible   = true
            e.dist.Position  = Vector2.new(headPos.X, boxY + boxH + 13)
            e.dist.Text      = math.floor(dist).."m"
        else
            e.dist.Visible = false
        end
    end
end)

-- ================================================
--              TELEPORTS
-- ================================================
local TpList = {
    ["My Tycoon"]  = Vector3.new(0,   10,  0),
    ["Center Map"] = Vector3.new(0,   10,  500),
    ["North Base"] = Vector3.new(0,   10,  1500),
    ["South Base"] = Vector3.new(0,   10, -1500),
    ["East Base"]  = Vector3.new(1500,10,  0),
    ["West Base"]  = Vector3.new(-1500,10, 0),
    ["Airport"]    = Vector3.new(800, 10,  800),
    ["Naval Base"] = Vector3.new(-800,10,  800),
}
local function TeleportTo(pos)
    local root = GetRoot()
    if root then root.CFrame = CFrame.new(pos + Vector3.new(0,5,0)) end
end
local function TpToPlayer(name)
    local t = Players:FindFirstChild(name)
    if t and t.Character then
        local root  = GetRoot()
        local tRoot = t.Character:FindFirstChild("HumanoidRootPart")
        if root and tRoot then root.CFrame = tRoot.CFrame + Vector3.new(3,0,0) end
    end
end

-- ================================================
--              COMBAT TAB UI
-- ================================================

CombatTab:CreateToggle({
    Name = "Aimbot  [Z] — toggle вкл/выкл",
    CurrentValue = false,
    Callback = function(v)
        getgenv().WTX.Aimbot = v
        if not v then
            getgenv().WTX.AimbotOn = false
            lockedTarget = nil; lastBonePos = nil
        end
        Notify("Aimbot", v and "Включён. Нажми Z для активации" or "Выключен", 2)
    end
})

CombatTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = true,
    Callback = function(v) getgenv().WTX.TeamCheck = v end
})

CombatTab:CreateSlider({
    Name = "FOV  (радиус захвата цели)",
    Range = {50, 700},
    Increment = 10,
    CurrentValue = 300,
    Callback = function(v) getgenv().WTX.FOV = v end
})

CombatTab:CreateSlider({
    Name = "Speed  (1=плавно 100=мгновенно)",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 25,
    Callback = function(v) getgenv().WTX.Smoothness = v/100 end
})

CombatTab:CreateButton({
    Name = "Bone: Head",
    Callback = function()
        getgenv().WTX.AimbotBone = "Head"
        lockedTarget = nil
        Notify("Aimbot", "Кость: Head", 1)
    end
})

CombatTab:CreateButton({
    Name = "Bone: Torso",
    Callback = function()
        getgenv().WTX.AimbotBone = "UpperTorso"
        lockedTarget = nil
        Notify("Aimbot", "Кость: Torso", 1)
    end
})

CombatTab:CreateButton({
    Name = "Bone: Neck",
    Callback = function()
        getgenv().WTX.AimbotBone = "Neck"
        lockedTarget = nil
        Notify("Aimbot", "Кость: Neck", 1)
    end
})

-- ================================================
--              PLAYER TAB UI
-- ================================================

PlayerTab:CreateToggle({
    Name = "Speed",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.Speed = v end
})

PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 250},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(v) getgenv().WTX.WalkSpeed = v end
})

PlayerTab:CreateToggle({
    Name = "Fly  [F]",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.Fly = v; if not v then StopFly() end end
})

PlayerTab:CreateSlider({
    Name = "Fly Speed",
    Range = {20, 600},
    Increment = 5,
    CurrentValue = 100,
    Callback = function(v) getgenv().WTX.FlySpeed = v end
})

PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.Noclip = v end
})

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.InfiniteJump = v end
})

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 400},
    Increment = 5,
    CurrentValue = 70,
    Callback = function(v) getgenv().WTX.JumpPower = v end
})

PlayerTab:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.GodMode = v end
})

-- ================================================
--              AMMO TAB UI
-- ================================================

AmmoTab:CreateToggle({
    Name = "Infinite Ammo",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.InfiniteAmmo = v end
})

AmmoTab:CreateToggle({
    Name = "No Reload",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.NoReload = v end
})

AmmoTab:CreateButton({
    Name = "Force Patch All Ammo",
    Callback = function()
        local count = 0
        pcall(function()
            for _, t in pairs(LP.Backpack:GetChildren()) do PatchObject(t); count=count+1 end
            if GetChar() then
                for _, t in pairs(GetChar():GetChildren()) do PatchObject(t); count=count+1 end
            end
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                    local n = string.lower(obj.Name)
                    for _, kw in pairs(AMMO_KEYS) do
                        if string.find(n, kw) then obj.Value=9999; count=count+1; break end
                    end
                end
            end
        end)
        Notify("Ammo", "Пропатчено: "..count, 3)
    end
})

AmmoTab:CreateButton({
    Name = "Scan Ammo Values (в консоль)",
    Callback = function()
        local found = {}
        pcall(function()
            for _, obj in pairs(LP.Backpack:GetDescendants()) do
                local n = string.lower(obj.Name)
                if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                    for _, kw in pairs(AMMO_KEYS) do
                        if string.find(n, kw) then
                            table.insert(found, obj.Name.."="..tostring(obj.Value)); break
                        end
                    end
                end
            end
        end)
        print("[WTX Ammo Scan]")
        for _, v in pairs(found) do print("  "..v) end
        Notify("Ammo Scan", #found.." values. Смотри консоль (F9)", 4)
    end
})

-- ================================================
--              FARM TAB UI
-- ================================================

FarmTab:CreateToggle({
    Name = "Auto Farm  (телепорт к дропам)",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.AutoFarm = v; Notify("Farm", v and "ON" or "OFF", 2) end
})

FarmTab:CreateToggle({
    Name = "Auto Collect  (ProximityPrompt + Remotes)",
    CurrentValue = false,
    Callback = function(v) getgenv().WTX.AutoCollect = v; Notify("Collect", v and "ON" or "OFF", 2) end
})

FarmTab:CreateButton({
    Name = "Разовый сбор всего",
    Callback = function()
        local c = 0
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then fireproximityprompt(obj); c=c+1 end
                if obj:IsA("ClickDetector")   then fireclickdetector(obj);   c=c+1 end
            end
        end)
        Notify("Farm", "Собрано: "..c, 3)
    end
})

FarmTab:CreateButton({
    Name = "Fire All Collect Remotes",
    Callback = function()
        local c = 0
        pcall(function()
            for _, v in pairs(RepStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") then
                    local n = string.lower(v.Name)
                    if string.find(n,"collect") or string.find(n,"claim") or
                       string.find(n,"money")   or string.find(n,"cash")  then
                        v:FireServer(); c=c+1
                    end
                end
            end
        end)
        Notify("Farm", "Remotes: "..c, 3)
    end
})

-- ================================================
--              VISUALS TAB UI
-- ================================================

VisualTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(v)
        getgenv().WTX.ESPEnabled = v
        if not v then
            for _, player in pairs(Players:GetPlayers()) do
                HideESP(player)
            end
        end
    end
})

VisualTab:CreateToggle({
    Name = "ESP Names",
    CurrentValue = true,
    Callback = function(v) getgenv().WTX.ESPNames = v end
})

VisualTab:CreateToggle({
    Name = "ESP Health",
    CurrentValue = true,
    Callback = function(v) getgenv().WTX.ESPHealth = v end
})

VisualTab:CreateToggle({
    Name = "ESP Distance",
    CurrentValue = true,
    Callback = function(v) getgenv().WTX.ESPDistance = v end
})

VisualTab:CreateToggle({
    Name = "ESP Team Color",
    CurrentValue = true,
    Callback = function(v) getgenv().WTX.ESPTeamColor = v end
})

VisualTab:CreateSlider({
    Name = "ESP Max Distance",
    Range = {100, 3000},
    Increment = 100,
    CurrentValue = 1500,
    Callback = function(v) getgenv().WTX.ESPMaxDist = v end
})

VisualTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Callback = function(v)
        Lighting.Ambient    = v and Color3.fromRGB(255,255,255) or Color3.fromRGB(70,70,70)
        Lighting.Brightness = v and 2 or 1
    end
})

-- ================================================
--              TELEPORTS TAB UI
-- ================================================

for name, pos in pairs(TpList) do
    local n, p = name, pos
    TpTab:CreateButton({ Name = n, Callback = function() TeleportTo(p) end })
end

TpTab:CreateButton({
    Name = "К ближайшему врагу",
    Callback = function()
        local root = GetRoot(); if not root then return end
        local best, bd = nil, math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and IsEnemy(p) then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                if r then
                    local d = (root.Position-r.Position).Magnitude
                    if d < bd then bd=d; best=p end
                end
            end
        end
        if best then TpToPlayer(best.Name)
        else Notify("TP","Враги не найдены",2) end
    end
})

TpTab:CreateButton({
    Name = "К рандомному игроку",
    Callback = function()
        local list = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then table.insert(list,p) end
        end
        if #list == 0 then Notify("TP","Нет игроков",2); return end
        TpToPlayer(list[math.random(1,#list)].Name)
    end
})

-- ================================================
--              MISC TAB UI
-- ================================================

MiscTab:CreateButton({
    Name = "Heal",
    Callback = function()
        local hum = GetHum(); if hum then hum.Health = hum.MaxHealth end
    end
})

MiscTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local hum = GetHum(); if hum then hum.Health = 0 end
    end
})

MiscTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end
})

MiscTab:CreateButton({
    Name = "List Players",
    Callback = function()
        local names = {}
        for _, p in pairs(Players:GetPlayers()) do
            table.insert(names, p.Name.." ["..(p.Team and p.Team.Name or "None").."]")
        end
        Notify("Players ("..#names..")", table.concat(names,", "), 6)
    end
})

MiscTab:CreateButton({
    Name = "Show All RemoteEvents (консоль)",
    Callback = function()
        print("[WTX] RemoteEvents:")
        for _, v in pairs(RepStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then print("  "..v:GetFullName()) end
        end
        Notify("Remotes", "Смотри консоль F9", 3)
    end
})

-- ================================================
Rayfield:Notify({
    Title    = "War Tycoon X v3",
    Content  = "Aimbot: включи и нажми Z\nESP: Drawing API (стабильный)",
    Duration = 6,
    Image    = "check"
})

end) -- конец RunKeySystem
