local Acilib = {}
local TWS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local function default(value, onnil)
	if value ~= nil then
		return value
	end
	return onnil
end
-- use this to print messages only for when debugging
local function dbgprint(tx)
	--print(tx)
end
local function acierr(msg)
	error("[ACILIB] "..msg)
end
local function udimshort(x,y)
	return UDim2.new(x,0,y,0)
end
local PRIMARYTWINF = TweenInfo.new(0.45,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
local DARKRED = Color3.fromRGB(112, 51, 7)
local DARKGREEN = Color3.fromRGB(7,112,45)
local LIGHTGREEN = Color3.fromRGB(16, 252, 98)
local WHITE = Color3.new(1,1,1)
local function setuptextobj(obj:TextLabel)
	obj.TextColor3 = WHITE
	obj.BackgroundColor3 = DARKGREEN
	obj.BackgroundTransparency = 0.5
	obj.BorderSizePixel = 0
	obj.TextScaled = true
	obj.FontFace = Font.new("rbxassetid://12187607287", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
end
local tabs = {}
function Acilib:Tab(params)
	if #tabs >= 8 then
		acierr("Cannot create more than 8 tabs! (may be fixed in a patch/rewrite)")
	end
	local controller = {}
	-- getting params
	local titletext = default(params["Title"], "Tab")
	-- creating a tab
	local tab = {
		t=titletext,
		c={}
	}
	table.insert(tabs,tab)
	-- adding functions to controller
	function controller:Button(params) -- kind 0
		-- getting params
		local text = default(params["Text"], "Button")
		local callback = default(params["Callback"], function() dbgprint("[ACILIB] Default Button Callback") end)
		table.insert(tab.c, {kind=0, t=text, cb=callback})
	end
	function controller:Toggle(params) -- kind 1
		-- getting params
		local text = default(params["Text"], "Toggle")
		local defaultvalue = default(params["DefaultValue"], false)
		local callback = default(params["Callback"], function(Value) dbgprint("[ACILIB] Default Toggle Callback: "..tostring(Value)) end)
		table.insert(tab.c, {kind=1, t=text, d=defaultvalue, cb=callback})
	end
	return controller
end
local LOADED = false
function Acilib:Load(params)
	if LOADED then
		acierr("Cannot load more than once!")
	end
	LOADED = true
	local POSXDEFAULT = workspace.CurrentCamera.ViewportSize.X*0.62
	local POSYDEFAULT = workspace.CurrentCamera.ViewportSize.Y*0.28
	-- loading params
	local windowtitle = default(params["Title"], "Window")
	local isdraggable = default(params["Draggable"], true)
	-- creating objects
	local s = Instance.new("ScreenGui")
	s.ResetOnSpawn = false
	s.IgnoreGuiInset = true
	s.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local cg = Instance.new("CanvasGroup")
	cg.Parent = s
	cg.Position = UDim2.new(0,POSXDEFAULT,0,POSYDEFAULT)
	cg.Size = udimshort(0.325,0.475)
	cg.ZIndex = 98
	cg.BorderSizePixel = 0
	local corner = Instance.new("UICorner")
	corner.Parent = cg
	corner.CornerRadius = UDim.new(0.06,0)
	local nonbase = Instance.new("Frame")
	nonbase.Parent = cg
	nonbase.Size = udimshort(1,1)
	nonbase.BackgroundColor3 = Color3.new(1,1,1)
	nonbase.ZIndex = 99
	nonbase.BorderSizePixel = 0
	local bar = Instance.new("ImageLabel")
	bar.Parent = nonbase
	bar.BackgroundTransparency = 1
	bar.ImageColor3 = DARKGREEN
	bar.ImageTransparency = 0.5
	bar.Image = "http://www.roblox.com/asset/?id=135235937441219"
	bar.Position = udimshort(0.25,0.125)
	bar.Size = udimshort(0.03,0.85)
	local grad = Instance.new("UIGradient")
	grad.Parent = nonbase
	grad.Rotation = 70
	grad.Color = ColorSequence.new(Color3.fromRGB(32,39,33), Color3.fromRGB(35,54,45))
	local content = Instance.new("ScrollingFrame")
	content.Parent = nonbase
	content.BackgroundColor3 = DARKGREEN
	content.BorderSizePixel = 0
	content.ScrollBarThickness = 0
	content.BackgroundTransparency = 0.75
	content.Position = udimshort(0.28,0.1)
	content.Size = udimshort(0.72,0.9)
	local titlebar = Instance.new("TextLabel")
	setuptextobj(titlebar)
	titlebar.Parent = cg
	titlebar.ZIndex = 110
	titlebar.Text = windowtitle.." | Acilib"
	titlebar.BackgroundTransparency = 0.5
	titlebar.Position = udimshort(0,0)
	titlebar.Size = udimshort(0.85,0.1)
	titlebar.BorderSizePixel = 0
	titlebar.Active = true -- so wont be handled by other scripts
	local closebtn = Instance.new("TextButton")
	setuptextobj(closebtn)
	closebtn.Parent = cg
	closebtn.ZIndex = 110
	closebtn.AutoButtonColor = false
	closebtn.Text = "X"
	closebtn.BackgroundTransparency = 0
	closebtn.BackgroundColor3 = DARKRED
	closebtn.Position = udimshort(0.925,0)
	closebtn.Size = udimshort(0.075,0.1)
	local hidebtn = Instance.new("TextButton")
	setuptextobj(hidebtn)
	hidebtn.Parent = cg
	hidebtn.ZIndex = 110
	hidebtn.AutoButtonColor = false
	hidebtn.Text = "V"
	hidebtn.BackgroundTransparency = 0
	hidebtn.Position = udimshort(0.85,0)
	hidebtn.Size = udimshort(0.075,0.1)
	-- adding base responses
	closebtn.Activated:Connect(function()
		s:Destroy()
	end)
	local OPEN = true
	local INHIDEANIM = false
	hidebtn.Activated:Connect(function()
		if INHIDEANIM then
			return
		end
		INHIDEANIM = true
		OPEN = not OPEN
		if OPEN then
			TWS:Create(cg,PRIMARYTWINF,{Size=udimshort(0.275,0.475)}):Play()
			TWS:Create(hidebtn,PRIMARYTWINF,{Size=udimshort(0.075,0.1),Position=udimshort(0.85,0),Rotation=0}):Play()
			TWS:Create(closebtn,PRIMARYTWINF,{Size=udimshort(0.075,0.1),Position=udimshort(0.925,0)}):Play()
			TWS:Create(corner,PRIMARYTWINF,{CornerRadius=UDim.new(0.08,0)}):Play()
		else
			TWS:Create(cg,PRIMARYTWINF,{Size=udimshort(0.04,0.05)}):Play()
			TWS:Create(hidebtn,PRIMARYTWINF,{Size=udimshort(0.5,1),Position=udimshort(0,0),Rotation=180}):Play()
			TWS:Create(closebtn,PRIMARYTWINF,{Size=udimshort(0.5,1),Position=udimshort(0.5,0)}):Play()
			TWS:Create(corner,PRIMARYTWINF,{CornerRadius=UDim.new(0.4,0)}):Play()
		end
		task.wait(PRIMARYTWINF.Time)
		INHIDEANIM = false
	end)
	if isdraggable then
		local HOLDING = false
		local LASTMX = nil
		local LASTMY = nil
		titlebar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				LASTMX = input.Position.X
				LASTMY = input.Position.Y
				HOLDING = true
			end
		end)
		UIS.InputEnded:Connect(function(input, _)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				HOLDING = false
			end
		end)
		UIS.InputChanged:Connect(function(input, _)
			if HOLDING then
				local DIFFX = LASTMX-input.Position.X
				local DIFFY = LASTMY-input.Position.Y
				cg.Position = UDim2.new(0,cg.Position.X.Offset-DIFFX,0,cg.Position.Y.Offset-DIFFY)
				LASTMX = input.Position.X
				LASTMY = input.Position.Y
			end
		end)
	end
	local function loadcontents(tabcontents)
		content:ClearAllChildren()
		if #tabcontents == 0 then
			return
		end
		local APPENDPOSY = 0.03
		local POSYMULT = 0.12
		local BTNSIZEY = 0.1
		content.CanvasSize = udimshort(0,0,0,0)
		if #tabcontents > 8 then -- adjust scale here later
			
		end
		for ix, item in pairs(tabcontents) do
			ix=ix-1
			local btn = Instance.new("TextButton")
			setuptextobj(btn)
			btn.Parent = content
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.Text = "   "..item.t
			btn.AutoButtonColor = false
			btn.BackgroundColor3 = DARKGREEN
			btn.BackgroundTransparency = 0.5
			btn.Position = udimshort(0.02, APPENDPOSY+(ix*POSYMULT))
			btn.Size = udimshort(0.96, BTNSIZEY)
			local btncorner = Instance.new("UICorner")
			btncorner.Parent = btn
			btncorner.CornerRadius = UDim.new(0.3,0)
			dbgprint(item)
			if item.kind == 0 then
				btn.Activated:Connect(function()
					item.cb()
				end)
			elseif item.kind == 1 then
				local v = item.d
				btn.Activated:Connect(function()
					v = not v
					item.cb(v)
					if v then
						TWS:Create(btn, PRIMARYTWINF, {BackgroundColor3=LIGHTGREEN}):Play()
					else
						TWS:Create(btn, PRIMARYTWINF, {BackgroundColor3=DARKGREEN}):Play()
					end
				end)
			end
		end
	end
	-- adding tabs
	local curtabbtn = nil
	local tabchangeanim = false
	for tabid, tab in pairs(tabs) do
		local tabbtn = Instance.new("TextButton")
		setuptextobj(tabbtn)
		tabbtn.Parent = nonbase
		tabbtn.BackgroundColor3 = DARKGREEN
		tabbtn.AutoButtonColor = false
		tabbtn.Text = tab.t
		tabbtn.Position = udimshort(0.007,0.05+(tabid*0.1))
		tabbtn.Size = udimshort(0.245, 0.08)
		local corner = Instance.new("UICorner")
		corner.Parent = tabbtn
		corner.CornerRadius = UDim.new(0.2,0)
		if tabid == 1 then
			curtabbtn = tabbtn
			tabbtn.BackgroundColor3 = LIGHTGREEN
			loadcontents(tab.c)
		end
		tabbtn.Activated:Connect(function()
			if curtabbtn ~= tabbtn then
				if not tabchangeanim then
					tabchangeanim = true
					TWS:Create(curtabbtn, PRIMARYTWINF, {BackgroundColor3=DARKGREEN}):Play()
					TWS:Create(tabbtn, PRIMARYTWINF, {BackgroundColor3=LIGHTGREEN}):Play()
					curtabbtn = tabbtn
					loadcontents(tab.c)
					task.wait(PRIMARYTWINF.Time)
					tabchangeanim = false
				end
			end
		end)
	end
	-- end
	s.Parent = game.Players.LocalPlayer.PlayerGui
end
function Acilib:Notify(params)
	-- getting params
	dbgprint(params)
	local title = default(params["Title"], "Title")
	local content = default(params["Content"], "Example Content")
	local icon = default(params["Icon"], "")
	local duration = default(params["Duration"], 5)
	if duration < 1 then duration = 1 end
end
return Acilib
