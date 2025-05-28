# Acilib
An easy-to-use and basic UI library supported practically anywhere.
## Using Acilib
First of all, you need to require the library:
```lua
local Acilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SomVanTeam/Acilib/refs/heads/main/main.lua"))()
```
## Making a Tab
You can make a tab this way:
```lua
local Tab = Acilib:Tab({
    Title="Main Tab" -- title of the tab
})
```
Keep in mind, Acilib will not load tabs without any contents
## Making a Button
You can add a button to a tab like this:
```lua
tab:Button({
	Text="Button", -- text on the button
	Callback=function() -- callback that is executed on activation
		print("Callback!")
	end
})
```
## Making a Toggle
You can add a toggle to a tab using this:
```lua
tab:Toggle({
	Text="Toggle", -- text on the toggle
	DefaultValue=false, -- default state of the toggle
	Callback=function(Value) -- callback that is executed on activation
		print("Callback: "..tostring(Value).."!")
	end
})
```
## Finalizing
After making all the elements, it's time to create the window. Acilib will automatically attach all the elements to the created window.
```lua
Acilib:Load({
	Title="Window", -- title of the window
	Draggable=true -- is the window draggable? disabling increases performance slightly
})
```
