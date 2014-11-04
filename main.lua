main = {}
main.loader = require "loader"

-- Variables --
main.debugMode = true
main.font = love.graphics.getFont()

-- Callbacks --
function love.draw()
	main.loader.draw()
end

--[[function love.errhand(msg)
	msg = tostring(msg)

	error_printer(msg, 2)

	if not love.window or not love.graphics or not love.event then
		return
	end

	if not love.graphics.isCreated() or not love.window.isCreated() then
		if not pcall(love.window.setMode, 800, 600) then
			return
		end
	end

	-- Reset state.
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
	end
	if love.joystick then
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration() -- Stop all joystick vibrations.
		end
	end
	if love.audio then love.audio.stop() end
	love.graphics.reset()
	love.graphics.setBackgroundColor(89, 157, 220)
	local font = love.graphics.setNewFont(14)

	love.graphics.setColor(255, 255, 255, 255)

	local trace = debug.traceback()

	love.graphics.clear()
	love.graphics.origin()

	local err = {}

	table.insert(err, "Error\n")
	table.insert(err, msg.."\n\n")

	for l in string.gmatch(trace, "(.-)\n") do
		if not string.match(l, "boot.lua") then
			l = string.gsub(l, "stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end

	local p = table.concat(err, "\n")

	p = string.gsub(p, "\t", "")
	p = string.gsub(p, "%[string \"(.-)\"%]", "%1")

	local function draw()
		love.graphics.clear()
		love.graphics.printf(p, 70, 70, love.graphics.getWidth() - 70)
		love.graphics.present()
	end

	while true do
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return
			end
			if e == "keypressed" and a == "escape" then
				return
			end
		end

		draw()

		if love.timer then
			love.timer.sleep(0.1)
		end
	end
	main.loader.errhand(msg)
end]]

function love.focus(f)
	main.loader.focus(f)
end

function love.gamepadaxis(joystick,axis,value)
	main.loader.gamepadaxis(joystick, axis, value)
end

function love.gamepadpressed(joystick,button)
	main.loader.gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick,button)
	main.loader.gamepadreleased(joystick, button)
end

function love.joystickadded(joystick)
	main.loader.joystickadded(joystick)
end

function love.joystickaxis(joystick,axis,value)
	main.loader.joystickaxis(joystick, axis, value)
end

function love.joystickhat(joystick,hat,direction)
	main.loader.joystickhat(joystick, hat, direction)
end

function love.joystickpressed(joystick,button)
	main.loader.joystickpressed(joystick, button)
end

function love.joystickreleased(joystick,button)
	main.loader.joystickreleased(joystick, button)
end

function love.joystickremoved(joystick)
	main.loader.joystickremoved(joystick)
end

function love.keypressed(key,isrepeat)
	main.loader.keypressed(key, isrepeat)
end

function love.keyreleased(key)
	main.loader.keyreleased(key)
end

function love.load(arg)
	main.loader.load(arg)
end

function love.mousefocus(f)
	main.loader.mousefocus(f)
end

function love.mousepressed(x,y,button)
	main.loader.mousepressed(x, y, button)
end

function love.mousereleased(x,y,button)
	main.loader.mousereleased(x, y, button)
end

function love.quit()
	main.loader.quit()
end

function love.resize(w,h)
	main.loader.resize(w, h)
end

function love.run()
	if love.math then
		love.math.setRandomSeed(os.time())
	end

	if love.event then
		love.event.pump()
	end

	if love.load then love.load(arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local dt = 0

	-- Main loop time.
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for e,a,b,c,d in love.event.poll() do
				if e == "quit" then
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop()
						end
						return
					end
				end
				love.handlers[e](a,b,c,d)
			end
		end

		-- Update dt, as we'll be passing it to update
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end

		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

		if love.window and love.graphics and love.window.isCreated() then
			love.graphics.clear()
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end

	main.loader.run()
end

function love.textinput(text)
	main.loader.textinput(text)
end

function love.threaderror(thread,errorstr)
	main.loader.threaderror(thread, errorstr)
end

function love.update(dt)
	main.loader.update(dt)
end

function love.visible(v)
	main.loader.visible(v)
end