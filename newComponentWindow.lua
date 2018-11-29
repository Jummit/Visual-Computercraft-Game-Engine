local utils = require "utils"
local newButton = require "button"
local components = require "components"
local newList = require "list"

local sw, sh = term.getSize()
local w = sw - 30
local h = sh - 5
local x = 22
local y = 4
local newComponentWindow

local closeButton = newButton{
  x = x + w - 1, y = y,
  w = 1, h = 1,
  label = "x",
  color = colors.red, clickedColor = colors.orange, labelColor = colors.white,
  onClick = function()
    newComponentWindow.visible = false
  end}

local function createComponent(type)
  local newComponent = utils.copyTable(components[type])
  newComponent.type = type
  newComponent.render = nil
  newComponent.update = nil
  return newComponent
end

local componentList = newList({
    x = x + 3, y = y + 2,
    w = w - 6, h = h - 3,
    items = {},
    getLabel = function(item)
      return item
    end,
    onDoubleClick = function(item)
      local c = components[item]

      for _, need in ipairs(c.needs) do
        local needExists = false
        for _, component in ipairs(componentList.items) do
          if need == component.type then
            needExists = true
          end
        end
        if not needExists then
          componentList:add(createComponent(need))
        end
      end

      componentList:add(createComponent(item))

      newComponentWindow.visible = false
    end})

for k, v in pairs(components) do
  table.insert(componentList.items, k)
end

newComponentWindow = {
  visible = false,
  render = function(self)
    utils.renderBox(x, y, w, h, colors.lightGray)
    utils.renderLine(x, y, w, 1, colors.gray)
    term.setCursorPos(x, y)
    term.write("Choose a component")
    componentList:render()
    closeButton:render()
  end,
  update = function(self, event, var1, var2, var3)
    closeButton:update(event, var1, var2, var3)
    componentList:update(event, var1, var2, var3)
  end
}

return newComponentWindow