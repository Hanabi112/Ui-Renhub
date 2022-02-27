local library = {RainbowColorValue = 0, HueSelectionPosition = 0}
local PresetColor = Color3.fromRGB(255, 0, 0)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CloseBind = Enum.KeyCode.RightControl

local ScreenGui = Instance.new("ScreenGui")
local TabButtonLayout = Instance.new("UIListLayout")

ScreenGui.Name = "NewUi"
ScreenGui.Parent = game.CoreGui
local uitoggled = false
UserInputService.InputBegan:Connect(function(io, p)
    if io.KeyCode == Enum.KeyCode.RightControl then
        if uitoggled == false then
            ScreenGui.Enabled = false
            uitoggled = true
        else
            ScreenGui.Enabled = true
            uitoggled = false
        end
    end
end)
          
coroutine.wrap(
    function()
        while wait() do
            library.RainbowColorValue = library.RainbowColorValue + 1 / 255
            library.HueSelectionPosition = library.HueSelectionPosition + 1

            if library.RainbowColorValue >= 1 then
                library.RainbowColorValue = 0
            end

            if library.HueSelectionPosition == 80 then
                library.HueSelectionPosition = 0
            end
        end
    end
)()

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        object.Position = pos
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                input.UserInputType == Enum.UserInputType.Touch
            then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

local function RippleEffect(object)
    spawn(function()
        local Ripple = Instance.new("ImageLabel")
        Ripple.Name = "Ripple"
        Ripple.Parent = object
        Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Ripple.BackgroundTransparency = 1.000
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://2708891598"
        Ripple.ImageTransparency = 0.800
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.Position = UDim2.new((Mouse.X - Ripple.AbsolutePosition.X) / object.AbsoluteSize.X, 0, (Mouse.Y - Ripple.AbsolutePosition.Y) / object.AbsoluteSize.Y, 0)
        TweenService:Create(Ripple, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(-5.5, 0, -15, 0), Size = UDim2.new(12, 0, 30, 0)}):Play()
        wait(0.75)
        TweenService:Create(Ripple, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
        wait(1)
        Ripple:Destroy()
    end)
end

function library:Window(name,game)
    if getgenv().Theme ~= nil then
        ColorII = getgenv().Theme.Tab.Color

        ColorIII = getgenv().Theme.Line.LeftColor
        ColorIIII = getgenv().Theme.Line.RightColor
    
        ColorIIIII = getgenv().Theme.Toggle.LeftColor
        ColorIIIIII = getgenv().Theme.Toggle.RightColor
    
        ColorIIIIIII = getgenv().Theme.Slider.LeftColor
        ColorIIIIIIII = getgenv().Theme.Slider.RightColor
    else
        ColorII = Color3.fromRGB(255, 129, 129)

        ColorIII = Color3.fromRGB(255, 129, 129)
        ColorIIII = Color3.fromRGB(255, 125, 125)
    
        ColorIIIII = Color3.fromRGB(255, 129, 129)
        ColorIIIIII = Color3.fromRGB(255, 125, 125)
    
        ColorIIIIIII = Color3.fromRGB(255, 129, 129)
        ColorIIIIIIII = Color3.fromRGB(255, 125, 125)
    end

    local Main = Instance.new("Frame")
    local MainUICorner = Instance.new("UICorner")
    local TopMain = Instance.new("Frame")
    local TopMainUICorner = Instance.new("UICorner")
    local TopMainLine = Instance.new("Frame")
    local NameHub = Instance.new("TextLabel")
    local Toggleui = Instance.new("TextLabel")
    local HideTab = Instance.new("ImageButton")
    local SizeFullSection = Instance.new("Frame")

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.5, -325, 0.5, -175)
    Main.Size = UDim2.new(0, 650, 0, 375)

    MainUICorner.Name = "MainUICorner"
    MainUICorner.Parent = Main

    TopMain.Name = "TopMain"
    TopMain.Parent = Main
    TopMain.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TopMain.Size = UDim2.new(0, 650, 0, 30)

    MakeDraggable(TopMain, Main)

    TopMainUICorner.Name = "TopMainUICorner"
    TopMainUICorner.Parent = TopMain

    TopMainLine.Name = "TopMainLine"
    TopMainLine.Parent = TopMain
    TopMainLine.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TopMainLine.BorderSizePixel = 0
    TopMainLine.Position = UDim2.new(0, 0, 0.833333313, 0)
    TopMainLine.Size = UDim2.new(1, 0, 0, 5)

    NameHub.Name = "NameHub"
    NameHub.Parent = TopMain
    NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameHub.BackgroundTransparency = 1.000
    NameHub.Position = UDim2.new(0.0507692285, 0, 0, 0)
    NameHub.Size = UDim2.new(0, 160, 0, 30)
    NameHub.Font = Enum.Font.SourceSansSemibold
    NameHub.RichText =  true
    NameHub.Text = "<font color=\"rgb(".. math.floor(ColorII.R * 255) .. "," .. math.floor(ColorII.G * 255) .. ",".. math.floor(ColorII.B * 255) ..")\"> " .. name .. " </font> Hub | " .. game
    NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameHub.TextSize = 25.000
    NameHub.TextXAlignment = Enum.TextXAlignment.Left

    Toggleui.Name = "Toggleui"
    Toggleui.Parent = TopMain
    Toggleui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Toggleui.BackgroundTransparency = 1.000
    Toggleui.Position = UDim2.new(0.803076923, 0, 0, 0)
    Toggleui.Size = UDim2.new(0, 120, 0, 30)
    Toggleui.Font = Enum.Font.SourceSansSemibold
    Toggleui.Text = "[ Right Control ]"
    Toggleui.TextColor3 = Color3.fromRGB(120, 120, 120)
    Toggleui.TextSize = 20.000

    HideTab.Name = "HideTab"
    HideTab.Parent = TopMain
    HideTab.BackgroundTransparency = 1.000
    HideTab.Position = UDim2.new(0.0125000002, 0, 0.0670000017, 0)
    HideTab.Size = UDim2.new(0, 25, 0, 25)
    HideTab.ZIndex = 2
    HideTab.Image = "rbxassetid://3926305904"
    HideTab.ImageRectOffset = Vector2.new(484, 204)
    HideTab.ImageRectSize = Vector2.new(36, 36)

    SizeFullSection.Name = "SizeFullSection"
    SizeFullSection.Parent = Main
    SizeFullSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SizeFullSection.BackgroundTransparency = 1.000
    SizeFullSection.Position = UDim2.new(0.192307696, 0, 0.0933333337, 0)
    SizeFullSection.Size = UDim2.new(0, 525, 0, 340)

    local Taplist = Instance.new("Frame")
    local TaplistUIListLayout = Instance.new("UIListLayout")
    local TabSet = Instance.new("TextBox")
    local MainUICorner = Instance.new("UICorner")
    local BalckGrouitList = Instance.new("ScrollingFrame")
    local BalckGrouitListUICorner = Instance.new("UICorner")
    local BalckGrouitListUIListLayout = Instance.new("UIListLayout")

    Taplist.Name = "Taplist"
    Taplist.Parent = Main
    Taplist.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Taplist.BackgroundTransparency = 1.000
    Taplist.Position = UDim2.new(0, 0, 0.0799999982, 0)
    Taplist.Size = UDim2.new(0, 130, 0, 345)

    TaplistUIListLayout.Name = "TaplistUIListLayout"
    TaplistUIListLayout.Parent = Taplist
    TaplistUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TaplistUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TaplistUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    TaplistUIListLayout.Padding = UDim.new(0, 5)

    TabSet.Name = "TabSet"
    TabSet.Parent = Taplist
    TabSet.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    TabSet.Size = UDim2.new(0, 120, 0, 25)
    TabSet.Font = Enum.Font.SourceSansSemibold
    TabSet.PlaceholderText = "Search : ..."
    TabSet.Text = ""
    TabSet.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabSet.TextSize = 18.000

    MainUICorner.Name = "MainUICorner"
    MainUICorner.Parent = TabSet

    BalckGrouitList.Name = "BalckGrouitList"
    BalckGrouitList.Parent = Taplist
    BalckGrouitList.Active = true
    BalckGrouitList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BalckGrouitList.BackgroundTransparency = 1.000
    BalckGrouitList.BorderColor3 = Color3.fromRGB(35, 35, 35)
    BalckGrouitList.Position = UDim2.new(0, 0, 0.0799999982, 0)
    BalckGrouitList.Size = UDim2.new(0, 120, 0, 305)
    BalckGrouitList.ScrollBarThickness = 1

    BalckGrouitListUICorner.Name = "BalckGrouitListUICorner"
    BalckGrouitListUICorner.Parent = BalckGrouitList

    BalckGrouitListUIListLayout.Name = "BalckGrouitListUIListLayout"
    BalckGrouitListUIListLayout.Parent = BalckGrouitList
    BalckGrouitListUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    BalckGrouitListUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    BalckGrouitListUIListLayout.Padding = UDim.new(0, 2)

    BalckGrouitListUIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        BalckGrouitList.CanvasSize = UDim2.new(0,0,0,BalckGrouitListUIListLayout.AbsoluteContentSize.Y)
    end)

    function library:Notification(name)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationFrameUICorner = Instance.new("UICorner")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")

        NotificationHold.Name = "NotificationHold"
        NotificationHold.Parent = Main
        NotificationHold.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
        NotificationHold.BackgroundTransparency = 0.700
        NotificationHold.BorderSizePixel = 0
        NotificationHold.Size = UDim2.new(1, 0, 1, 0)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000
        NotificationHold.ZIndex = 10

        TweenService:Create(
            NotificationHold,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.7}
        ):Play()

        wait(0.4)

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.498432577, 0)
        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)
        NotificationFrame.ZIndex = 11
        NotificationFrame:TweenSize(
            UDim2.new(0, 305, 0, 283),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )
        NotificationFrameUICorner.Parent = NotificationFrame

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
        OkayBtn.Position = UDim2.new(0.171131134, 0, 0.759717345, 0)
        OkayBtn.Size = UDim2.new(0, 200, 0, 42)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000
        OkayBtn.ZIndex = 11

        OkayBtnCorner.CornerRadius = UDim.new(0, 5)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(0, 200, 0, 42)
        OkayBtnTitle.Text = "Okey"
        OkayBtnTitle.Font = Enum.Font.Gotham
        OkayBtnTitle.TextColor3 = Color3.fromRGB(202, 202, 202)
        OkayBtnTitle.TextSize = 24.000
        OkayBtnTitle.ZIndex = 11

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.0559394211, 0, 0.0652336925, 0)
        NotificationTitle.Size = UDim2.new(0, 272, 0, 26)
        NotificationTitle.ZIndex = 3
        NotificationTitle.Font = Enum.Font.Gotham
        NotificationTitle.Text = "-- Notification --"
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 24.000
        NotificationTitle.ZIndex = 11

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.0670000017, 0, 0.218999997, 0)
        NotificationDesc.Size = UDim2.new(0, 274, 0, 146)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.TextSize = 20.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Center
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top
        NotificationDesc.ZIndex = 11
        NotificationDesc.Text = name

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                OkayBtn,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(34, 34, 34)}):Play()
            end
        )

        OkayBtn.MouseButton1Click:Connect(
            function()
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .6,
                    true
                )
                wait(0.4)
                TweenService:Create(
                NotificationHold,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                wait(.3)
                NotificationHold:Destroy()
            end
        )
    end

    local Tabs = {}
    function Tabs:Tab(text)
        local Tab = Instance.new("TextButton")
        local TabUICorner = Instance.new("UICorner")

        Tab.Name = "Tab"
        Tab.Parent = BalckGrouitList
        Tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Tab.Position = UDim2.new(0, 0, 0.137704924, 0)
        Tab.Size = UDim2.new(0, 115, 0, 25)
        Tab.Font = Enum.Font.SourceSansSemibold
        Tab.Text = text
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 20.000
        Tab.TextWrapped = true

        TabUICorner.Name = "TabUICorner"
        TabUICorner.Parent = Tab

        local MainSection = Instance.new("ImageLabel")
        local SectionBorder = Instance.new("ImageLabel")
        local SectionTitle = Instance.new("TextLabel")
        local SectionContent = Instance.new("ScrollingFrame")
        local SectionContentLayout = Instance.new("UIListLayout")

        MainSection.Name = "MainSection"
        MainSection.Parent = SizeFullSection
        MainSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainSection.BackgroundTransparency = 1
        MainSection.Position = UDim2.new(0.0266666673, 0, 0.0343861282, 0)
        MainSection.Size = UDim2.new(0, 503, 0, 0)
        MainSection.ZIndex = 4
        MainSection.Image = "rbxassetid://3570695787"
        MainSection.ImageColor3 = Color3.fromRGB(40, 40, 40)
        MainSection.ScaleType = Enum.ScaleType.Slice
        MainSection.SliceCenter = Rect.new(100, 100, 100, 100)
        MainSection.SliceScale = 0.050
        MainSection.Visible = false

        SectionBorder.Name = "SectionBorder"
        SectionBorder.Parent = MainSection
        SectionBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionBorder.BackgroundTransparency = 1.000
        SectionBorder.Position = UDim2.new(0, -1, 0, -1)
        SectionBorder.Size = UDim2.new(1, 2, 1, 2)
        SectionBorder.ZIndex = 3
        SectionBorder.Image = "rbxassetid://3570695787"
        SectionBorder.ScaleType = Enum.ScaleType.Slice
        SectionBorder.SliceCenter = Rect.new(100, 100, 100, 100)
        SectionBorder.SliceScale = 0.050

        SectionTitle.Name = "SectionTitle"
        SectionTitle.Parent = MainSection
        SectionTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        SectionTitle.BorderColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.BorderSizePixel = 0
        SectionTitle.Position = UDim2.new(0.0470841937, -12, 0.00880593434, -12)
        SectionTitle.ZIndex = 4
        SectionTitle.Font = Enum.Font.SourceSansBold
        SectionTitle.Text = "   "..text
        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.TextSize = 14.000
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        SectionTitle.Size = UDim2.new(0, SectionTitle.TextBounds.X + 3, 0, 22)

        SectionContent.Name = "SectionContent"
        SectionContent.Parent = MainSection
        SectionContent.Active = true
        SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionContent.BackgroundTransparency = 1.000
        SectionContent.BorderColor3 = Color3.fromRGB(27, 42, 53)
        SectionContent.BorderSizePixel = 0
        SectionContent.Position = UDim2.new(0, 0, 0.0350000001, 0)
        SectionContent.Size = UDim2.new(1, 0, 0.964999974, 0)
        SectionContent.ZIndex = 4
        SectionContent.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
        SectionContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        SectionContent.ScrollBarThickness = 4
        SectionContent.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

        function UpdateInputSearchText()
            local InputText = string.upper(TabSet.Text)
            for _,button in pairs(SectionContent:GetChildren())do
                if button:IsA("TextButton") or button:IsA("Frame") or button:IsA("TextLabel") then
                    if InputText == "" or string.find(string.upper(button.Name),InputText) ~= nil then
                        button.Visible = true
                    else
                        button.Visible = false
                    end
                end
            end
        end
        TabSet.Changed:Connect(UpdateInputSearchText)

        SectionContentLayout.Name = "SectionContentLayout"
        SectionContentLayout.Parent = SectionContent
        SectionContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectionContentLayout.Padding = UDim.new(0, 5)

        SectionContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            SectionContent.CanvasSize = UDim2.new(0,0,0,SectionContentLayout.AbsoluteContentSize.Y + 10 )
        end)

        if fspage == nil then
            fspage = true    
            MainSection.Visible = true
            TweenService:Create(MainSection, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 503, 0, 323)}):Play()
            Tab.TextColor3 = ColorII
        end

        Tab.MouseButton1Click:Connect(function()
            for i, v in next, SizeFullSection:GetChildren() do
                if v.Name == "MainSection" then
                    TweenService:Create(v, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 503, 0, 0)}):Play()
                    v.Visible = false
                end
                MainSection.Visible = true
                TweenService:Create(MainSection, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 503, 0, 323)}):Play()
            end
            for i, v in next, BalckGrouitList:GetChildren() do
                if v.Name == "Tab" then
                    TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end
                TweenService:Create(Tab, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = ColorII}):Play()
            end
        end)

        local TabElements = {}

        function TabElements:Button(text,callback)
            local NameButton = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonRounded = Instance.new("ImageLabel")
            local UICorner = Instance.new("UICorner")
            local UICorner_2 = Instance.new("UICorner")
            local touch_app = Instance.new("ImageButton")

            NameButton.Name = (text .. "Button")
            NameButton.Parent = SectionContent
            NameButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            NameButton.Position = UDim2.new(0, 0, 0.122807018, 0)
            NameButton.Size = UDim2.new(0, 475, 0, 30)
            NameButton.ZIndex = 5

            Button.Name = "Button"
            Button.Parent = NameButton
            Button.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
            Button.BackgroundTransparency = 1.000
            Button.BorderSizePixel = 0
            Button.ClipsDescendants = true
            Button.Position = UDim2.new(-0.000727273524, 0, 0, 0)
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Text = text
            Button.ZIndex = 6
            Button.Font = Enum.Font.SourceSansBold
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 15.000

            touch_app.Name = "touch_app"
            touch_app.Parent = Button
            touch_app.BackgroundTransparency = 1.000
            touch_app.LayoutOrder = 8
            touch_app.Position = UDim2.new(0.92315793, 0, 0.0666666478, 0)
            touch_app.Size = UDim2.new(0, 25, 0, 25)
            touch_app.ZIndex = 10
            touch_app.Image = "rbxassetid://3926305904"
            touch_app.ImageRectOffset = Vector2.new(84, 204)
            touch_app.ImageRectSize = Vector2.new(36, 36)

            ButtonRounded.Name = "ButtonRounded"
            ButtonRounded.Parent = Button
            ButtonRounded.Active = true
            ButtonRounded.AnchorPoint = Vector2.new(0.5, 0.5)
            ButtonRounded.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonRounded.BackgroundTransparency = 1.000
            ButtonRounded.Position = UDim2.new(0.5, 0, 0.5, 0)
            ButtonRounded.Selectable = true
            ButtonRounded.Size = UDim2.new(1, 0, 1, 0)
            ButtonRounded.ZIndex = 5
            ButtonRounded.Image = "rbxassetid://3570695787"
            ButtonRounded.ImageColor3 = Color3.fromRGB(255, 75, 75)
            ButtonRounded.ImageTransparency = 1.000
            ButtonRounded.ScaleType = Enum.ScaleType.Slice
            ButtonRounded.SliceCenter = Rect.new(100, 100, 100, 100)
            ButtonRounded.SliceScale = 0.050

            UICorner.Parent = NameButton

            UICorner_2.Parent = Button

            local Lock = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local lock = Instance.new("ImageButton")

            Lock.Name = "Lock"
            Lock.Parent = Button
            Lock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Lock.BackgroundTransparency = 0.500
            Lock.Size = UDim2.new(1, 0, 1, 0)
            Lock.ZIndex = 10
            Lock.Visible = false

            UICorner.Parent = Lock

            lock.Name = "lock"
            lock.Parent = Lock
            lock.AnchorPoint = Vector2.new(0.5, 0.5)
            lock.BackgroundTransparency = 1.000
            lock.Position = UDim2.new(0.525263131, -12, 0.899999976, -12)
            lock.Size = UDim2.new(0, 0, 0, 0)
            lock.ZIndex = 10
            lock.Image = "rbxassetid://3926305904"
            lock.ImageRectOffset = Vector2.new(4, 684)
            lock.ImageRectSize = Vector2.new(36, 36)

            Button.MouseButton1Down:Connect(function()
                if Lock.Visible == true then
                    for i = 1,3 do
                        TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 10}):Play()
                        wait(.1)
                        TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = -10}):Play()
                        wait(.1)
                    end
                    TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                else
                    RippleEffect(Button)
                    callback(Button)
                end
            end)
                                
            Button.MouseButton1Up:Connect(function()
                TweenService:Create(ButtonRounded, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            end)
                                                                        
            Button.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    TweenService:Create(ButtonRounded, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end
            end)

            local funcbutton = {}

            function funcbutton:Delete()
                NameButton:Destroy()
            end
            function funcbutton:Lock()
                Lock.Visible = true
                TweenService:Create(lock, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 25, 0, 25)}):Play()
            end
            function funcbutton:Unlock()
                TweenService:Create(lock, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                wait(.5)
                Lock.Visible = false
            end
            return funcbutton
        end

        function TabElements:Toggle(text,stats,callback)

            if stats == nil then
                stats = false
            end

            local ToggleName = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local Toggle = Instance.new("TextButton")
            local CheckboxOutline = Instance.new("ImageLabel")
            local UIGradient = Instance.new("UIGradient")
            local CheckboxTicked = Instance.new("ImageLabel")
            local UIGradient_2 = Instance.new("UIGradient")
            local TickCover = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")

            ToggleName.Name = (text .. "Toggle")
            ToggleName.Parent = SectionContent
            ToggleName.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ToggleName.Size = UDim2.new(0, 475, 0, 35)
            ToggleName.ZIndex = 5

            Title.Name = "Title"
            Title.Parent = ToggleName
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Title.Position = UDim2.new(0, 13, 0, 0)
            Title.Size = UDim2.new(0, 149, 0, 35)
            Title.ZIndex = 5
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = text
            Title.TextColor3 = Color3.fromRGB(185, 185, 185)
            Title.TextSize = 15.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            Toggle.Name = "Toggle"
            Toggle.Parent = ToggleName
            Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.BackgroundTransparency = 1.000
            Toggle.Size = UDim2.new(1, 0, 1, 0)
            Toggle.ZIndex = 5
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSansBold
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.TextSize = 14.000

            CheckboxOutline.Name = "CheckboxOutline"
            CheckboxOutline.Parent = Toggle
            CheckboxOutline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CheckboxOutline.BackgroundTransparency = 1.000
            CheckboxOutline.Position = UDim2.new(1, -35, 0.5, -12)
            CheckboxOutline.Size = UDim2.new(0, 24, 0, 24)
            CheckboxOutline.ZIndex = 5
            CheckboxOutline.Image = "http://www.roblox.com/asset/?id=5416796047"

            UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, ColorIIIII), ColorSequenceKeypoint.new(1.00, ColorIIIIII)}
            UIGradient.Parent = CheckboxOutline

            CheckboxTicked.Name = "CheckboxTicked"
            CheckboxTicked.Parent = Toggle
            CheckboxTicked.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CheckboxTicked.BackgroundTransparency = 1.000
            CheckboxTicked.Position = UDim2.new(1, -35, 0.5, -12)
            CheckboxTicked.Size = UDim2.new(0, 24, 0, 24)
            CheckboxTicked.ZIndex = 5
            CheckboxTicked.Image = "http://www.roblox.com/asset/?id=5416796675"

            UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, ColorIIIII), ColorSequenceKeypoint.new(1.00, ColorIIIIII)}
            UIGradient_2.Parent = CheckboxTicked

            TickCover.Name = "TickCover"
            TickCover.Parent = Toggle
            TickCover.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            TickCover.BorderSizePixel = 0
            TickCover.Position = UDim2.new(1, -30, 0.5, -7)
            TickCover.Size = UDim2.new(0, 14, 0, 14)
            TickCover.ZIndex = 5

            UICorner.Parent = ToggleName

            local Lock = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local lock = Instance.new("ImageButton")

            Lock.Name = "Lock"
            Lock.Parent = Toggle
            Lock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Lock.BackgroundTransparency = 0.500
            Lock.Size = UDim2.new(1, 0, 1, 0)
            Lock.ZIndex = 10
            Lock.Visible = false

            UICorner.Parent = Lock

            lock.Name = "lock"
            lock.Parent = Lock
            lock.AnchorPoint = Vector2.new(0.5, 0.5)
            lock.BackgroundTransparency = 1.000
            lock.Position = UDim2.new(0.525263131, -12, 0.899999976, -12)
            lock.Size = UDim2.new(0, 0, 0, 0)
            lock.ZIndex = 10
            lock.Image = "rbxassetid://3926305904"
            lock.ImageRectOffset = Vector2.new(4, 684)
            lock.ImageRectSize = Vector2.new(36, 36)

            local function SetState(state)
                if state then
                    TweenService:Create(Title, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, -30, 0.5, -7), Size = UDim2.new(0, 0, 0, 0)}):Play()
                elseif not state then
                    TweenService:Create(Title, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
                    TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, -30, 0.5, -7), Size = UDim2.new(0, 14, 0, 14)}):Play()
                end
                -- callback(Toggled)
            end
                                    
            if stats then
                SetState(stats)
                callback(stats)
            end

            Toggle.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        TickCover,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end
            )

            Toggle.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        TickCover,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                    ):Play()
                end
            )

            Toggle.MouseButton1Down:Connect(function()
                if Lock.Visible == true then
                    for i = 1,3 do
                        TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 10}):Play()
                        wait(.1)
                        TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = -10}):Play()
                        wait(.1)
                    end
                    TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                else
                    Toggled = not Toggled
                    SetState(Toggled)
                    callback(Toggled)
                end
            end)

            local functoggle = {}

            function functoggle:Lock()
                Lock.Visible = true
                TweenService:Create(lock, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 25, 0, 25)}):Play()
            end
            function functoggle:Unlock()
                TweenService:Create(lock, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                wait(.5)
                Lock.Visible = false
            end
            return functoggle
        end

        function TabElements:Slider(name, minimumvalue, maximumvalue, presetvalue, precisevalue, callback)
            local SliderDragging = false
            local StartingValue = presetvalue
    
            if StartingValue == nil then
                StartingValue = presetvalue
            end

            local SliderName = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local SliderBackground = Instance.new("ImageLabel")
            local SliderIndicator = Instance.new("ImageLabel")
            local UIGradient = Instance.new("UIGradient")
            local CircleSelector = Instance.new("ImageLabel")
            local UICorner = Instance.new("UICorner")
            local SliderValue = Instance.new("ImageLabel")
            local Value = Instance.new("TextBox")

            SliderName.Name = (name.."Slider")
            SliderName.Parent = SectionContent
            SliderName.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            SliderName.Position = UDim2.new(0.104166672, 0, 0.445901573, 0)
            SliderName.Size = UDim2.new(0, 475, 0, 50)
            SliderName.ZIndex = 5

            Title.Name = "Title"
            Title.Parent = SliderName
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Title.Position = UDim2.new(0, 10, 0, 0)
            Title.Size = UDim2.new(0, 121, 0, 35)
            Title.ZIndex = 5
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = name
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 15.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            SliderBackground.Name = "SliderBackground"
            SliderBackground.Parent = SliderName
            SliderBackground.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            SliderBackground.BackgroundTransparency = 1.000
            SliderBackground.Position = UDim2.new(0.0199999996, 0, 0.699999988, 0)
            SliderBackground.Size = UDim2.new(0, 450, 0, 4)
            SliderBackground.ZIndex = 5
            SliderBackground.Image = "rbxassetid://3570695787"
            SliderBackground.ImageColor3 = Color3.fromRGB(55, 55, 55)
            SliderBackground.ScaleType = Enum.ScaleType.Slice
            SliderBackground.SliceCenter = Rect.new(100, 100, 100, 100)
            SliderBackground.SliceScale = 0.150

            SliderIndicator.Name = "SliderIndicator"
            SliderIndicator.Parent = SliderBackground
            SliderIndicator.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            SliderIndicator.BackgroundTransparency = 1.000
            SliderIndicator.Size = UDim2.new(((StartingValue or minimumvalue) - minimumvalue) / (maximumvalue - minimumvalue), 0, 1, 0)
            SliderIndicator.ZIndex = 5
            SliderIndicator.Image = "rbxassetid://3570695787"
            SliderIndicator.ScaleType = Enum.ScaleType.Slice
            SliderIndicator.SliceCenter = Rect.new(100, 100, 100, 100)
            SliderIndicator.SliceScale = 0.150

            UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, ColorIIIIIII), ColorSequenceKeypoint.new(1.00, ColorIIIIIIII)}
            UIGradient.Parent = SliderIndicator

            CircleSelector.Name = "CircleSelector"
            CircleSelector.Parent = SliderIndicator
            CircleSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CircleSelector.BackgroundTransparency = 1.000
            CircleSelector.Position = UDim2.new(0.986565471, -7, 0.75, -7)
            CircleSelector.Size = UDim2.new(0, 12, 0, 12)
            CircleSelector.ZIndex = 5
            CircleSelector.Image = "rbxassetid://3570695787"

            UICorner.Parent = SliderName

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderName
            SliderValue.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.899999976, -7, 0.400000006, -12)
            SliderValue.Size = UDim2.new(0, 40, 0, 19)
            SliderValue.ZIndex = 5
            SliderValue.Image = "rbxassetid://3570695787"
            SliderValue.ImageColor3 = Color3.fromRGB(65, 65, 65)
            SliderValue.ScaleType = Enum.ScaleType.Slice
            SliderValue.SliceCenter = Rect.new(100, 100, 100, 100)
            SliderValue.SliceScale = 0.030

            Value.Name = "Value"
            Value.Parent = SliderValue
            Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Value.BackgroundTransparency = 1.000
            Value.Size = UDim2.new(1, 0, 1, 0)
            Value.ZIndex = 5
            Value.Font = Enum.Font.SourceSansBold
            Value.Text = tostring(StartingValue or precisevalue and tonumber(string.format("%.2f", StartingValue)))
            Value.TextColor3 = Color3.fromRGB(255, 255, 255)
            Value.TextSize = 14.000

            local function Sliding(input)
                local SliderPosition = UDim2.new(math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1), 0, 1, 0)
                TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = SliderPosition}):Play()
    
                local NonSliderPreciseValue = math.floor(((SliderPosition.X.Scale * maximumvalue) / maximumvalue) * (maximumvalue - minimumvalue) + minimumvalue)
                local SliderPreciseValue = ((SliderPosition.X.Scale * maximumvalue) / maximumvalue) * (maximumvalue - minimumvalue) + minimumvalue
    
                local SlidingValue = (precisevalue and SliderPreciseValue or NonSliderPreciseValue)
                SlidingValue = tonumber(string.format("%.2f", SlidingValue))
    
                Value.Text = tostring(SlidingValue)
                callback(SlidingValue)
            end
    
            Value.FocusLost:Connect(function()
                if not tonumber(Value.Text) then
                    Value.Text = tostring(StartingValue or precisevalue and tonumber(string.format("%.2f", StartingValue)))
                elseif Value.Text == "" or tonumber(Value.Text) <= minimumvalue then
                    Value.Text = minimumvalue
                elseif Value.Text == "" or tonumber(Value.Text) >= maximumvalue then
                    Value.Text = maximumvalue
                end
    
                TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(((tonumber(Value.Text) or minimumvalue) - minimumvalue) / (maximumvalue - minimumvalue), 0, 1, 0)}):Play()
                callback(tonumber(Value.Text))
            end)
    
            
            CircleSelector.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    SliderDragging = true
                end
            end)
            
            CircleSelector.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    SliderDragging = false
                end
            end)
            
            CircleSelector.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Sliding(input)
                end
            end)
        
            UserInputService.InputChanged:Connect(function(input)
                if SliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    Sliding(input)
                end
            end)
            local function SetSliderValue(value)
                Value.Text = value
                TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(((tonumber(Value.Text) or minimumvalue) - minimumvalue) / (maximumvalue - minimumvalue), 0, 1, 0)}):Play()
                callback(tonumber(Value.Text))
            end
            callback(StartingValue)
        end

        function TabElements:Dropdown(name, options, presetoption, callback)
            local NameDropdown = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local TitleToggle = Instance.new("TextButton")
            local Dropdown = Instance.new("ScrollingFrame")
            local UICorner_2 = Instance.new("UICorner")
            local DropdownContentLayout = Instance.new("UIListLayout")
            local add = Instance.new("ImageButton")

            local DropdownToggled = true
            if presetoption <= 0 then
                SelectedOption = "nil"
            else
                SelectedOption = options[presetoption]
                callback(options[presetoption])
            end
            
            NameDropdown.Name = (name.."NameDropdown")
            NameDropdown.Parent = SectionContent
            NameDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            NameDropdown.Position = UDim2.new(0.020833334, 0, 0, 0)
            NameDropdown.Size = UDim2.new(0, 475, 0, 30)
            NameDropdown.ZIndex = 5

            UICorner.Parent = NameDropdown

            TitleToggle.Name = "TitleToggle"
            TitleToggle.Parent = NameDropdown
            TitleToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TitleToggle.BackgroundTransparency = 1.000
            TitleToggle.BorderSizePixel = 0
            TitleToggle.Position = UDim2.new(0, 13, 0, 0)
            TitleToggle.Size = UDim2.new(0, 475, 0, 30)
            TitleToggle.ZIndex = 7
            TitleToggle.Font = Enum.Font.SourceSansBold
            TitleToggle.Text = (name .. " : " .. SelectedOption)
            TitleToggle.TextColor3 = Color3.fromRGB(185, 185, 185)
            TitleToggle.TextSize = 15.000
            TitleToggle.TextXAlignment = Enum.TextXAlignment.Left

            local Find = Instance.new("TextBox")

            Find.Name = "Find"
            Find.Parent = NameDropdown
            Find.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Find.BackgroundTransparency = 1.000
            Find.Position = UDim2.new(0, 13, 0, 0)
            Find.Size = UDim2.new(0, 135, 0, 30)
            Find.ZIndex = 10
            Find.Font = Enum.Font.SourceSansBold
            Find.PlaceholderColor3 = Color3.fromRGB(255,255,255)
            Find.PlaceholderText = "Search : ..."
            Find.Text = ""
            Find.TextColor3 = Color3.fromRGB(185, 185, 185)
            Find.TextSize = 15.000
            Find.TextXAlignment = Enum.TextXAlignment.Left
            Find.Visible = false

            function UpdateInputOfSearchText()
                local InputText = string.upper(Find.Text)
                for _,button in pairs(Dropdown:GetChildren())do
                    if button:IsA("TextButton") then
                        if InputText == "" or string.find(string.upper(button.Name),InputText) ~= nil then
                            button.Visible = true
                        else
                            button.Visible = false
                        end
                    end
                end
            end
            Find.Changed:Connect(UpdateInputOfSearchText)

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = NameDropdown
            Dropdown.Active = true
            Dropdown.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
            Dropdown.BorderSizePixel = 0
            Dropdown.Position = UDim2.new(0, 15, 0, 30)
            Dropdown.Size = UDim2.new(0, 450, 0, 0)
            Dropdown.ZIndex = 15
            Dropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
            Dropdown.ScrollBarThickness = 5

            UICorner_2.Parent = Dropdown

            DropdownContentLayout.Name = "DropdownContentLayout"
            DropdownContentLayout.Parent = Dropdown
            DropdownContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

            add.Name = "add"
            add.Parent = NameDropdown
            add.BackgroundTransparency = 1.000
            add.Position = UDim2.new(0.925263166, 0, 0.0217391253, 0)
            add.Size = UDim2.new(0, 25, 0, 25)
            add.ZIndex = 10
            add.Image = "rbxassetid://3926307971"
            add.ImageRectOffset = Vector2.new(324, 364)
            add.ImageRectSize = Vector2.new(36, 36)

            local function ResetAllDropdownItems()
                for i, v in pairs(Dropdown:GetChildren()) do
                    if v:IsA("TextButton") then
                        TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    end
                end
            end

            local function ClearAllDropdownItems()
                for i, v in pairs(Dropdown:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
                DropdownToggled = true
                TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 30)}):Play()
                TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 0)}):Play()
            end

            for i, v in pairs(options) do
                local NameButton = Instance.new("TextButton")

                NameButton.Name = (v .. "DropdownButton")
                NameButton.Parent = Dropdown
                NameButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                NameButton.BackgroundTransparency = 1.000
                NameButton.BorderSizePixel = 0
                NameButton.Size = UDim2.new(0, 450, 0, 25)
                NameButton.ZIndex = 15
                NameButton.AutoButtonColor = false
                NameButton.Font = Enum.Font.SourceSansBold
                NameButton.Text = v
                NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                NameButton.TextSize = 15.000
                
                if v == SelectedOption then
                    NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                
                NameButton.MouseButton1Down:Connect(function()
                    SelectedOption = v
                    ResetAllDropdownItems()
                    TitleToggle.Text = (name .. " : " .. SelectedOption)
                    TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = ColorII}):Play()
                    callback(NameButton.Text)
                end)
                
                NameButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95}):Play()
                    end
                end)
                
                NameButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end)
            end

            TitleToggle.MouseButton1Down:Connect(function()
                DropdownToggled = not DropdownToggled
                
                if DropdownToggled then
                    Find.Visible = false
                    TitleToggle.TextTransparency = 0
                    TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 30)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasSize = UDim2.new(0, 0, 0, 0)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 0)}):Play()
                    TweenService:Create(add, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                elseif not DropdownToggled then
                    Find.Visible = true
                    TitleToggle.TextTransparency = 1
                    TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
                    TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 115)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasSize = UDim2.new(0, 0, 0, DropdownContentLayout.AbsoluteContentSize.Y)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 75)}):Play()
                    TweenService:Create(add, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                end
            end)
            
            local funcdrop = {}

            function funcdrop:Refresh(newdate)
                ClearAllDropdownItems()
                Find.Visible = false
                TitleToggle.TextTransparency = 0
                for i, v in pairs(newdate) do
                    local NameButton = Instance.new("TextButton")
    
                    NameButton.Name = (v .. "DropdownButton")
                    NameButton.Parent = Dropdown
                    NameButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    NameButton.BackgroundTransparency = 1.000
                    NameButton.BorderSizePixel = 0
                    NameButton.Size = UDim2.new(0, 450, 0, 25)
                    NameButton.ZIndex = 15
                    NameButton.AutoButtonColor = false
                    NameButton.Font = Enum.Font.SourceSansBold
                    NameButton.Text = v
                    NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    NameButton.TextSize = 15.000
                    
                    if v == SelectedOption then
                        NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    
                    NameButton.MouseButton1Down:Connect(function()
                        SelectedOption = v
                        ResetAllDropdownItems()
                        TitleToggle.Text = (name .. " : " .. SelectedOption)
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = ColorII}):Play()
                        callback(NameButton.Text)
                    end)
                    
                    NameButton.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95}):Play()
                        end
                    end)
                    
                    NameButton.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                        end
                    end)
                end
            end
            return funcdrop
        end

        function TabElements:NewDropdown(name, options, presetoption, callback)
            local NameDropdown = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local TitleToggle = Instance.new("TextButton")
            local Dropdown = Instance.new("ScrollingFrame")
            local UICorner_2 = Instance.new("UICorner")
            local DropdownContentLayout = Instance.new("UIListLayout")
            local add = Instance.new("ImageButton")

            local DropdownToggled = true
            if presetoption <= 0 then
                SelectedOption = "nil"
            else
                SelectedOption = options[presetoption]
                callback(options[presetoption])
            end
            
            NameDropdown.Name = (name.."NameDropdown")
            NameDropdown.Parent = SectionContent
            NameDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            NameDropdown.Position = UDim2.new(0.020833334, 0, 0, 0)
            NameDropdown.Size = UDim2.new(0, 475, 0, 30)
            NameDropdown.ZIndex = 5

            UICorner.Parent = NameDropdown

            TitleToggle.Name = "TitleToggle"
            TitleToggle.Parent = NameDropdown
            TitleToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TitleToggle.BackgroundTransparency = 1.000
            TitleToggle.BorderSizePixel = 0
            TitleToggle.Position = UDim2.new(0, 13, 0, 0)
            TitleToggle.Size = UDim2.new(0, 475, 0, 30)
            TitleToggle.ZIndex = 7
            TitleToggle.Font = Enum.Font.SourceSansBold
            TitleToggle.Text = (name .. " : " .. SelectedOption)
            TitleToggle.TextColor3 = Color3.fromRGB(185, 185, 185)
            TitleToggle.TextSize = 15.000
            TitleToggle.TextXAlignment = Enum.TextXAlignment.Left

            local Find = Instance.new("TextBox")

            Find.Name = "Find"
            Find.Parent = NameDropdown
            Find.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Find.BackgroundTransparency = 1.000
            Find.Position = UDim2.new(0, 13, 0, 0)
            Find.Size = UDim2.new(0, 135, 0, 30)
            Find.ZIndex = 10
            Find.Font = Enum.Font.SourceSansBold
            Find.PlaceholderColor3 = Color3.fromRGB(255,255,255)
            Find.PlaceholderText = "Search : ..."
            Find.Text = ""
            Find.TextColor3 = Color3.fromRGB(185, 185, 185)
            Find.TextSize = 15.000
            Find.TextXAlignment = Enum.TextXAlignment.Left
            Find.Visible = false

            function UpdateInputOfSearchText()
                local InputText = string.upper(Find.Text)
                for _,button in pairs(Dropdown:GetChildren())do
                    if button:IsA("TextButton") then
                        if InputText == "" or string.find(string.upper(button.Name),InputText) ~= nil then
                            button.Visible = true
                        else
                            button.Visible = false
                        end
                    end
                end
            end
            Find.Changed:Connect(UpdateInputOfSearchText)

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = NameDropdown
            Dropdown.Active = true
            Dropdown.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
            Dropdown.BorderSizePixel = 0
            Dropdown.Position = UDim2.new(0, 15, 0, 30)
            Dropdown.Size = UDim2.new(0, 450, 0, 0)
            Dropdown.ZIndex = 15
            Dropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
            Dropdown.ScrollBarThickness = 5

            UICorner_2.Parent = Dropdown

            DropdownContentLayout.Name = "DropdownContentLayout"
            DropdownContentLayout.Parent = Dropdown
            DropdownContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

            add.Name = "add"
            add.Parent = NameDropdown
            add.BackgroundTransparency = 1.000
            add.Position = UDim2.new(0.925263166, 0, 0.0217391253, 0)
            add.Size = UDim2.new(0, 25, 0, 25)
            add.ZIndex = 10
            add.Image = "rbxassetid://3926307971"
            add.ImageRectOffset = Vector2.new(324, 364)
            add.ImageRectSize = Vector2.new(36, 36)

            local function ResetAllDropdownItems()
                for i, v in pairs(Dropdown:GetChildren()) do
                    if v:IsA("TextButton") then
                        TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    end
                end
            end

            local function ClearAllDropdownItems()
                for i, v in pairs(Dropdown:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
                DropdownToggled = true
                TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 30)}):Play()
                TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 0)}):Play()
            end

            for v,i in pairs(options) do
                local NameButton = Instance.new("TextButton")

                NameButton.Name = (v .. "DropdownButton")
                NameButton.Parent = Dropdown
                NameButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                NameButton.BackgroundTransparency = 1.000
                NameButton.BorderSizePixel = 0
                NameButton.Size = UDim2.new(0, 450, 0, 25)
                NameButton.ZIndex = 15
                NameButton.AutoButtonColor = false
                NameButton.Font = Enum.Font.SourceSansBold
                NameButton.Text = v
                NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                NameButton.TextSize = 15.000
                
                if v == SelectedOption then
                    NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                
                NameButton.MouseButton1Down:Connect(function()
                    SelectedOption = v
                    ResetAllDropdownItems()
                    TitleToggle.Text = (name .. " : " .. SelectedOption)
                    TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = ColorII}):Play()
                    callback(NameButton.Text)
                end)
                
                NameButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95}):Play()
                    end
                end)
                
                NameButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end)
            end

            TitleToggle.MouseButton1Down:Connect(function()
                DropdownToggled = not DropdownToggled
                
                if DropdownToggled then
                    Find.Visible = false
                    TitleToggle.TextTransparency = 0
                    TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 30)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasSize = UDim2.new(0, 0, 0, 0)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 0)}):Play()
                    TweenService:Create(add, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                elseif not DropdownToggled then
                    Find.Visible = true
                    TitleToggle.TextTransparency = 1
                    TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
                    TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 115)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasSize = UDim2.new(0, 0, 0, DropdownContentLayout.AbsoluteContentSize.Y)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 75)}):Play()
                    TweenService:Create(add, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                end
            end)
            
            local funcdrop = {}

            function funcdrop:Refresh(newdate)
                ClearAllDropdownItems()
                for v,i in pairs(newdate) do
                    local NameButton = Instance.new("TextButton")
    
                    NameButton.Name = (v .. "DropdownButton")
                    NameButton.Parent = Dropdown
                    NameButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    NameButton.BackgroundTransparency = 1.000
                    NameButton.BorderSizePixel = 0
                    NameButton.Size = UDim2.new(0, 450, 0, 25)
                    NameButton.ZIndex = 15
                    NameButton.AutoButtonColor = false
                    NameButton.Font = Enum.Font.SourceSansBold
                    NameButton.Text = v
                    NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    NameButton.TextSize = 15.000
                    
                    if v == SelectedOption then
                        NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    
                    NameButton.MouseButton1Down:Connect(function()
                        SelectedOption = v
                        ResetAllDropdownItems()
                        TitleToggle.Text = (name .. " : " .. SelectedOption)
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = ColorII}):Play()
                        callback(NameButton.Text)
                    end)
                    
                    NameButton.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95}):Play()
                        end
                    end)
                    
                    NameButton.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                        end
                    end)
                end
            end
            return funcdrop
        end

        function TabElements:MutiDropdown(name, options, callback)
            local NameDropdown = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local TitleToggle = Instance.new("TextButton")
            local Dropdown = Instance.new("ScrollingFrame")
            local UICorner_2 = Instance.new("UICorner")
            local DropdownContentLayout = Instance.new("UIListLayout")
            local add = Instance.new("ImageButton")

            local DropdownToggled = true
            SelectedOption = "nil"
            
            NameDropdown.Name = (name.."NameDropdown")
            NameDropdown.Parent = SectionContent
            NameDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            NameDropdown.Position = UDim2.new(0.020833334, 0, 0, 0)
            NameDropdown.Size = UDim2.new(0, 475, 0, 30)
            NameDropdown.ZIndex = 5

            UICorner.Parent = NameDropdown

            TitleToggle.Name = "TitleToggle"
            TitleToggle.Parent = NameDropdown
            TitleToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TitleToggle.BackgroundTransparency = 1.000
            TitleToggle.BorderSizePixel = 0
            TitleToggle.Position = UDim2.new(0, 13, 0, 0)
            TitleToggle.Size = UDim2.new(0, 475, 0, 30)
            TitleToggle.ZIndex = 7
            TitleToggle.Font = Enum.Font.SourceSansBold
            TitleToggle.Text = (name .. " : " .. SelectedOption)
            TitleToggle.TextColor3 = Color3.fromRGB(185, 185, 185)
            TitleToggle.TextSize = 15.000
            TitleToggle.TextXAlignment = Enum.TextXAlignment.Left

            local Find = Instance.new("TextBox")

            Find.Name = "Find"
            Find.Parent = NameDropdown
            Find.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Find.BackgroundTransparency = 1.000
            Find.Position = UDim2.new(0, 13, 0, 0)
            Find.Size = UDim2.new(0, 135, 0, 30)
            Find.ZIndex = 10
            Find.Font = Enum.Font.SourceSansSemibold
            Find.PlaceholderColor3 = Color3.fromRGB(255,255,255)
            Find.PlaceholderText = "Search : ..."
            Find.Text = ""
            Find.TextColor3 = Color3.fromRGB(185, 185, 185)
            Find.TextSize = 15.000
            Find.TextXAlignment = Enum.TextXAlignment.Left
            Find.Visible = false

            function UpdateInputOfSearchText()
                local InputText = string.upper(Find.Text)
                for _,button in pairs(Dropdown:GetChildren())do
                    if button:IsA("TextButton") then
                        if InputText == "" or string.find(string.upper(button.Name),InputText) ~= nil then
                            button.Visible = true
                        else
                            button.Visible = false
                        end
                    end
                end
            end
            Find.Changed:Connect(UpdateInputOfSearchText)

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = NameDropdown
            Dropdown.Active = true
            Dropdown.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
            Dropdown.BorderSizePixel = 0
            Dropdown.Position = UDim2.new(0, 15, 0, 30)
            Dropdown.Size = UDim2.new(0, 450, 0, 0)
            Dropdown.ZIndex = 15
            Dropdown.CanvasSize = UDim2.new(0, 0, 0, 100)
            Dropdown.ScrollBarThickness = 5

            UICorner_2.Parent = Dropdown

            DropdownContentLayout.Name = "DropdownContentLayout"
            DropdownContentLayout.Parent = Dropdown
            DropdownContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

            add.Name = "add"
            add.Parent = NameDropdown
            add.BackgroundTransparency = 1.000
            add.Position = UDim2.new(0.925263166, 0, 0.0217391253, 0)
            add.Size = UDim2.new(0, 25, 0, 25)
            add.ZIndex = 10
            add.Image = "rbxassetid://3926307971"
            add.ImageRectOffset = Vector2.new(324, 364)
            add.ImageRectSize = Vector2.new(36, 36)

            local function ResetAllDropdownItems()
                for i, v in pairs(Dropdown:GetChildren()) do
                    if v:IsA("TextButton") then
                        TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    end
                end
            end

            local function ClearAllDropdownItems()
                for i, v in pairs(Dropdown:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
                DropdownToggled = true
                TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 30)}):Play()
                TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 0)}):Play()
            end

            for i, v in pairs(options) do
                local NameButton = Instance.new("TextButton")

                NameButton.Name = (v .. "DropdownButton")
                NameButton.Parent = Dropdown
                NameButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                NameButton.BackgroundTransparency = 1.000
                NameButton.BorderSizePixel = 0
                NameButton.Size = UDim2.new(0, 450, 0, 25)
                NameButton.ZIndex = 15
                NameButton.AutoButtonColor = false
                NameButton.Font = Enum.Font.SourceSansBold
                NameButton.Text = v
                NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                NameButton.TextSize = 15.000
                
                if v == SelectedOption then
                    NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                
                NameButton.MouseButton1Down:Connect(function()
                    SelectedOption = v
                    ResetAllDropdownItems()
                    TitleToggle.Text = (name .. " : " .. SelectedOption)
                    TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = ColorII}):Play()
                    callback(NameButton.Text)
                end)
                
                NameButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95}):Play()
                    end
                end)
                
                NameButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        TweenService:Create(NameButton, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    end
                end)
            end

            TitleToggle.MouseButton1Down:Connect(function()
                DropdownToggled = not DropdownToggled
                
                if DropdownToggled then
                    Find.Visible = false
                    TitleToggle.TextTransparency = 0
                    TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 30)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasSize = UDim2.new(0, 0, 0, 0)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 0)}):Play()
                    TweenService:Create(add, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                elseif not DropdownToggled then
                    Find.Visible = true
                    TitleToggle.TextTransparency = 1
                    TweenService:Create(TitleToggle, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
                    TweenService:Create(NameDropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 115)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CanvasSize = UDim2.new(0, 0, 0, DropdownContentLayout.AbsoluteContentSize.Y)}):Play()
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 75)}):Play()
                    TweenService:Create(add, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 360}):Play()
                end
            end)
        end
        
        function TabElements:ColorPicker(name, presetcolor, callback)
            local NameColorPicker = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Title = Instance.new("TextLabel")
            local ColorPickerToggle = Instance.new("ImageButton")
            local ColorPicker = Instance.new("ImageLabel")
            local Color = Instance.new("ImageLabel")
            local ColorRound = Instance.new("ImageLabel")
            local ColorSelection = Instance.new("ImageLabel")
            local RValue = Instance.new("ImageLabel")
            local ValueR = Instance.new("TextLabel")
            local GValue = Instance.new("ImageLabel")
            local ValueG = Instance.new("TextLabel")
            local BValue = Instance.new("ImageLabel")
            local ValueB = Instance.new("TextLabel")
            local RainbowToggle = Instance.new("Frame")
            local RainbowToggleTitle = Instance.new("TextLabel")
            local Toggle = Instance.new("TextButton")
            local CheckboxOutline = Instance.new("ImageLabel")
            local CheckboxTicked = Instance.new("ImageLabel")
            local TickCover = Instance.new("Frame")
            local Hue = Instance.new("ImageLabel")
            local UIGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            local Frame = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local Frame_2 = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")

            local ColorPickerToggled = false
            local OldToggleColor = Color3.fromRGB(0, 0, 0)
            local OldColor = Color3.fromRGB(0, 0, 0)
            local OldColorSelectionPosition = nil
            local OldHueSelectionPosition = nil
            local ColorH, ColorS, ColorV = 1, 1, 1
            local RainbowColorPicker = false
            local ColorPickerInput = nil
            local ColorInput = nil
            local HueInput = nil

            NameColorPicker.Name = (name.."NameColorPicker")
            NameColorPicker.Parent = SectionContent
            NameColorPicker.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            NameColorPicker.ClipsDescendants = true
            NameColorPicker.Position = UDim2.new(0, 0, 0.138121545, 0)
            NameColorPicker.Size = UDim2.new(0, 475, 0, 30)
            NameColorPicker.ZIndex = 5

            UICorner.Parent = NameColorPicker

            Title.Name = "Title"
            Title.Parent = NameColorPicker
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 13, 0, 0)
            Title.Size = UDim2.new(0, 151, 0, 30)
            Title.ZIndex = 5
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = name
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 15.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            ColorPickerToggle.Name = "ColorPickerToggle"
            ColorPickerToggle.Parent = NameColorPicker
            ColorPickerToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorPickerToggle.BackgroundTransparency = 1.000
            ColorPickerToggle.Position = UDim2.new(1, -55, 0, 5)
            ColorPickerToggle.Size = UDim2.new(0, 42, 0, 20)
            ColorPickerToggle.ZIndex = 5
            ColorPickerToggle.Image = "rbxassetid://3570695787"
            ColorPickerToggle.ImageColor3 = presetcolor
            ColorPickerToggle.ScaleType = Enum.ScaleType.Slice
            ColorPickerToggle.SliceCenter = Rect.new(100, 100, 100, 100)
            ColorPickerToggle.SliceScale = 0.030

            ColorPicker.Name = "ColorPicker"
            ColorPicker.Parent = NameColorPicker
            ColorPicker.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ColorPicker.BackgroundTransparency = 1.000
            ColorPicker.ClipsDescendants = true
            ColorPicker.Position = UDim2.new(0.02, 0, 0, 30)
            ColorPicker.Size = UDim2.new(0, 450, 0, 125)
            ColorPicker.ZIndex = 10
            ColorPicker.Image = "rbxassetid://3570695787"
            ColorPicker.ImageColor3 = Color3.fromRGB(45, 45, 45)
            ColorPicker.ImageTransparency = 1.000
            ColorPicker.ScaleType = Enum.ScaleType.Slice
            ColorPicker.SliceCenter = Rect.new(100, 100, 100, 100)
            ColorPicker.SliceScale = 0.070

            Color.Name = "Color"
            Color.Parent = ColorPicker
            Color.BackgroundColor3 = presetcolor
            Color.BorderSizePixel = 0
            Color.Position = UDim2.new(0, 9, 0, 10)
            Color.Size = UDim2.new(0, 124, 0, 105)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"

            ColorRound.Name = "ColorRound"
            ColorRound.Parent = Color
            ColorRound.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorRound.BackgroundTransparency = 1.000
            ColorRound.ClipsDescendants = true
            ColorRound.Size = UDim2.new(1, 0, 1, 0)
            ColorRound.ZIndex = 10
            ColorRound.Image = "rbxassetid://4695575676"
            ColorRound.ImageColor3 = Color3.fromRGB(45, 45, 45)
            ColorRound.ScaleType = Enum.ScaleType.Slice
            ColorRound.SliceCenter = Rect.new(128, 128, 128, 128)
            ColorRound.SliceScale = 0.050

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(presetcolor and select(3, Color3.toHSV(presetcolor)))
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.ZIndex = 25
            ColorSelection.Image = "rbxassetid://4953646208"
            ColorSelection.ScaleType = Enum.ScaleType.Fit

            RValue.Name = "RValue"
            RValue.Parent = ColorPicker
            RValue.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
            RValue.Position = UDim2.new(0, 195, 0, 10)
            RValue.Size = UDim2.new(0, 42, 0, 19)
            RValue.ZIndex = 10
            RValue.Image = "rbxassetid://3570695787"
            RValue.ImageColor3 = Color3.fromRGB(65, 65, 65)
            RValue.ScaleType = Enum.ScaleType.Slice
            RValue.SliceCenter = Rect.new(100, 100, 100, 100)
            RValue.SliceScale = 0.030

            ValueR.Name = "ValueR"
            ValueR.Parent = RValue
            ValueR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ValueR.BackgroundTransparency = 1.000
            ValueR.Size = UDim2.new(1, 0, 1, 0)
            ValueR.ZIndex = 11
            ValueR.Font = Enum.Font.SourceSansBold
            ValueR.Text = "R: 255"
            ValueR.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueR.TextSize = 14.000

            GValue.Name = "GValue"
            GValue.Parent = ColorPicker
            GValue.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
            GValue.Position = UDim2.new(0, 195, 0, 35)
            GValue.Size = UDim2.new(0, 42, 0, 19)
            GValue.ZIndex = 10
            GValue.Image = "rbxassetid://3570695787"
            GValue.ImageColor3 = Color3.fromRGB(65, 65, 65)
            GValue.ScaleType = Enum.ScaleType.Slice
            GValue.SliceCenter = Rect.new(100, 100, 100, 100)
            GValue.SliceScale = 0.030

            ValueG.Name = "ValueG"
            ValueG.Parent = GValue
            ValueG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ValueG.BackgroundTransparency = 1.000
            ValueG.Size = UDim2.new(1, 0, 1, 0)
            ValueG.ZIndex = 11
            ValueG.Font = Enum.Font.SourceSansBold
            ValueG.Text = "G: 255"
            ValueG.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueG.TextSize = 14.000

            BValue.Name = "BValue"
            BValue.Parent = ColorPicker
            BValue.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
            BValue.Position = UDim2.new(0, 195, 0, 60)
            BValue.Size = UDim2.new(0, 42, 0, 19)
            BValue.ZIndex = 10
            BValue.Image = "rbxassetid://3570695787"
            BValue.ImageColor3 = Color3.fromRGB(65, 65, 65)
            BValue.ScaleType = Enum.ScaleType.Slice
            BValue.SliceCenter = Rect.new(100, 100, 100, 100)
            BValue.SliceScale = 0.030

            ValueB.Name = "ValueB"
            ValueB.Parent = BValue
            ValueB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ValueB.BackgroundTransparency = 1.000
            ValueB.Size = UDim2.new(1, 0, 1, 0)
            ValueB.ZIndex = 11
            ValueB.Font = Enum.Font.SourceSansBold
            ValueB.Text = "B: 255"
            ValueB.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueB.TextSize = 14.000

            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Parent = ColorPicker
            RainbowToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggle.BackgroundTransparency = 1.000
            RainbowToggle.Position = UDim2.new(0, 267, 0, 10)
            RainbowToggle.Size = UDim2.new(0, 160, 0, 35)
            RainbowToggle.ZIndex = 100

            RainbowToggleTitle.Name = "RainbowToggleTitle"
            RainbowToggleTitle.Parent = RainbowToggle
            RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.BackgroundTransparency = 1.000
            RainbowToggleTitle.Size = UDim2.new(0, 120, 0, 30)
            RainbowToggleTitle.ZIndex = 10
            RainbowToggleTitle.Font = Enum.Font.SourceSansBold
            RainbowToggleTitle.Text = "          Rainbow"
            RainbowToggleTitle.TextColor3 = Color3.fromRGB(185, 185, 185)
            RainbowToggleTitle.TextSize = 15.000
            RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            Toggle.Name = "Toggle"
            Toggle.Parent = RainbowToggle
            Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.BackgroundTransparency = 1.000
            Toggle.Position = UDim2.new(0, 131, 0, 5)
            Toggle.Size = UDim2.new(0, 20, 0, 20)
            Toggle.ZIndex = 10
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSansBold
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            CheckboxOutline.Name = "CheckboxOutline"
            CheckboxOutline.Parent = Toggle
            CheckboxOutline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CheckboxOutline.BackgroundTransparency = 1.000
            CheckboxOutline.Position = UDim2.new(0.5, -12, 0.5, -12)
            CheckboxOutline.Size = UDim2.new(0, 24, 0, 24)
            CheckboxOutline.ZIndex = 10
            CheckboxOutline.Image = "http://www.roblox.com/asset/?id=5416796047"
            CheckboxOutline.ImageColor3 = Color3.fromRGB(65, 65, 65)

            CheckboxTicked.Name = "CheckboxTicked"
            CheckboxTicked.Parent = Toggle
            CheckboxTicked.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CheckboxTicked.BackgroundTransparency = 1.000
            CheckboxTicked.Position = UDim2.new(0.5, -12, 0.5, -12)
            CheckboxTicked.Size = UDim2.new(0, 24, 0, 24)
            CheckboxTicked.ZIndex = 10
            CheckboxTicked.Image = "http://www.roblox.com/asset/?id=5416796675"
            CheckboxTicked.ImageColor3 = Color3.fromRGB(65, 65, 65)

            TickCover.Name = "TickCover"
            TickCover.Parent = Toggle
            TickCover.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            TickCover.BorderSizePixel = 0
            TickCover.Position = UDim2.new(0.5, -7, 0.5, -7)
            TickCover.Size = UDim2.new(0, 14, 0, 14)
            TickCover.ZIndex = 10

            Hue.Name = "Hue"
            Hue.Parent = ColorPicker
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.BackgroundTransparency = 1.000
            Hue.Position = UDim2.new(0, 136, 0, 10)
            Hue.Size = UDim2.new(0, 25, 0, 105)
            Hue.ZIndex = 10
            Hue.Image = "rbxassetid://3570695787"
            Hue.ScaleType = Enum.ScaleType.Slice
            Hue.SliceCenter = Rect.new(100, 100, 100, 100)
            Hue.SliceScale = 0.050

            UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))}
            UIGradient.Rotation = 270
            UIGradient.Parent = Hue

            HueSelection.Name = "HueSelection"
            HueSelection.Parent = Hue
            HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSelection.BackgroundTransparency = 1.000
            HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(presetcolor)))
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.ZIndex = 10
            HueSelection.Image = "rbxassetid://4953646208"
            HueSelection.ScaleType = Enum.ScaleType.Fit

            Frame.Parent = ColorPicker
            Frame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            Frame.Position = UDim2.new(0.39, 0, 0.0799999982, 0)
            Frame.Size = UDim2.new(0, 2, 0, 100)
            Frame.ZIndex = 10

            UICorner_2.Parent = Frame

            Frame_2.Parent = ColorPicker
            Frame_2.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            Frame_2.Position = UDim2.new(0.57, 0, 0.055999998, 0)
            Frame_2.Size = UDim2.new(0, 2, 0, 100)
            Frame_2.ZIndex = 10

            UICorner_3.Parent = Frame_2

            local function SetRGBValues()
                ValueR.Text = ("R: " .. math.floor(ColorPickerToggle.ImageColor3.r * 255))
                ValueG.Text = ("G: " .. math.floor(ColorPickerToggle.ImageColor3.g * 255))
                ValueB.Text = ("B: " .. math.floor(ColorPickerToggle.ImageColor3.b * 255))
            end

            
            local function UpdateColorPicker(nope)
                ColorPickerToggle.ImageColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
    
                SetRGBValues()
                callback(ColorPickerToggle.ImageColor3)
            end
    
            ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
            ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
            ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
    
            ColorPickerToggle.ImageColor3 = presetcolor
            Color.BackgroundColor3 = presetcolor
            SetRGBValues()
            callback(Color.BackgroundColor3)
    
            Color.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if RainbowColorPicker then return end
    
                    if ColorInput then
                        ColorInput:Disconnect()
                    end
                    
                    ColorInput = RunService.RenderStepped:Connect(function()
                        local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
                        local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
    
                        ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                        ColorS = ColorX
                        ColorV = 1 - ColorY
    
                        UpdateColorPicker(true)
                    end)
                end
            end)
    
            Color.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ColorInput then
                        ColorInput:Disconnect()
                    end
                end
            end)
    
            Hue.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if RainbowColorPicker then return end
    
                    if HueInput then
                        HueInput:Disconnect()
                    end
                    
                    HueInput = RunService.RenderStepped:Connect(function()
                        local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
    
                        HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                        ColorH = 1 - HueY
    
                        UpdateColorPicker(true)
                    end)
                end
            end)
    
            Hue.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if HueInput then
                        HueInput:Disconnect()
                    end
                end
            end)
    
            Toggle.MouseButton1Down:Connect(function()
                RainbowColorPicker = not RainbowColorPicker
            
                if ColorInput then
                    ColorInput:Disconnect()
                end
    
                if HueInput then
                    HueInput:Disconnect()
                end
    
                if RainbowColorPicker then              
                    TweenService:Create(RainbowToggleTitle, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0)}):Play()
                    TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    
                    OldToggleColor = ColorPickerToggle.ImageColor3
                    OldColor = Color.BackgroundColor3
                    OldColorSelectionPosition = ColorSelection.Position
                    OldHueSelectionPosition = HueSelection.Position
    
                    while RainbowColorPicker do
                        ColorPickerToggle.ImageColor3 = Color3.fromHSV(library.RainbowColorValue, 1, 1)
                        Color.BackgroundColor3 = Color3.fromHSV(library.RainbowColorValue, 1, 1)
            
                        ColorSelection.Position = UDim2.new(1, 0, 0, 0)
                        HueSelection.Position = UDim2.new(0.48, 0, 0, library.HueSelectionPosition)
            
                        SetRGBValues()
                        callback(Color.BackgroundColor3)
                        wait()
                    end
                elseif not RainbowColorPicker then
                    ColorPickerToggle.ImageColor3 = OldToggleColor
                    Color.BackgroundColor3 = OldColor
    
                    ColorSelection.Position = OldColorSelectionPosition
                    HueSelection.Position = OldHueSelectionPosition
    
                    SetRGBValues()
                    callback(ColorPickerToggle.ImageColor3)
                    TweenService:Create(RainbowToggleTitle, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
                    TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -7, 0.5, -7), Size = UDim2.new(0, 14, 0, 14)}):Play()
                    TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
                    TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
                end
            end)
            ColorPickerToggle.MouseButton1Down:Connect(function()
                ColorPickerToggled = not ColorPickerToggled
                if ColorPickerToggled then
                    TweenService:Create(NameColorPicker, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 160)}):Play()
                    TweenService:Create(ColorPicker, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                elseif not ColorPickerToggled then
                    TweenService:Create(NameColorPicker, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 475, 0, 30)}):Play()
                    TweenService:Create(ColorPicker, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                end
            end)
        end

        function TabElements:Line()
            local Line = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonRounded = Instance.new("ImageLabel")
            local UIGradient = Instance.new("UIGradient")

            Line.Name = "Line"
            Line.Parent = SectionContent
            Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Line.BackgroundTransparency = 1.000
            Line.Position = UDim2.new(0, 0, 0.298245609, 0)
            Line.Size = UDim2.new(0, 475, 0, 5)
            Line.ZIndex = 5

            Button.Name = "Button"
            Button.Parent = Line
            Button.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
            Button.BackgroundTransparency = 1.000
            Button.BorderSizePixel = 0
            Button.ClipsDescendants = true
            Button.Size = UDim2.new(0, 475, 0, 5)
            Button.ZIndex = 6
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 15.000

            ButtonRounded.Name = "ButtonRounded"
            ButtonRounded.Parent = Button
            ButtonRounded.Active = true
            ButtonRounded.AnchorPoint = Vector2.new(0.5, 0.5)
            ButtonRounded.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonRounded.BackgroundTransparency = 1.000
            ButtonRounded.Position = UDim2.new(0.49999997, 0, 0.5, 0)
            ButtonRounded.Selectable = true
            ButtonRounded.Size = UDim2.new(1, 0, 1, 0)
            ButtonRounded.ZIndex = 5
            ButtonRounded.Image = "rbxassetid://3570695787"
            ButtonRounded.ScaleType = Enum.ScaleType.Slice
            ButtonRounded.SliceCenter = Rect.new(100, 100, 100, 100)
            ButtonRounded.SliceScale = 0.050

            UIGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, 
                    ColorIII
                ), 
                ColorSequenceKeypoint.new(1.00, 
                    ColorIIII
                )
            }
            UIGradient.Parent = ButtonRounded
        end

        function TabElements:Label(text)
            local Label = Instance.new("TextLabel")
            local UICorner = Instance.new("UICorner")
            
            Label.Name = (text.."Label")
            Label.Parent = SectionContent
            Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Label.Position = UDim2.new(-0.0278330017, 0, 0.022457853, 0)
            Label.Size = UDim2.new(0, 475, 0, 35)
            Label.ZIndex = 5
            Label.Text = "-- " .. text .. " --"
            Label.Font = Enum.Font.SourceSansBold
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 18.000
            
            UICorner.Parent = Label

            local funclabel = {}

            function funclabel:Refresh(newtext)
                Label.Text = newtext
            end

            return funclabel
        end

        function TabElements:Title(text)
            local Title = Instance.new("TextLabel")
            local UICorner = Instance.new("UICorner")

            Title.Name = (text.."Title")
            Title.Parent = SectionContent
            Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Title.Position = UDim2.new(-0.0278330017, 0, 0.022457853, 0)
            Title.Size = UDim2.new(0, 475, 0, 35)
            Title.ZIndex = 5
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = "          "..text
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 18.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            UICorner.Parent = Title

            local funcTitle = {}

            function funcTitle:Refresh(newtext)
                Label.Text = newtext
            end

            return funcTitle
        end

        function TabElements:DestroyGui()
            local NameButton = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonRounded = Instance.new("ImageLabel")
            local UICorner = Instance.new("UICorner")
            local UICorner_2 = Instance.new("UICorner")
            local touch_app = Instance.new("ImageButton")

            NameButton.Name = "DestroyGui"
            NameButton.Parent = SectionContent
            NameButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            NameButton.Position = UDim2.new(0, 0, 0.122807018, 0)
            NameButton.Size = UDim2.new(0, 475, 0, 30)
            NameButton.ZIndex = 5

            Button.Name = "Button"
            Button.Parent = NameButton
            Button.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
            Button.BackgroundTransparency = 1.000
            Button.BorderSizePixel = 0
            Button.ClipsDescendants = true
            Button.Position = UDim2.new(-0.000727273524, 0, 0, 0)
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Text = "Destroy Gui"
            Button.ZIndex = 6
            Button.Font = Enum.Font.SourceSansBold
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 15.000

            touch_app.Name = "touch_app"
            touch_app.Parent = Button
            touch_app.BackgroundTransparency = 1.000
            touch_app.LayoutOrder = 8
            touch_app.Position = UDim2.new(0.92315793, 0, 0.0666666478, 0)
            touch_app.Size = UDim2.new(0, 25, 0, 25)
            touch_app.ZIndex = 10
            touch_app.Image = "rbxassetid://3926305904"
            touch_app.ImageRectOffset = Vector2.new(84, 204)
            touch_app.ImageRectSize = Vector2.new(36, 36)

            ButtonRounded.Name = "ButtonRounded"
            ButtonRounded.Parent = Button
            ButtonRounded.Active = true
            ButtonRounded.AnchorPoint = Vector2.new(0.5, 0.5)
            ButtonRounded.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonRounded.BackgroundTransparency = 1.000
            ButtonRounded.Position = UDim2.new(0.5, 0, 0.5, 0)
            ButtonRounded.Selectable = true
            ButtonRounded.Size = UDim2.new(1, 0, 1, 0)
            ButtonRounded.ZIndex = 5
            ButtonRounded.Image = "rbxassetid://3570695787"
            ButtonRounded.ImageColor3 = Color3.fromRGB(255, 75, 75)
            ButtonRounded.ImageTransparency = 1.000
            ButtonRounded.ScaleType = Enum.ScaleType.Slice
            ButtonRounded.SliceCenter = Rect.new(100, 100, 100, 100)
            ButtonRounded.SliceScale = 0.050

            UICorner.Parent = NameButton

            UICorner_2.Parent = Button

            local Lock = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local lock = Instance.new("ImageButton")

            Lock.Name = "Lock"
            Lock.Parent = Button
            Lock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Lock.BackgroundTransparency = 0.500
            Lock.Size = UDim2.new(1, 0, 1, 0)
            Lock.ZIndex = 10
            Lock.Visible = false

            UICorner.Parent = Lock

            lock.Name = "lock"
            lock.Parent = Lock
            lock.AnchorPoint = Vector2.new(0.5, 0.5)
            lock.BackgroundTransparency = 1.000
            lock.Position = UDim2.new(0.525263131, -12, 0.899999976, -12)
            lock.Size = UDim2.new(0, 0, 0, 0)
            lock.ZIndex = 10
            lock.Image = "rbxassetid://3926305904"
            lock.ImageRectOffset = Vector2.new(4, 684)
            lock.ImageRectSize = Vector2.new(36, 36)

            Button.MouseButton1Down:Connect(function()
                if Lock.Visible == true then
                    for i = 1,3 do
                        TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 10}):Play()
                        wait(.1)
                        TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = -10}):Play()
                        wait(.1)
                    end
                    TweenService:Create(lock, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                else
                    RippleEffect(Button)
                    ScreenGui:Destroy()
                end
            end)
                                
            Button.MouseButton1Up:Connect(function()
                TweenService:Create(ButtonRounded, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            end)
                                                                        
            Button.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    TweenService:Create(ButtonRounded, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end
            end)

            local funcbutton = {}

            function funcbutton:Delete()
                NameButton:Destroy()
            end
            function funcbutton:Lock()
                Lock.Visible = true
                TweenService:Create(lock, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 25, 0, 25)}):Play()
            end
            function funcbutton:Unlock()
                TweenService:Create(lock, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                wait(.5)
                Lock.Visible = false
            end
            return funcbutton
        end

        return TabElements
    end
    return Tabs
end

return library
