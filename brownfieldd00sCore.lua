-- Author: brownfieldd00
-- URL: https://github.com/brownfieldd00/core/blob/main/core.lua
-- RAW: https://raw.githubusercontent.com/brownfieldd00/core/main/core.lua
-- LOADSTRING: core = loadstring(game:HttpGet('https://raw.githubusercontent.com/brownfieldd00/core/main/core.lua'))()
pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/brownfieldd00/core/main/globals.lua'))() end) -- load globals
getgenv = getgenv or getfenv
getgenv().core = {}
local core = getgenv().core
core.strings = {}
core.strings.not_supported = '\89\111\117\114\32\101\120\101\99\117\116\111\114\32\105\115\32\110\111\116\32\115\117\112\112\111\114\116\101\100\32'
core.strings.modules = 'https://raw.githubusercontent.com/brownfieldd00/Roblox/main/Modules/'
function core:gHttp(url, default)
    assert(game.HttpGet, ('%s(HttpGet)'):format(self.strings.not_supported))
    local default = default or nil
    local success, ret = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then return default end
    return ret
end
core.Modules = {}
function core:gModule(name)
    local module_url = ('%s%s.lua'):format(core.strings.modules, name)
    local module = self:gHttp(module_url, false)
    core.Modules[name] = loadstring(module)()
    return core.Modules[name]
end
function core:gPlayer(name)
    local players = game:GetService('Players')
    if name then
        for i, v in pairs(players:GetPlayers()) do
            if v.Name:lower():sub(1, #name) == name:lower() then
                return v
            end
        end
        return nil
    end
    return players.LocalPlayer
end
function core:notify(title, text, duration)
    if not title then return end
    local text = text or ''
    local duration = duration or 3
	game:GetService("StarterGui"):SetCore("SendNotification", { Title = title, Text = text, Duration = duration })
	return true
end
function core:cTween(object, properties, duration)
    local duration = duration or 1
    local tweenService = game:GetService('TweenService')
    local tween = tweenService:Create(object, TweenInfo.new(duration), properties)
    tween:Play()
    return true
end
core.Events = {}
core.Events.__index = core.Events
function core:bindEvent(name, event, callback)
    self.Events[name] = event:Connect(function(...)
        return pcall(callback, ...)
    end)
    return self.Events[name]
end
function core:getConnection(name)
    return core.Events[name]
end
function core:require(name, id) -- get a module from Roblox and load it as a module
    local success, module = pcall(function()
        return loadstring(game:GetObjects('rbxassetid://' .. tostring(id))[1].Source)()
    end)
    if success then
        core.Modules[name] = module
        return core.Modules[name]
    else
        return { error = true }
    end
end
function core:registerSession()
    run = true
    getgenv()[tostring(game.JobId)] = {
        stop = function()
            run = false
        end
    }
    return true
end
function core:stopRunningInstance()
    assert(getgenv, ('%s(getgenv)'):format(self.strings.not_supported))
    if getgenv()[tostring(game.JobId)] then
        getgenv()[tostring(game.JobId)].stop()
        return true
    else
        return false
    end
end
function core:gTool(name)
    if not name then return self:gPlayer().Character:FindFirstChildOfClass('Tool') end
    return self:gPlayer().Character:FindFirstChild(name) or self:gPlayer().Backpack:FindFirstChild(name)
end
function core:eTool(name)
    local tool = nil
    for i, v in pairs(core:gPlayer().Backpack:GetChildren()) do
        if v.Name == name then tool = v break end
    end
    for i, v in pairs(core:gPlayer().Character:GetChildren()) do
        if v.Name == name and v:IsA('Tool') then tool = v break end
    end
    if tool then
        tool.Parent = self:gPlayer().Character
    end
    return tool
end
function core:init(game_name, make_window)
    local title = game_name
    title = title .. 'GUI - github.com/brownfieldd00'
    self:stopRunningInstance()
    self:registerSession()
    if make_window then
        library = core:gModule('UiLibrary')
        return library:AddWindow(title)
    end
end
function core:flip(bool)
    return not bool
end
function core:eq(a, b)
    return a == b
end
function core:higher(a, b)
    return a > b
end
function core:lower(a, b)
    return a < b
end
function core:magnitude(a, b)
    return (a - b).Magnitude
end
function core:awaitGameLoaded()
    if not game:IsLoaded() then game.Loaded:Wait() end
    return true
end
function core:getTableFromGC(ressemblances)
    assert(getgc, ('%s(getgc)'):format(self.strings.not_supported))
	ressemblances = ressemblances or { 'None' }
	local gc = getgc(true)
	local Table;
	for i, v in pairs(gc) do
		if type(v) == 'table' then
			local module = v
			local amountMatched = 0
			for _, ressemblance in pairs(ressemblances) do
				for module_key, module_value in pairs(module) do
					if module_key == ressemblance then
						amountMatched = amountMatched + 1
					end
				end
			end
			if amountMatched == #ressemblances then
				Table = module
				return module
			end
		end
	end
	return Table or {}
end
function core:blehh()
    local screenGui = Instance.new('ScreenGui')
    screenGui.Parent = game:GetService('CoreGui')
    screenGui.IgnoreGuiInset = true
    local imageLabel = Instance.new('ImageLabel')
    imageLabel.BackgroundTransparency = 1
    imageLabel.ImageTransparency = 1
    imageLabel.Parent = screenGui
    imageLabel.Image = 'http://www.roblox.com/asset/?id=11832123003'
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    local ts = game:GetService('TweenService')
    local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = ts:Create(imageLabel, tweenInfo, { ImageTransparency = 0 })
    tween:Play()
    task.wait(1.5)
    local tween1 = ts:Create(imageLabel, tweenInfo, { ImageTransparency = 1 })
    tween1:Play()
    task.wait(1.5)
    return true
end
function core:createUserdata(t, mt)
	local proxy = newproxy(mt and true or false)
	if not meta then return proxy end
	local meta = getmetatable(proxy)
	meta.__index = t
	meta.__address = tostring(proxy)
	function t:getAddress()
		return meta.__address
	end
    function t:getTable()
        return meta ^ 1
    end
	if mt then
		for k, v in next, mt do
			if k == 'onNewIndex' then
				meta.__newindex = v
			elseif k == 'onIndex' then
				meta.__index = v
			elseif k == 'onLengthGet' then
				meta.__len = v
			elseif k == 'onCall' then
				meta.__call = v
			elseif k == '__pow' then
				continue -- should not overwrite this function
			else
				meta[k] = v
			end
		end
	end
	t.setItem = function(userdata, k, v)
		local main_table = userdata ^ 1 -- this will call __pow in the metatable
		return rawset(main_table, k, v)
	end

	-- Set important stuff
	meta.__pow = function(this_proxy, pow) if pow == 1 then return t else return 0 end end -- doing proxy ^ 1 will return the table
	self.userdatas[meta.__address] = proxy -- add the proxy to the userdatas table
	return proxy
end
function core:hook_print_localscript()
    assert(getcallingscript, ('%s(getcallingscript)'):format(self.strings.not_supported))
    assert(getrenv, ('%s(getrenv)'):format(self.strings.not_supported))
    assert(hookfunction, ('%s(hookfunction)'):format(self.strings.not_supported))
    assert(checkcaller, ('%s(checkcaller)'):format(self.strings.not_supported))
    local original;
    original = hookfunction(getrenv().print, function(...)
        if checkcaller() then
            return original(...)
        end
        original('game.' .. getcallingscript():GetFullName() ..'\n', ...)
        return nil
    end)
end

return getgenv().core
