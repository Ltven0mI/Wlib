ui = {}

-- Variables --
ui.var = {}
ui.var.bgIdle = {r=255,g=255,b=255,a=255}
ui.var.bgActive = {r=255,g=255,b=255,a=255}
ui.var.bgHover = {r=255,g=255,b=255,a=255}
ui.var.fgIdle = {r=0,g=0,b=0,a=255}
ui.var.fgActive = {r=0,g=0,b=0,a=255}
ui.var.fgHover = {r=0,g=0,b=0,a=255}

ui.var.style = "fill"
ui.var.lineWidth = 1

-- Functions --
function ui.mouseOver(x,y,w,h)
	if x and y and w and h then
		local mx, my = love.mouse.getPosition()
		if mx>x and mx<x+w and my>y and my<y+h then return true else return false end
	else
		debug.log("[ERROR] Incorrect call to function 'ui.mouseOver(x,y,w,h)'")
	end
end

function ui.updateColor(cType,md,mo)
	if cType and type(cType) == "string" and md ~= nil and mo ~= nil then
		if cType == "fg" then
			if mo then if md then ui.setCurrentColor(ui.var.fgActive) else ui.setCurrentColor(ui.var.fgHover) end else ui.setCurrentColor(ui.var.fgIdle) end
		elseif cType == "bg" then
			if mo then if md then ui.setCurrentColor(ui.var.bgActive) else ui.setCurrentColor(ui.var.bgHover) end else ui.setCurrentColor(ui.var.bgIdle) end
		else
			debug.log("[WARNING] Argument 'cType' in call to function 'ui.updateColor(cType,md,mo)' must be 'fg' or 'bg'")
		end
	else
		debug.log("[ERROR] Incorrect call to function 'ui.updateColor(cType,md,mo)'")
	end
end

function ui.setCurrentColor(color)
	if color and type(color) == "table" and color.r and color.g and color.b and color.a then
		love.graphics.setColor(color.r, color.g, color.b, color.a)
	else
		debug.log("[ERROR] Incorrect call to function 'ui.setCurrentColor(color)'")
	end
end

function ui.setColor(cType,cState,color)
	if cType and type(cType) == "string" and cState and type(cState) == "string" and color and type(color) == "table" then
		if cType == "fg" then
			if cState == "idle" then
				ui.var.fgIdle = color
			elseif cState == "hover" then
				ui.var.fgHover = color
			elseif cState == "active" then
				ui.var.fgActive = color
			else
				debug.log("[WARNING] Argument 'cState' in call to function 'ui.setColor(cType,cState,color)' must be 'idle' 'hover' or 'active'")
			end
		elseif cType == "bg" then
			if cState == "idle" then
				ui.var.bgIdle = color
			elseif cState == "hover" then
				ui.var.bgHover = color
			elseif cState == "active" then
				ui.var.bgActive = color
			else
				debug.log("[WARNING] Argument 'cState' in call to function 'ui.setColor(cType,cState,color)' must be 'idle' 'hover' or 'active'")
			end
		else
			debug.log("[WARNING] Argument 'cType' in call to function 'ui.setColor(cType,cState,color)' must be 'fg' or 'bg'")
		end
	else
		debug.log("[ERROR] Incorrect call to function 'ui.setColor(cType,cState,color)'")
	end
end

function ui.setStyle(style)
	if style and type(style) == "string" then
		if style == "fill" or style == "line" or style == "outline" then
			ui.var.style = style
		else
			debug.log("[WARNING] Argument 'style' in call to function 'ui.setStyle(style)' must be 'fill' 'line' or 'outline'")
		end
	else
		debug.log("[ERROR] Incorrect call to function 'ui.setStyle(style)'")
	end
end

function ui.setLineWidth(width)
	if width then
		ui.var.lineWidth = width
		love.graphics.setLineWidth(width)
	else
		debug.log("[ERROR] Incorrect call to function 'ui.setLineWidth(width)'")
	end
end

function ui.push()
	for key, val in pairs(ui.var) do
		if type(val) ~= "function" then
			local hold = string.find(key, "_hold_")
			if not hold then
				ui.var["_hold_"..key] = val
			end
		end
	end
end

function ui.pop()
	for key, val in pairs(ui.var) do
		if type(val) ~= "function" then
			local hold = string.find(key, "_hold_")
			if hold then
				ui.var[string.gsub(key, "_hold_", "")] = val
			end
		end
	end
end

function ui.button(x,y,w,h,text,style,btn)
	if x and y and w and h then
		if not btn then btn = "l" end
		if not style then style = ui.var.style end
		if not text then text = "" end

		local md, mo = love.mouse.isDown(btn), ui.mouseOver(x, y, w, h)
		local fw, fh = main.font:getWidth(text), main.font:getHeight(text)
		local lw = ui.var.lineWidth

		ui.updateColor("bg", md, mo)
		if style == "line" or style == "outline" then love.graphics.rectangle("line", x, y, w, h) end
		if style == "outline" then love.graphics.rectangle("fill", x+lw*1.5, y+lw*1.5, w-(lw*1.5)*2, h-(lw*1.5)*2) end
		if style == "fill" then love.graphics.rectangle("fill", x, y, w, h) end
		ui.updateColor("fg", md, mo)
		love.graphics.print(text, x+w/2-fw/2, y+h/2-fh/2)
		if mo and md then return true else return false end
	else
		debug.log("[ERROR] Incorrect call to function 'ui.button(x,y,w,h,text,style,btn)'")
		return nil
	end
end

return ui