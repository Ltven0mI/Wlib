loader = {}

loader.sys = {}		--Loader Systems
loader.sys.cb = {}		--Loader Callbacks
loader.sys.cb.draw = {}
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
loader.sys.cb.run = {}
loader.sys.cb.textinput = {}
loader.sys.cb.threaderror = {}
loader.sys.cb.update = {}
loader.sys.cb.visible = {}


loader.systemCount = 0
loader.sortedSystems = {}

loader.lib = {}		--Loader Libraries

-- Callbacks --
function loader.draw()
	for priority, sys in pairs(loader.sys.cb.draw) do
		if sys.draw then sys.draw() end
	end
end

function loader.errhand(msg)
	for priority, sys in pairs(loader.sys.cb.errhand) do
		if sys.errhand then sys.errhand() end
	end
end

function loader.focus(f)
	for priority, sys in pairs(loader.sys.cb.focus) do
		if sys.focus then sys.focus() end
	end
end

function loader.gamepadaxis(joystick,axis,value)
	for priority, sys in pairs(loader.sys.cb.gamepadaxis) do
		if sys.gamepadaxis then sys.gamepadaxis(joystick, axis, value) end
	end
end

function loader.gamepadpressed(joystick,button)
	for priority, sys in pairs(loader.sys.cb.gamepadpressed) do
		if sys.gamepadpressed then sys.gamepadpressed(joystick, button) end
	end
end

function loader.gamepadreleased(joystick,button)
	for priority, sys in pairs(loader.sys.cb.gamepadreleased) do
		if sys.gamepadreleased then sys.gamepadreleased(joystick, button) end
	end
end

function loader.joystickadded(joystick)
	for priority, sys in pairs(loader.sys.cb.joystickadded) do
		if sys.joystickadded then sys.joystickadded(joystick) end
	end
end

function loader.joystickaxis(joystick,axis,value)
	for priority, sys in pairs(loader.sys.cb.joystickaxis) do
		if sys.joystickaxis then sys.joystickaxis(joystick, axis, value) end
	end
end

function loader.joystickhat(joystick,hat,direction)
	for priority, sys in pairs(loader.sys.cb.joystickhat) do
		if sys.joystickhat then sys.joystickhat(joystick, axis, value) end
	end
end

function loader.joystickpressed(joystick,button)
	for priority, sys in pairs(loader.sys.cb.joystickpressed) do
		if sys.joystickpressed then sys.joystickpressed(joystick, button) end
	end
end

function loader.joystickreleased(joystick,button)
	for priority, sys in pairs(loader.sys.cb.joystickreleased) do
		if sys.joystickreleased then sys.joystickreleased(joystick, button) end
	end
end

function loader.joystickremoved(joystick)
	for priority, sys in pairs(loader.sys.cb.joystickremoved) do
		if sys.joystickremoved then sys.joystickremoved(joystick) end
	end
end

function loader.keypressed(key,isrepeat)
	for priority, sys in pairs(loader.sys.cb.keypressed) do
		if sys.keypressed then sys.keypressed(key, isrepeat) end
	end
end

function loader.keyreleased(key)
	for priority, sys in pairs(loader.sys.cb.keyreleased) do
		if sys.keyreleased then sys.keyreleased(key) end
	end
end

function loader.load(arg)
	loader.getLibraries("/libraries")
	loader.getSystems("/systems")

	for priority, sys in pairs(loader.sys.cb.load) do
		if sys.load then sys.load(arg) end
	end
end

function loader.mousefocus(f)
	for priority, sys in pairs(loader.sys.cb.mousefocus) do
		if sys.mousefocus then sys.mousefocus(f) end
	end
end

function loader.mousepressed(x,y,button)
	for priority, sys in pairs(loader.sys.cb.mousepressed) do
		if sys.mousepressed then sys.mousepressed(x, y, button) end
	end
end

function loader.mousereleased(x,y,button)
	for priority, sys in pairs(loader.sys.cb.mousereleased) do
		if sys.mousereleased then sys.mousereleased(x, y, button) end
	end
end

function loader.quit()
	for priority, sys in pairs(loader.sys.cb.quit) do
		if sys.quit then sys.quit() end
	end
end

function loader.resize(w,h)
	for priority, sys in pairs(loader.sys.cb.resize) do
		if sys.resize then sys.resize() end
	end
end

function loader.run()
	for priority, sys in pairs(loader.sys.cb.run) do
		if sys.run then sys.run() end
	end
end

function loader.textinput(text)
	for priority, sys in pairs(loader.sys.cb.textinput) do
		if sys.textinput then sys.textinput(text) end
	end
end

function loader.threaderror(thread,errorstr)
	for priority, sys in pairs(loader.sys.cb.threaderror) do
		if sys.threaderror then sys.threaderror(thread, errorstr) end
	end
end

function loader.update(dt)
	for priority, sys in pairs(loader.sys.cb.update) do
		if sys.update then sys.update(dt) end
	end
end

function loader.visible(v)
	for priority, sys in pairs(loader.sys.cb.visible) do
		if sys.visible then sys.visible(v) end
	end
end

-- Functions --
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
						print("[LOADER] Added system '"..key.."' from directory '"..dir.."' to unsorted list")
					end
				end
			elseif love.filesystem.isDirectory(dir.."/"..item) then
				loader.getSystems(dir.."/"..item, true, systems)
			end
		end
	end
	if not isrepeat then print(""); loader.sortSystems(systems) end
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
							print("[LOADER] Giving system '"..key.."' priority '"..priority.."'")
							loader.sortedSystems[priority] = sys
						else
							local holdKey = holdSys.systemKey
							local holdNewPri = priority
							local holdNewSys = holdSys
							print("[LOADER] Tried giving system '"..key.."' priority '"..priority.."'")
							print("[LOADER] System '"..holdKey.."' with priority '"..priority.."' already exsits")
							while holdNewSys do
								holdNewPri = holdNewPri + 0.1
								holdNewSys = loader.sortedSystems[holdNewPri]
							end
							print("[LOADER] Giving system '"..key.."' priority '"..holdNewPri.."'")
							loader.sortedSystems[holdNewPri] = sys
						end
					elseif type(priority) == "table" then

					end
				end
			end
		end
		print("")
		loader.filterSystems()
	end
end

function loader.filterSystems()
	if loader.sortedSystems then
		for priority, sys in pairs(loader.sortedSystems) do
			if sys then
				local priority = sys.runPriority
				local key = sys.systemKey
				if priority and key then
					debug.start("loadersystems", "[LOADER] Registering callbacks for system '"..key.."'")
					if sys.draw then loader.sys.cb.draw[priority] = sys; print("[LOADER] |   Registered callback 'Draw'") end
					if sys.errhand then loader.sys.cb.errhand[priority] = sys; print("[LOADER] |   Registered callback 'ErrHand'") end
					if sys.focus then loader.sys.cb.focus[priority] = sys; print("[LOADER] |   Registered callback 'Focus'") end
					if sys.gamepadaxis then loader.sys.cb.gamepadaxis[priority] = sys; print("[LOADER] |   Registered callback 'GamepadAxis'") end
					if sys.gamepadpressed then loader.sys.cb.gamepadpressed[priority] = sys; print("[LOADER] |   Registered callback 'GamepadPressed'") end
					if sys.gamepadreleased then loader.sys.cb.gamepadreleased[priority] = sys; print("[LOADER] |   Registered callback 'GamepadReleased'") end
					if sys.joystickadded then loader.sys.cb.joystickadded[priority] = sys; print("[LOADER] |   Registered callback 'JoystickAdded'") end
					if sys.joystickaxis then loader.sys.cb.joystickaxis[priority] = sys; print("[LOADER] |   Registered callback 'JoystickAxis'") end
					if sys.joystickhat then loader.sys.cb.joystickhat[priority] = sys; print("[LOADER] |   Registered callback 'JoystickHat'") end
					if sys.joystickpressed then loader.sys.cb.joystickpressed[priority] = sys; print("[LOADER] |   Registered callback 'JoystickPressed'") end
					if sys.joystickreleased then loader.sys.cb.joystickreleased[priority] = sys; print("[LOADER] |   Registered callback 'JoystickReleased'") end
					if sys.joystickremoved then loader.sys.cb.joystickremoved[priority] = sys; print("[LOADER] |   Registered callback 'JoystickRemoved'") end
					if sys.keypressed then loader.sys.cb.keypressed[priority] = sys; print("[LOADER] |   Registered callback 'KeyPressed'") end
					if sys.keyreleased then loader.sys.cb.keyreleased[priority] = sys; print("[LOADER] |   Registered callback 'KeyReleased'") end
					if sys.load then loader.sys.cb.load[priority] = sys; print("[LOADER] |   Registered callback 'Load'") end
					if sys.mousefocus then loader.sys.cb.mousefocus[priority] = sys; print("[LOADER] |   Registered callback 'MouseFocus'") end
					if sys.mousepressed then loader.sys.cb.mousepressed[priority] = sys; print("[LOADER] |   Registered callback 'MousePressed'") end
					if sys.mousereleased then loader.sys.cb.mousereleased[priority] = sys; print("[LOADER] |   Registered callback 'MouseReleased'") end
					if sys.quit then loader.sys.cb.quit[priority] = sys; print("[LOADER] |   Registered callback 'Quit'") end
					if sys.resize then loader.sys.cb.resize[priority] = sys; print("[LOADER] |   Registered callback 'Resize'") end
					if sys.run then loader.sys.cb.run[priority] = sys; print("[LOADER] |   Registered callback 'Run'") end
					if sys.textinput then loader.sys.cb.textinput[priority] = sys; print("[LOADER] |   Registered callback 'TextInput'") end
					if sys.threaderror then loader.sys.cb.threaderror[priority] = sys; print("[LOADER] |   Registered callback 'ThreadError'") end
					if sys.update then loader.sys.cb.update[priority] = sys; print("[LOADER] |   Registered callback 'Update'") end
					if sys.visible then loader.sys.cb.visible[priority] = sys; print("[LOADER] |   Registered callback 'Visible'") end
					debug.stop("loadersystems", "[LOADER] Done in /t", "/t")
					--print("[LOADER] Registered all callbacks for system '"..key.."'")
					print("")
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
					print("[LOADER] Adding lib '"..key.."' from directory '"..dir.."'")
					loader.lib[key] = holdLib
				end
			elseif love.filesystem.isDirectory(dir.."/"..item) then
				loader.getLibraries(dir.."/"..item, true)
			end
		end
	end
	if not isrepeat then print("") end
end

return loader