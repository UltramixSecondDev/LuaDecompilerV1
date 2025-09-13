local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "DecompilerIDE V1.3"
gui.Parent = playerGui
gui.ResetOnSpawn = false

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 1150, 0, 450)
main.Position = UDim2.new(0.5, -375, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 1

-- Header
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.Text = "Decompiler V1.2"
header.TextSize = 7
header.TextXAlignment = Enum.TextXAlignment.Left
header.TextColor3 = Color3.fromRGB(255, 255, 255)
local padding = Instance.new("UIPadding", header)
padding.PaddingLeft = UDim.new(0, 10)

-- Draggable solo por header
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        local startPos = main.Position
        local startInput = input.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then return end
            local delta = input.Position - startInput
            main.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        end)
    end
end)

-- Search Box
local searchBox = Instance.new("TextBox", main)
searchBox.Size = UDim2.new(0.4, -35, 0, 25)
searchBox.Position = UDim2.new(0, 5, 0, 35)
searchBox.PlaceholderText = "Search Script..."
searchBox.TextSize = 11
searchBox.ClearTextOnFocus = false
searchBox.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
searchBox.TextColor3 = Color3.fromRGB(240, 240, 240)
searchBox.Text = ""

-- Left lis
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(0.4, -10, 1, -70)
scroll.Position = UDim2.new(0, 5, 0, 65)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 0
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Custom ScrollBar
local scrollBarContainer = Instance.new("Frame", main)
scrollBarContainer.Size = UDim2.new(0, 20, 1, -70)
scrollBarContainer.Position = UDim2.new(0.4, -20, 0, 65)
scrollBarContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local scrollHandle = Instance.new("Frame", scrollBarContainer)
scrollHandle.Size = UDim2.new(1, 0, 0.2, 0)
scrollHandle.Position = UDim2.new(0, 0, 0, 0)
scrollHandle.BackgroundColor3 = Color3.fromRGB(32, 32, 32)

-- Right code area
local codeFrame = Instance.new("ScrollingFrame", main)
codeFrame.Size = UDim2.new(0.6, -15, 1, -70)
codeFrame.Position = UDim2.new(0.4, 10, 0, 35)
codeFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
codeFrame.BorderSizePixel = 1
codeFrame.ScrollBarThickness = 0
codeFrame.ClipsDescendants = true

local codeBarContainer = Instance.new("Frame", main)
codeBarContainer.Size = UDim2.new(0, 20, 1, -70)
codeBarContainer.Position = UDim2.new(1, -20, 0, 35)
codeBarContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local codeHandle = Instance.new("Frame", codeBarContainer)
codeHandle.Size = UDim2.new(1, 0, 0.1, 0)
codeHandle.Position = UDim2.new(0, 0, 0, 0)
codeHandle.BackgroundColor3 = Color3.fromRGB(32, 32, 32)

-- TextBox para código
local codeBox = Instance.new("TextBox", codeFrame)
codeBox.Size = UDim2.new(1, -10, 0, 100)
codeBox.Position = UDim2.new(0, 5, 0, 5)
codeBox.ClearTextOnFocus = false
codeBox.MultiLine = true
codeBox.Font = Enum.Font.RobotoMono
codeBox.TextSize = 13
codeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
codeBox.BackgroundTransparency = 1
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.Text = "-- The text box will not show the entire script, once copied you will have the complete script "
codeBox.Interactable = false

-- Buttons
local copyBtn = Instance.new("TextButton", main)
copyBtn.Size = UDim2.new(0.28, -5, 0, 25)
copyBtn.Position = UDim2.new(0.4, 10, 1, -30)
copyBtn.Text = "Copy to Clipboard"
copyBtn.TextSize = 8
copyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local refreshBtn = Instance.new("TextButton", main)
refreshBtn.Size = UDim2.new(0.28, -5, 0, 25)
refreshBtn.Position = UDim2.new(0.68, 5, 1, -30)
refreshBtn.Text = "Refresh"
refreshBtn.TextSize = 8
refreshBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

copyBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(codeBox.Text) end)
end)

-- Random decompiler messages
local MemeStrings = {
    " boo 👻", " Exceeded decompiler timeout.", " DECOMPILED BY ULTRAMIXS DECOMPILER",
    " DISASSEMBLED...", " Decompiled with a cool decompiler.",
    " 𝓓𝓮𝓬𝓸𝓶𝓹𝓲𝓵𝓮𝓭 𝓫𝔂 𝓯𝓻𝓮𝓪𝓴𝔂 𝓭𝓮𝓬𝓸𝓶𝓹𝓲𝓵𝓮𝓻",
    "Decompiler is slow, removed right now :(", " NOTE: Currently in beta!", " params : ...",
    " " .. os.date(), " your advertisement could be here"
}

local function getRandomMessage()
    return "--"..MemeStrings[math.random(#MemeStrings)].."\n\n"
end

-- Obtener scripts
local function obtenerScripts(root)
    local out={}
    for _,obj in pairs(root:GetDescendants()) do
        if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            table.insert(out,obj)
        end
    end
    return out
end

-- Mostrar código en el TextBox
local function setCodeWithTimeout(txt)
    codeBox.Text = getRandomMessage()
    local chunkSize = 2000
    local i = 1
    while i <= #txt do
        local chunk = txt:sub(i, i+chunkSize-1)
        codeBox.Text = codeBox.Text .. chunk
        local lines = select(2, codeBox.Text:gsub("\n","\n"))+1
        local lineHeight = math.max(18, math.floor(codeBox.TextSize*1.6))
        codeBox.Size = UDim2.new(1,-10,0,lineHeight*lines+10)
        codeFrame.CanvasSize = UDim2.new(0,0,0,codeBox.Size.Y.Offset+10)
        i = i + chunkSize
        task.wait(0.05)
    end
end

local function agregarScriptBoton(scr)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)  -- tamaño relativo al grid
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0
    btn.Text = ""  -- dejamos el texto vacío, el nombre irá en Label
    btn.Parent = scroll

    -- Icono del script
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0.5, -25, 0, 5)
    icon.Image = "rbxassetid://8253773978"
    icon.BackgroundTransparency = 1
    icon.Parent = btn

    -- Nombre del script
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -10, 0, 30)
    nameLabel.Position = UDim2.new(0, 5, 0, 50)
    nameLabel.Text = scr.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextSize = 10
    nameLabel.TextWrapped = true
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    nameLabel.Parent = btn

    -- Click para mostrar el código
    btn.MouseButton1Click:Connect(function()
        local content = "-- vacío"
        if type(decompile) == "function" then
            local ok, res = pcall(function() return decompile(scr) end)
            if ok and res then content = res else content = "-- Error decompiling" end
        else
            local ok, res = pcall(function() return scr.Source end)
            if ok and res then content = res end
        end
        setCodeWithTimeout(content)
    end)
end

-- Refrescar lista de scripts con UIGridLayout
local function refrescarLista(filtro)
    scroll:ClearAllChildren()

    local grid = Instance.new("UIGridLayout")
    grid.Parent = scroll
    grid.CellSize = UDim2.new(0, 100, 0, 90)  -- tamaño de cada botón
    grid.CellPadding = UDim2.new(0, 5, 0, 5)  -- espacio entre botones
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    grid.FillDirection = Enum.FillDirection.Horizontal

    local services = {
        game:GetService("Workspace"),
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterPlayer"),
        game:GetService("ServerStorage"),
        game:GetService("StarterGui"),
        game:GetService("Players"),
        game:GetService("Lighting"),
    }

    for _, service in pairs(services) do
        local scripts = obtenerScripts(service)
        for _, scr in pairs(scripts) do
            if not filtro or scr.Name:lower():find(filtro:lower()) then
                agregarScriptBoton(scr)
            end
        end
    end
end

-- Inicializar lista completa
refrescarLista()

-- Refrescar al escribir en el searchBox
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    refrescarLista(searchBox.Text)
end)

-- Función para actualizar el handle de la barra de scroll izquierda
local function updateScrollHandle()
    local frameSize = scroll.AbsoluteSize.Y
    local canvasSize = scroll.CanvasSize.Y.Offset
    if canvasSize <= frameSize then
        scrollHandle.Size = UDim2.new(0, 25, 0, 10)
        scrollHandle.Position = UDim2.new(0, 0, 0, 0)
    else
        local handleHeight = frameSize / canvasSize
        scrollHandle.Size = UDim2.new(1, 0, handleHeight, 0)
        scrollHandle.Position = UDim2.new(0, 0, scroll.CanvasPosition.Y / canvasSize, 0)
    end
end

scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(updateScrollHandle)
scroll:GetPropertyChangedSignal("CanvasSize"):Connect(updateScrollHandle)
RunService.RenderStepped:Connect(updateScrollHandle)

-- Función para actualizar el handle de la barra de scroll derecha (código)
local function updateCodeHandle()
    local frameSize = codeFrame.AbsoluteSize.Y
    local canvasSize = codeFrame.CanvasSize.Y.Offset
    if canvasSize <= frameSize then
        codeHandle.Size = UDim2.new(1, 0, 1, 0)
        codeHandle.Position = UDim2.new(0, 0, 0, 0)
    else
        local handleHeight = frameSize / canvasSize
        codeHandle.Size = UDim2.new(1, 0, handleHeight, 0)
        codeHandle.Position = UDim2.new(0, 0, codeFrame.CanvasPosition.Y / canvasSize, 0)
    end
end

codeFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(updateCodeHandle)
codeFrame:GetPropertyChangedSignal("CanvasSize"):Connect(updateCodeHandle)
RunService.RenderStepped:Connect(updateCodeHandle)
