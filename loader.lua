loader = {}

loader.sys = {}		--Loader Systems
loader.sys.cb = {}		--Loader Callbacks
loader.sys.cb.drawworld = {}
loader.sys.cb.drawscreen = {}
loader.sys.cb.errhand = {}
loader.sys.cb.focus = {}
loader.sys.cb.gamepadaxis = {}
loader.sys.cb.gamepadpressed = {}
loader.sys.cb.gamepadreleased = {}
loader.sys.cb.joystickadded = {}
loader.sys.cb.joystickaxis = {}
loader.sys.cb.joystickhat = {}
loader.sys.cb.joystickpressed = {}
loader.sys.cb.joystickreleased = {}
loader.sys.cb.joystickremoved = {}
loader.sys.cb.keypressed = {}
loader.sys.cb.keyreleased = {}
loader.sys.cb.load = {}
loader.sys.cb.mousefocus = {}
loader.sys.cb.mousepressed = {}
loader.sys.cb.mousereleased = {}
loader.sys.cb.quit = {}
loader.sys.cb.resize = {}
loader.sys.cb.textinput = {}
loader.sys.cb.threaderror = {}
loader.sys.cb.update = {}
loader.sys.cb.visible = {}


loader.systemCount = 0
loader.highestPriority = 0
loader.sortedSystems = {}

loader.curPri = 0

loader.lib = {}		--Loader Libraries

-- Callbacks --
function loader.draw()
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.drawworld[i]
		if sys then loader.curPri = i; sys.drawworld(); i = i + 0.1 else i = math.floor(i) + 1 end
	end

	local ii = 1
	while ii <= loader.highestPriority do
		local sys = loader.sys.cb.drawscreen[ii]
		if sys then loader.curPri = ii; sys.drawscreen(); ii = ii + 0.1 else ii = math.floor(ii) + 1 end
	end
end

function loader.errhand(msg)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.errhand[i]
		if sys then loader.curPri = i; sys.errhand(msg); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.focus(f)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.focus[i]
		if sys then loader.curPri = i; sys.focus(f); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.gamepadaxis(joystick,axis,value)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.gamepadaxis[i]
		if sys then loader.curPri = i; sys.gamepadaxis(joystick, axis, value); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.gamepadpressed(joystick,button)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.gamepadpressed[i]
		if sys then loader.curPri = i; sys.gamepadpressed(joystick, button); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.gamepadreleased(joystick,button)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.gamepadreleased[i]
		if sys then loader.curPri = i; sys.gamepadreleased(joystick, button); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.joystickadded(joystick)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.joystickadded[i]
		if sys then loader.curPri = i; sys.joystickadded(joystick); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.joystickaxis(joystick,axis,value)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.joystickaxis[i]
		if sys then loader.curPri = i; sys.joystickaxis(joystick, axis, value); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.joystickhat(joystick,hat,direction)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.joystickhat[i]
		if sys then loader.curPri = i; sys.joystickhat(joystick, hat, direction); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.joystickpressed(joystick,button)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.joystickpressed[i]
		if sys then loader.curPri = i; sys.joystickpressed(joystick, button); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.joystickreleased(joystick,button)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.joystickreleased[i]
		if sys then loader.curPri = i; sys.joystickreleased(joystick, button); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.joystickremoved(joystick)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.joystickremoved[i]
		if sys then loader.curPri = i; sys.joystickremoved(joystick); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.keypressed(key,isrepeat)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.keypressed[i]
		if sys then loader.curPri = i; sys.keypressed(key, isrepeat); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.keyreleased(key)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.keyreleased[i]
		if sys then loader.curPri = i; sys.keyreleased(key); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.load(arg)
	require("/libraries/blacklist/debug")

	loader.getLibraries("/libraries")
	loader.getSystems("/systems")

	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.load[i]
		if sys then loader.curPri = i; sys.load(arg); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.mousefocus(f)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.mousefocus[i]
		if sys then loader.curPri = i; sys.mousefocus(f); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.mousepressed(x,y,button)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.mousepressed[i]
		if sys then loader.curPri = i; sys.mousepressed(x, y, button); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.mousereleased(x,y,button)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.mousereleased[i]
		if sys then loader.curPri = i; sys.mousereleased(x, y, button); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.quit()
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.quit[i]
		if sys then loader.curPri = i; sys.quit(); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.resize(w,h)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.resize[i]
		if sys then loader.curPri = i; sys.resize(w, h); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.textinput(text)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.textinput[i]
		if sys then loader.curPri = i; sys.textinput(text); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.threaderror(thread,errorstr)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.threaderror[i]
		if sys then loader.curPri = i; sys.threaderror(thread, errorstr); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.update(dt)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.update[i]
		if sys then loader.curPri = i; sys.update(dt); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

function loader.visible(v)
	local i = 1
	while i <= loader.highestPriority do
		local sys = loader.sys.cb.visible[i]
		if sys then loader.curPri = i; sys.visible(v); loader.curPri = i; i = i + 0.1 else i = math.floor(i) + 1 end
	end
end

-- Functions --
function loader.getPriority()
	return loader.curPri
end

function loader.getSystems(dir,isrepeat,systems)
	if isrepeat == nil then isrepeat = false end
	if systems == nil then systems = {} end
	local files = love.filesystem.getDirectoryItems(dir)
	local lng = table.getn(files)
	for i=1, lng do
		local item = files[i]
		local key = string.gsub(item, ".lua", "")
		if key then
			if love.filesystem.isFile(dir.."/"..item) then
				local holdSys = require(dir.."/"..key)
				if holdSys and type(holdSys) == "table" then
					if holdSys.systemKey and holdSys.systemKey ~= "" then
						loader.systemCount = loader.systemCount + 1
						systems[loader.systemCount] = holdSys
						debug.log("[LOADER] Added system '"..key.."' from directory '"..dir.."' to unsorted list")
					end
				end
			elseif love.filesystem.isDirectory(dir.."/"..item) and item ~= "blacklist" then
				loader.getSystems(dir.."/"..item, true, systems)
			end
		end
	end
	if not isrepeat then debug.log(""); loader.sortSystems(systems) end
end

function loader.sortSystems(systems)
	if systems ~= nil then
		local lng = table.getn(systems)
		for i=1, lng do
			local sys = systems[i]
			if sys then
				local priority = sys.runPriority
				local key = sys.systemKey
				if priority and key then
					if type(priority) == "number" then
						local holdSys = loader.sortedSystems[priority]
						if not holdSys then
							debug.log("[LOADER] Giving system '"..key.."' priority '"..priority.."'")
							loader.sortedSystems[priority] = sys
							if priority > loader.highestPriority then loader.highestPriority = priority end
						else
							local holdKey = holdSys.systemKey
							local holdNewPri = priority
							local holdNewSys = holdSys
							debug.log("[LOADER] Tried giving system '"..key.."' priority '"..priority.."'")
							debug.log("[LOADER] System '"..holdKey.."' with priority '"..priority.."' already exsits")
							while holdNewSys do
								holdNewPri = holdNewPri + 0.1
								holdNewSys = loader.sortedSystems[holdNewPri]
							end
							debug.log("[LOADER] Giving system '"..key.."' priority '"..holdNewPri.."'")
							loader.sortedSystems[holdNewPri] = sys
							if holdNewPri > loader.highestPriority then loader.highestPriority = holdNewPri end
						end
					elseif type(priority) == "table" then
						for priKey, pri in pairs(priority) do
							local holdSys = loader.sortedSystems[pri]
							if not holdSys then
								debug.log("[LOADER] Giving system '"..key.."' priority '"..pri.."'")
								loader.sortedSystems[pri] = sys
								if pri > loader.highestPriority then loader.highestPriority = pri end
							else
								local holdKey = holdSys.systemKey
								local holdNewPri = pri
								local holdNewSys = holdSys
								debug.log("[LOADER] Tried giving system '"..key.."' priority '"..pri.."'")
								debug.log("[LOADER] System '"..holdKey.."' with priority '"..pri.."' already exsits")
								while holdNewSys do
									holdNewPri = holdNewPri + 0.1
									holdNewSys = loader.sortedSystems[holdNewPri]
								end
								debug.log("[LOADER] Giving system '"..key.."' priority '"..holdNewPri.."'")
								loader.sortedSystems[holdNewPri] = sys
								if holdNewPri > loader.highestPriority then loader.highestPriority = holdNewPri end
							end
						end
					end
				end
			end
		end
		debug.log("")
		loader.filterSystems()
	end
end

function loader.filterSystems()
	if loader.sortedSystems then
		for priority, sys in pairs(loader.sortedSystems) do
			if sys then
				local key = sys.systemKey
				if priority and key then
					debug.start("loadersystems", "[LOADER] Registering callbacks for system '"..key.."'")
					if sys.drawworld then loader.sys.cb.drawworld[priority] = sys; debug.log("[LOADER] |   Registered callback 'DrawWorld'") end
					if sys.drawscreen then loader.sys.cb.drawscreen[priority] = sys; debug.log("[LOADER] |   Registered callback 'DrawScreen'") end
					if sys.errhand then loader.sys.cb.errhand[priority] = sys; debug.log("[LOADER] |   Registered callback 'ErrHand'") end
					if sys.focus then loader.sys.cb.focus[priority] = sys; debug.log("[LOADER] |   Registered callback 'Focus'") end
					if sys.gamepadaxis then loader.sys.cb.gamepadaxis[priority] = sys; debug.log("[LOADER] |   Registered callback 'GamepadAxis'") end
					if sys.gamepadpressed then loader.sys.cb.gamepadpressed[priority] = sys; debug.log("[LOADER] |   Registered callback 'GamepadPressed'") end
					if sys.gamepadreleased then loader.sys.cb.gamepadreleased[priority] = sys; debug.log("[LOADER] |   Registered callback 'GamepadReleased'") end
					if sys.joystickadded then loader.sys.cb.joystickadded[priority] = sys; debug.log("[LOADER] |   Registered callback 'JoystickAdded'") end
					if sys.joystickaxis then loader.sys.cb.joystickaxis[priority] = sys; debug.log("[LOADER] |   Registered callback 'JoystickAxis'") end
					if sys.joystickhat then loader.sys.cb.joystickhat[priority] = sys; debug.log("[LOADER] |   Registered callback 'JoystickHat'") end
					if sys.joystickpressed then loader.sys.cb.joystickpressed[priority] = sys; debug.log("[LOADER] |   Registered callback 'JoystickPressed'") end
					if sys.joystickreleased then loader.sys.cb.joystickreleased[priority] = sys; debug.log("[LOADER] |   Registered callback 'JoystickReleased'") end
					if sys.joystickremoved then loader.sys.cb.joystickremoved[priority] = sys; debug.log("[LOADER] |   Registered callback 'JoystickRemoved'") end
					if sys.keypressed then loader.sys.cb.keypressed[priority] = sys; debug.log("[LOADER] |   Registered callback 'KeyPressed'") end
					if sys.keyreleased then loader.sys.cb.keyreleased[priority] = sys; debug.log("[LOADER] |   Registered callback 'KeyReleased'") end
					if sys.load then loader.sys.cb.load[priority] = sys; debug.log("[LOADER] |   Registered callback 'Load'") end
					if sys.mousefocus then loader.sys.cb.mousefocus[priority] = sys; debug.log("[LOADER] |   Registered callback 'MouseFocus'") end
					if sys.mousepressed then loader.sys.cb.mousepressed[priority] = sys; debug.log("[LOADER] |   Registered callback 'MousePressed'") end
					if sys.mousereleased then loader.sys.cb.mousereleased[priority] = sys; debug.log("[LOADER] |   Registered callback 'MouseReleased'") end
					if sys.quit then loader.sys.cb.quit[priority] = sys; debug.log("[LOADER] |   Registered callback 'Quit'") end
					if sys.resize then loader.sys.cb.resize[priority] = sys; debug.log("[LOADER] |   Registered callback 'Resize'") end
					if sys.textinput then loader.sys.cb.textinput[priority] = sys; debug.log("[LOADER] |   Registered callback 'TextInput'") end
					if sys.threaderror then loader.sys.cb.threaderror[priority] = sys; debug.log("[LOADER] |   Registered callback 'ThreadError'") end
					if sys.update then loader.sys.cb.update[priority] = sys; debug.log("[LOADER] |   Registered callback 'Update'") end
					if sys.visible then loader.sys.cb.visible[priority] = sys; debug.log("[LOADER] |   Registered callback 'Visible'") end
					debug.stop("loadersystems", "[LOADER] Done in /t", "/t")
					debug.log("")
				end
			end
		end
	end
end

function loader.getLibraries(dir,isrepeat)
	if isrepeat == nil then isrepeat = false end

	local files = love.filesystem.getDirectoryItems(dir)
	local lng = table.getn(files)
	for i=1, lng do
		local item = files[i]
		local key = string.gsub(item, ".lua", "")
		if key then
			if love.filesystem.isFile(dir.."/"..item) then
				local holdLib = require(dir.."/"..key)
				if holdLib and type(holdLib) == "table" then
					debug.log("[LOADER] Adding lib '"..key.."' from directory '"..dir.."'")
					loader.lib[key] = holdLib
				end
			elseif love.filesystem.isDirectory(dir.."/"..item) and item ~= "blacklist" then
				loader.getLibraries(dir.."/"..item, true)
			end
		end
	end
	if not isrepeat then debug.log("") end
end

return loader