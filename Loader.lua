-- ================================================
--   WAR TYCOON X  |  MODERN LOADER  v3
--   Вставь ТОЛЬКО этот файл в эксплойт
-- ================================================

-- !!! ЗАМЕНИ ПОД СЕБЯ !!!
local SCRIPT_URL = "https://raw.githubusercontent.com/USERNAME/REPO/main/WTX_main.lua"
local KEY_URL    = "https://raw.githubusercontent.com/USERNAME/REPO/main/key.txt"
local VALID_KEY  = "WTX-YOURKEY-HERE"
local VERSION    = "v3.0"
local DISCORD    = "discord.gg/yourserver"
-- !!!!!!!!!!!!!!!!!!!!!!

local TweenSvc = game:GetService("TweenService")
local UIS      = game:GetService("UserInputService")
local CoreGui  = game:GetService("CoreGui")
local Players  = game:GetService("Players")
local LP       = Players.LocalPlayer

local savedFile = "WTX_savedkey.txt"
local function LoadSaved()
    if isfile and isfile(savedFile) then return readfile(savedFile) end
    return nil
end
local function SaveKey(k)
    if writefile then writefile(savedFile, k) end
end
local function FetchRemoteKey()
    local ok, r = pcall(function() return game:HttpGet(KEY_URL) end)
    if ok and r then return r:gsub("%s+","") end
    return nil
end

-- ================================================
-- GUI
-- ================================================
if CoreGui:FindFirstChild("WTX_Loader") then CoreGui:FindFirstChild("WTX_Loader"):Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name           = "WTX_Loader"
Gui.ResetOnSpawn   = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent         = CoreGui

local function Corner(r, p) local c=Instance.new("UICorner",p); c.CornerRadius=UDim.new(0,r); return c end
local function Stroke(col, th, p) local s=Instance.new("UIStroke",p); s.Color=col; s.Thickness=th; return s end
local function Grad(c0,c1,rot,p)
    local g=Instance.new("UIGradient",p)
    g.Color=ColorSequence.new(c0,c1); g.Rotation=rot; return g
end

-- Overlay
local Overlay = Instance.new("Frame")
Overlay.Size                   = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3       = Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency = 0.45
Overlay.BorderSizePixel        = 0
Overlay.ZIndex                 = 1
Overlay.Parent                 = Gui

-- Свечение за окном (blur effect через несколько слоёв)
local Glow = Instance.new("ImageLabel")
Glow.Size                   = UDim2.new(0, 600, 0, 420)
Glow.Position               = UDim2.new(0.5,-300,0.5,-210)
Glow.BackgroundTransparency = 1
Glow.Image                  = "rbxassetid://5028857084" -- radial gradient asset
Glow.ImageColor3            = Color3.fromRGB(60,100,255)
Glow.ImageTransparency      = 0.7
Glow.ZIndex                 = 1
Glow.Parent                 = Gui

-- Пульсация свечения
task.spawn(function()
    while Gui.Parent do
        TweenSvc:Create(Glow,TweenInfo.new(2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
            ImageTransparency=0.82, Size=UDim2.new(0,640,0,450)
        }):Play()
        task.wait(2)
        TweenSvc:Create(Glow,TweenInfo.new(2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
            ImageTransparency=0.68, Size=UDim2.new(0,580,0,400)
        }):Play()
        task.wait(2)
    end
end)

-- Главный контейнер
local Main = Instance.new("Frame")
Main.Size                   = UDim2.new(0,480,0,320)
Main.Position               = UDim2.new(0.5,-240,0.55,-160)
Main.BackgroundColor3       = Color3.fromRGB(10,10,16)
Main.BackgroundTransparency = 1
Main.BorderSizePixel        = 0
Main.ZIndex                 = 2
Main.Parent                 = Gui
Corner(12, Main)

-- Градиентный фон
local BgGrad = Instance.new("UIGradient", Main)
BgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(14,14,24)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10,10,18)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(16,12,26)),
})
BgGrad.Rotation = 135

-- Граница с градиентом
local BorderFrame = Instance.new("Frame")
BorderFrame.Size             = UDim2.new(1,2,1,2)
BorderFrame.Position         = UDim2.new(0,-1,0,-1)
BorderFrame.BackgroundColor3 = Color3.fromRGB(80,120,255)
BorderFrame.BorderSizePixel  = 0
BorderFrame.ZIndex           = 1
BorderFrame.Parent           = Main
Corner(13, BorderFrame)
Grad(Color3.fromRGB(60,100,255), Color3.fromRGB(140,60,255), 135, BorderFrame)

-- Перекрываем нижний слой
local BgCover = Instance.new("Frame")
BgCover.Size             = UDim2.new(1,0,1,0)
BgCover.BackgroundColor3 = Color3.fromRGB(10,10,16)
BgCover.BorderSizePixel  = 0
BgCover.ZIndex           = 2
BgCover.Parent           = Main
Corner(12, BgCover)
local BgCoverGrad = Instance.new("UIGradient", BgCover)
BgCoverGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(14,14,24)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(16,12,26)),
})
BgCoverGrad.Rotation = 135

-- Верхний градиентный блик
local TopGlow = Instance.new("Frame")
TopGlow.Size             = UDim2.new(1,0,0,80)
TopGlow.BackgroundColor3 = Color3.fromRGB(70,100,255)
TopGlow.BackgroundTransparency = 0.88
TopGlow.BorderSizePixel  = 0
TopGlow.ZIndex           = 3
TopGlow.Parent           = Main
Corner(12, TopGlow)
Grad(Color3.fromRGB(80,120,255), Color3.fromRGB(10,10,16), 180, TopGlow)

-- Анимация появления
TweenSvc:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),{
    Position              = UDim2.new(0.5,-240,0.5,-160),
    BackgroundTransparency = 0
}):Play()
TweenSvc:Create(BgCover, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),{
    BackgroundTransparency = 0
}):Play()

-- ── ЛОГОТИП ──
-- Анимированное свечение за текстом
local LogoGlow = Instance.new("TextLabel")
LogoGlow.Size               = UDim2.new(1,0,0,48)
LogoGlow.Position           = UDim2.new(0,0,0,22)
LogoGlow.BackgroundTransparency = 1
LogoGlow.Text               = "WAR TYCOON X"
LogoGlow.TextColor3         = Color3.fromRGB(80,130,255)
LogoGlow.Font               = Enum.Font.GothamBold
LogoGlow.TextSize            = 26
LogoGlow.TextTransparency   = 0.65
LogoGlow.ZIndex             = 3
LogoGlow.Parent             = Main

-- Пульсация логотипа
task.spawn(function()
    while Gui.Parent do
        TweenSvc:Create(LogoGlow,TweenInfo.new(1.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{TextTransparency=0.5}):Play()
        task.wait(1.8)
        TweenSvc:Create(LogoGlow,TweenInfo.new(1.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{TextTransparency=0.72}):Play()
        task.wait(1.8)
    end
end)

local LogoText = Instance.new("TextLabel")
LogoText.Size               = UDim2.new(1,0,0,44)
LogoText.Position           = UDim2.new(0,0,0,24)
LogoText.BackgroundTransparency = 1
LogoText.Text               = "WAR TYCOON X"
LogoText.Font               = Enum.Font.GothamBold
LogoText.TextSize            = 26
LogoText.ZIndex             = 4
LogoText.Parent             = Main
-- Градиент текста (через UIGradient на TextLabel)
local LogoGrad = Instance.new("UIGradient", LogoText)
LogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(160,190,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(160,190,255)),
})
LogoGrad.Rotation = 0

-- Анимация градиента логотипа (shimmer)
task.spawn(function()
    local offset = 0
    while Gui.Parent do
        task.wait(0.016)
        offset = (offset + 0.008) % 1
        LogoGrad.Offset = Vector2.new(math.sin(offset * math.pi * 2) * 0.3, 0)
    end
end)

-- Версия badge
local VerBadge = Instance.new("Frame")
VerBadge.Size             = UDim2.new(0,52,0,18)
VerBadge.Position         = UDim2.new(1,-66,0,32)
VerBadge.BackgroundColor3 = Color3.fromRGB(60,90,200)
VerBadge.BorderSizePixel  = 0
VerBadge.ZIndex           = 5
VerBadge.Parent           = Main
Corner(9, VerBadge)
Grad(Color3.fromRGB(50,80,200), Color3.fromRGB(100,130,255), 90, VerBadge)

local VerText = Instance.new("TextLabel", VerBadge)
VerText.Size               = UDim2.new(1,0,1,0)
VerText.BackgroundTransparency = 1
VerText.Text               = VERSION
VerText.TextColor3         = Color3.fromRGB(200,220,255)
VerText.Font               = Enum.Font.GothamBold
VerText.TextSize            = 10
VerText.ZIndex             = 6

-- Subtitle
local SubText = Instance.new("TextLabel")
SubText.Size               = UDim2.new(1,-32,0,18)
SubText.Position           = UDim2.new(0,16,0,66)
SubText.BackgroundTransparency = 1
SubText.Text               = "by SWare  ·  "..DISCORD
SubText.TextColor3         = Color3.fromRGB(60,60,90)
SubText.Font               = Enum.Font.Gotham
SubText.TextSize            = 11
SubText.TextXAlignment     = Enum.TextXAlignment.Left
SubText.ZIndex             = 4
SubText.Parent             = Main

-- Разделитель с градиентом
local Div = Instance.new("Frame")
Div.Size             = UDim2.new(1,-32,0,1)
Div.Position         = UDim2.new(0,16,0,92)
Div.BackgroundColor3 = Color3.fromRGB(255,255,255)
Div.BackgroundTransparency = 0
Div.BorderSizePixel  = 0
Div.ZIndex           = 4
Div.Parent           = Main
Grad(Color3.fromRGB(10,10,18), Color3.fromRGB(80,110,255), 0, Div)
-- Второй градиент с другой стороны через доп Frame
local Div2 = Instance.new("Frame")
Div2.Size             = UDim2.new(0.5,0,1,0)
Div2.Position         = UDim2.new(0.5,0,0,0)
Div2.BackgroundColor3 = Color3.fromRGB(255,255,255)
Div2.BorderSizePixel  = 0
Div2.ZIndex           = 4
Div2.Parent           = Div
Grad(Color3.fromRGB(80,110,255), Color3.fromRGB(10,10,18), 0, Div2)

-- ── INPUT ──
local InputWrap = Instance.new("Frame")
InputWrap.Size             = UDim2.new(1,-32,0,46)
InputWrap.Position         = UDim2.new(0,16,0,106)
InputWrap.BackgroundColor3 = Color3.fromRGB(18,18,28)
InputWrap.BorderSizePixel  = 0
InputWrap.ZIndex           = 4
InputWrap.Parent           = Main
Corner(8, InputWrap)
Grad(Color3.fromRGB(20,20,32), Color3.fromRGB(15,15,24), 90, InputWrap)
local iStroke = Stroke(Color3.fromRGB(40,40,65), 1, InputWrap)

-- Иконка
local KIcon = Instance.new("TextLabel", InputWrap)
KIcon.Size               = UDim2.new(0,40,1,0)
KIcon.BackgroundTransparency = 1
KIcon.Text               = "🔑"
KIcon.TextSize            = 16
KIcon.ZIndex             = 5

local InputField = Instance.new("TextBox", InputWrap)
InputField.Size              = UDim2.new(1,-48,1,0)
InputField.Position          = UDim2.new(0,40,0,0)
InputField.BackgroundTransparency = 1
InputField.Text              = ""
InputField.PlaceholderText   = "Введи ключ доступа..."
InputField.TextColor3        = Color3.fromRGB(200,210,255)
InputField.PlaceholderColor3 = Color3.fromRGB(50,50,80)
InputField.Font              = Enum.Font.Gotham
InputField.TextSize           = 13
InputField.TextXAlignment    = Enum.TextXAlignment.Left
InputField.ClearTextOnFocus  = false
InputField.ZIndex            = 5

InputField.Focused:Connect(function()
    TweenSvc:Create(iStroke,TweenInfo.new(0.2),{Color=Color3.fromRGB(90,130,255)}):Play()
    TweenSvc:Create(InputWrap,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(22,22,36)}):Play()
end)
InputField.FocusLost:Connect(function()
    TweenSvc:Create(iStroke,TweenInfo.new(0.2),{Color=Color3.fromRGB(40,40,65)}):Play()
    TweenSvc:Create(InputWrap,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(18,18,28)}):Play()
end)

-- ── КНОПКА ──
local Btn = Instance.new("TextButton")
Btn.Size             = UDim2.new(1,-32,0,42)
Btn.Position         = UDim2.new(0,16,0,164)
Btn.BackgroundColor3 = Color3.fromRGB(55,90,200)
Btn.BorderSizePixel  = 0
Btn.Text             = "ЗАГРУЗИТЬ"
Btn.TextColor3       = Color3.fromRGB(220,230,255)
Btn.Font             = Enum.Font.GothamBold
Btn.TextSize          = 13
Btn.ZIndex           = 4
Btn.Parent           = Main
Corner(8, Btn)
Grad(Color3.fromRGB(50,85,210), Color3.fromRGB(90,130,255), 90, Btn)

-- Свечение кнопки
local BtnGlowFrame = Instance.new("Frame")
BtnGlowFrame.Size             = UDim2.new(1,20,1,20)
BtnGlowFrame.Position         = UDim2.new(0,-10,0,-10)
BtnGlowFrame.BackgroundColor3 = Color3.fromRGB(70,110,255)
BtnGlowFrame.BackgroundTransparency = 0.85
BtnGlowFrame.BorderSizePixel  = 0
BtnGlowFrame.ZIndex           = 3
BtnGlowFrame.Parent           = Btn
Corner(14, BtnGlowFrame)

Btn.MouseEnter:Connect(function()
    TweenSvc:Create(Btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(75,115,240)}):Play()
    TweenSvc:Create(BtnGlowFrame,TweenInfo.new(0.15),{BackgroundTransparency=0.75}):Play()
end)
Btn.MouseLeave:Connect(function()
    TweenSvc:Create(Btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(55,90,200)}):Play()
    TweenSvc:Create(BtnGlowFrame,TweenInfo.new(0.15),{BackgroundTransparency=0.85}):Play()
end)

-- ── ПРОГРЕСС БАР ──
local ProgBg = Instance.new("Frame")
ProgBg.Size             = UDim2.new(1,-32,0,5)
ProgBg.Position         = UDim2.new(0,16,0,220)
ProgBg.BackgroundColor3 = Color3.fromRGB(22,22,35)
ProgBg.BorderSizePixel  = 0
ProgBg.ZIndex           = 4
ProgBg.Parent           = Main
Corner(3, ProgBg)

local ProgFill = Instance.new("Frame")
ProgFill.Size             = UDim2.new(0,0,1,0)
ProgFill.BackgroundColor3 = Color3.fromRGB(80,130,255)
ProgFill.BorderSizePixel  = 0
ProgFill.ZIndex           = 5
ProgFill.Parent           = ProgBg
Corner(3, ProgFill)
Grad(Color3.fromRGB(60,100,240), Color3.fromRGB(140,180,255), 0, ProgFill)

-- Свечение прогресс бара
local ProgGlow = Instance.new("Frame")
ProgGlow.Size             = UDim2.new(1,0,0,12)
ProgGlow.Position         = UDim2.new(0,0,0.5,-6)
ProgGlow.BackgroundColor3 = Color3.fromRGB(90,140,255)
ProgGlow.BackgroundTransparency = 0.75
ProgGlow.BorderSizePixel  = 0
ProgGlow.ZIndex           = 4
ProgGlow.Parent           = ProgFill
Corner(6, ProgGlow)

-- ── СТАТУС ──
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size               = UDim2.new(1,-32,0,16)
StatusLabel.Position           = UDim2.new(0,16,0,232)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text               = "Ожидание..."
StatusLabel.TextColor3         = Color3.fromRGB(55,55,85)
StatusLabel.Font               = Enum.Font.Gotham
StatusLabel.TextSize            = 10
StatusLabel.TextXAlignment     = Enum.TextXAlignment.Left
StatusLabel.ZIndex             = 4
StatusLabel.Parent             = Main

-- Анимированные точки
local DotsLabel = Instance.new("TextLabel")
DotsLabel.Size               = UDim2.new(1,-32,0,16)
DotsLabel.Position           = UDim2.new(0,16,0,232)
DotsLabel.BackgroundTransparency = 1
DotsLabel.Text               = ""
DotsLabel.TextColor3         = Color3.fromRGB(80,120,255)
DotsLabel.Font               = Enum.Font.GothamBold
DotsLabel.TextSize            = 10
DotsLabel.TextXAlignment     = Enum.TextXAlignment.Right
DotsLabel.ZIndex             = 4
DotsLabel.Parent             = Main

-- Разделитель снизу
local DivBot = Instance.new("Frame")
DivBot.Size             = UDim2.new(1,-32,0,1)
DivBot.Position         = UDim2.new(0,16,0,255)
DivBot.BackgroundColor3 = Color3.fromRGB(255,255,255)
DivBot.BackgroundTransparency = 0.94
DivBot.BorderSizePixel  = 0
DivBot.ZIndex           = 4
DivBot.Parent           = Main

-- Нижняя строка
local FootLeft = Instance.new("TextLabel")
FootLeft.Size               = UDim2.new(0.5,0,0,16)
FootLeft.Position           = UDim2.new(0,16,0,264)
FootLeft.BackgroundTransparency = 1
FootLeft.Text               = "👤 "..LP.Name
FootLeft.TextColor3         = Color3.fromRGB(45,45,70)
FootLeft.Font               = Enum.Font.Gotham
FootLeft.TextSize            = 10
FootLeft.TextXAlignment     = Enum.TextXAlignment.Left
FootLeft.ZIndex             = 4
FootLeft.Parent             = Main

local FootRight = Instance.new("TextLabel")
FootRight.Size               = UDim2.new(0.5,-16,0,16)
FootRight.Position           = UDim2.new(0.5,0,0,264)
FootRight.BackgroundTransparency = 1
FootRight.Text               = "War Tycoon X  "..VERSION
FootRight.TextColor3         = Color3.fromRGB(45,45,70)
FootRight.Font               = Enum.Font.Gotham
FootRight.TextSize            = 10
FootRight.TextXAlignment     = Enum.TextXAlignment.Right
FootRight.ZIndex             = 4
FootRight.Parent             = Main

-- ================================================
-- ЛОГИКА
-- ================================================

local dotsRunning = false
local dotsSeq = {"·  ","·· ","···","   "}
task.spawn(function()
    local i = 1
    while Gui.Parent do
        task.wait(0.3)
        if dotsRunning then
            DotsLabel.Text = dotsSeq[i]
            i = i % #dotsSeq + 1
        else
            DotsLabel.Text = ""; i = 1
        end
    end
end)

local function SetStatus(txt, col)
    StatusLabel.Text       = txt
    StatusLabel.TextColor3 = col or Color3.fromRGB(100,100,140)
end

local function SetProgress(pct, dur)
    TweenSvc:Create(ProgFill, TweenInfo.new(dur or 0.4, Enum.EasingStyle.Quart),{
        Size = UDim2.new(pct,0,1,0)
    }):Play()
end

local function ShakeInput()
    local orig = InputWrap.Position
    for _ = 1,3 do
        TweenSvc:Create(InputWrap,TweenInfo.new(0.04),{Position=UDim2.new(orig.X.Scale,orig.X.Offset+8,orig.Y.Scale,orig.Y.Offset)}):Play()
        task.wait(0.04)
        TweenSvc:Create(InputWrap,TweenInfo.new(0.04),{Position=UDim2.new(orig.X.Scale,orig.X.Offset-8,orig.Y.Scale,orig.Y.Offset)}):Play()
        task.wait(0.04)
    end
    TweenSvc:Create(InputWrap,TweenInfo.new(0.04),{Position=orig}):Play()
end

local function CloseLoader()
    TweenSvc:Create(Glow,TweenInfo.new(0.4),{ImageTransparency=1}):Play()
    TweenSvc:Create(Main,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{
        Position              = UDim2.new(0.5,-240,0.44,-160),
        BackgroundTransparency = 1
    }):Play()
    TweenSvc:Create(BgCover,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{
        BackgroundTransparency = 1
    }):Play()
    TweenSvc:Create(Overlay,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
    task.wait(0.45)
    Gui:Destroy()
end

local function StartLoad(key)
    Btn.Active = false
    Btn.Text   = "ЗАГРУЗКА..."
    TweenSvc:Create(Btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(30,30,50)}):Play()
    dotsRunning = true

    -- Шаг 1: Проверка ключа
    SetStatus("Проверка ключа...", Color3.fromRGB(100,100,160))
    SetProgress(0.12, 0.3)
    task.wait(0.55)

    local remoteKey = FetchRemoteKey()
    if remoteKey == nil then
        SetStatus("⚠  GitHub недоступен — локальная проверка", Color3.fromRGB(255,190,60))
        remoteKey = VALID_KEY
        task.wait(0.35)
    end

    if key ~= remoteKey or key ~= VALID_KEY then
        dotsRunning = false
        SetProgress(0, 0.25)
        SetStatus("✗  Неверный ключ", Color3.fromRGB(255,70,80))
        TweenSvc:Create(iStroke,TweenInfo.new(0.15),{Color=Color3.fromRGB(220,50,60)}):Play()
        TweenSvc:Create(Btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(55,90,200)}):Play()
        Btn.Text   = "ЗАГРУЗИТЬ"
        Btn.Active = true
        task.spawn(ShakeInput)
        task.wait(2.2)
        TweenSvc:Create(iStroke,TweenInfo.new(0.2),{Color=Color3.fromRGB(40,40,65)}):Play()
        SetStatus("Ожидание...", Color3.fromRGB(55,55,85))
        return
    end

    -- Ключ верный
    SaveKey(key)
    SetStatus("✓  Ключ принят", Color3.fromRGB(80,220,110))
    TweenSvc:Create(iStroke,TweenInfo.new(0.15),{Color=Color3.fromRGB(60,200,90)}):Play()
    TweenSvc:Create(ProgFill,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(60,200,90)}):Play()
    SetProgress(0.35, 0.4)
    task.wait(0.55)

    -- Шаг 2: Библиотеки
    TweenSvc:Create(ProgFill,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(80,130,255)}):Play()
    SetStatus("Загрузка библиотек...", Color3.fromRGB(100,100,160))
    SetProgress(0.58, 0.45)
    task.wait(0.5)

    -- Шаг 3: Основной скрипт
    SetStatus("Загрузка War Tycoon X...", Color3.fromRGB(100,100,160))
    SetProgress(0.78, 0.35)
    task.wait(0.35)

    local ok, err = pcall(function()
        loadstring(game:HttpGet(SCRIPT_URL))()
    end)

    if not ok then
        if isfile and isfile("WTX_main.lua") then
            SetStatus("⚠  GitHub недоступен — загрузка локально...", Color3.fromRGB(255,190,60))
            pcall(function() loadstring(readfile("WTX_main.lua"))() end)
        else
            dotsRunning = false
            SetStatus("✗  Ошибка: "..tostring(err):sub(1,44), Color3.fromRGB(255,70,80))
            SetProgress(0, 0.3)
            Btn.Text   = "ЗАГРУЗИТЬ"
            Btn.Active = true
            TweenSvc:Create(Btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(55,90,200)}):Play()
            return
        end
    end

    -- Готово!
    SetStatus("✓  Загружено!", Color3.fromRGB(80,220,110))
    SetProgress(1.0, 0.3)
    TweenSvc:Create(ProgFill,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(60,200,90)}):Play()
    Btn.Text             = "✓  ГОТОВО"
    TweenSvc:Create(Btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(40,140,70)}):Play()
    dotsRunning = false
    DotsLabel.Text = ""

    -- Финальная вспышка свечения
    TweenSvc:Create(Glow,TweenInfo.new(0.3),{ImageTransparency=0.4, ImageColor3=Color3.fromRGB(60,200,100)}):Play()
    task.wait(0.9)
    CloseLoader()
end

-- Автопроверка сохранённого ключа
task.spawn(function()
    task.wait(0.55)
    local saved = LoadSaved()
    if saved and saved ~= "" then
        InputField.Text = saved
        SetStatus("Найден сохранённый ключ...", Color3.fromRGB(80,100,200))
        task.wait(0.3)
        StartLoad(saved)
    end
end)

-- Кнопка
Btn.MouseButton1Click:Connect(function()
    local k = InputField.Text:gsub("%s+","")
    if k == "" then
        SetStatus("⚠  Введи ключ!", Color3.fromRGB(255,190,60))
        task.spawn(ShakeInput); return
    end
    StartLoad(k)
end)

-- Enter
InputField.FocusLost:Connect(function(enter)
    if enter then
        local k = InputField.Text:gsub("%s+","")
        if k ~= "" then StartLoad(k) end
    end
end)
