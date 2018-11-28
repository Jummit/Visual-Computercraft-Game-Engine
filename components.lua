local components = {}

local template = {
  args = {
    var1 = 1,
    var2 = "a",
    var3 = {}
  },

  render = function(self)
  end,
  update = function(self, event, var1, var2, var3)
  end,

  needs = {
    "foo"
  }
}

components.pos = {
  args = {
    x = 1,
    y = 1,
  },

  render = function(self)
  end,
  update = function(self, event, var1, var2, var3)
  end,

  needs = {}
}

components.sprite = {
  args = {
    texture = {
        "aaa",
        "bbb",
        "ccc"},
  },

  render = function(self)
    for y = 1, #self.texture do
      local line = self.texture[y]
      for x = 1, #line do
        local char = string.sub(line, x, x)
        if type(char) == "string" and #char == 1 then
          term.setCursorPos(x, y)
          term.blit(char, char, char)
        end
      end
    end
  end,
  update = function(self, event, var1, var2, var3)
  end,

  needs = {
    "pos"
  }
}

components.map = {
  args = {
  },

  render = function(self)
    paintutils.drawFilledBox(self.x, self.y, self.x + 10, self.y + 10, colors.gray)
    --paintutils.drawFilledBox(3, 3, 10, 10, colors.gray)
  end,
  update = function(self, event, var1, var2, var3)
  end,

  needs = {
    "pos"
  }
}

components.controllable = {
  args = {
    up = "w",
    down = "s",
    left = "a",
    right = "d"
  },

  render = function(self)
  end,
  update = function(self, event, var1, var2, var3)
  end,

  needs = {
    "pos"
  }
}

return components
