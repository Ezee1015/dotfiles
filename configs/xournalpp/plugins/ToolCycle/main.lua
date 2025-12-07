local currentFill = false
local currentRotsnap = false
local currentGridsnap = false

local currentTool = 1        -- pen
local currentSelect = 1      -- rectangle
local currentDrawingtype = 1 -- default (freehand)
local currentLinestyle = 1   -- plain (continuous line)

local toolList = {"HAND", "PEN"} -- "HIGHLIGHTER", "ERASER"
local drawingtypeList = {"TOOL_DRAW_RECT", "TOOL_DRAW_COORDINATE_SYSTEM", "RULER", "TOOL_DRAW_ELLIPSE", "SHAPE_RECOGNIZER"} -- "TOOL_DEFAULT",
local selectList = {"RECT", "REGION"}
local linestyleList = {"PLAIN", "DASH"} -- , "DOT"
local lastClass = "select" -- last thing used: "tool" or "select"

function setDefaults()
  app.uiAction({["action"] = "ACTION_TOOL_" .. toolList[currentTool]})
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_" .. selectList[currentSelect]})
  app.uiAction({["action"] = "ACTION_" .. drawingtypeList[currentDrawingtype]})
  app.uiAction({["action"] = "ACTION_TOOL_LINE_STYLE_" .. linestyleList[currentLinestyle]})
end

function initUi()
  -- app.registerUi({["menu"] = "Grid snapping on/off",         ["callback"] = "gridsnap",    ["accelerator"] = "<Alt>a"});
  -- app.registerUi({["menu"] = "Rotation snapping on/off",     ["callback"] = "rotsnap",     ["accelerator"] = "<Alt>o"});
  app.registerUi({["menu"] = "Fill on/off",                  ["callback"] = "fill",        ["accelerator"] = "f"});
  app.registerUi({["menu"] = "Tools",                        ["callback"] = "tool",        ["accelerator"] = "q"});
  app.registerUi({["menu"] = "Solid/Dashed/Dotted",          ["callback"] = "linestyle",   ["accelerator"] = "e"});
  app.registerUi({["menu"] = "Line/Rectangle/Arrow/Ellipse", ["callback"] = "drawingtype", ["accelerator"] = "w"});
  app.registerUi({["menu"] = "Select Rectangle/Region",      ["callback"] = "select",      ["accelerator"] = "<Alt>2"});

  -- COLORS SHORTCUTS
  -- app.registerUi({["menu"] = "Color #1", ["callback"] = "color1", ["accelerator"] = "1"});
  -- app.registerUi({["menu"] = "Color #2", ["callback"] = "color2", ["accelerator"] = "2"});
  -- app.registerUi({["menu"] = "Color #3", ["callback"] = "color3", ["accelerator"] = "3"});
  -- app.registerUi({["menu"] = "Color #4", ["callback"] = "color4", ["accelerator"] = "4"});
  -- app.registerUi({["menu"] = "Color #5", ["callback"] = "color5", ["accelerator"] = "5"});
  -- app.registerUi({["menu"] = "Color #6", ["callback"] = "color6", ["accelerator"] = "6"});
  -- app.registerUi({["menu"] = "Color #7", ["callback"] = "color7", ["accelerator"] = "7"});
  -- app.registerUi({["menu"] = "Color #8", ["callback"] = "color8", ["accelerator"] = "8"});
  -- app.registerUi({["menu"] = "Color #9", ["callback"] = "color9", ["accelerator"] = "9"});
  -- app.registerUi({["menu"] = "Color #0", ["callback"] = "color0", ["accelerator"] = "0"});

  setDefaults()
end

function gridsnap()
  currentGridsnap = not currentGridsnap
  app.uiAction({["action"]="ACTION_GRID_SNAPPING"})
end
function rotsnap()
  currentRotsnap = not currentRotsnap
  app.uiAction({["action"]="ACTION_ROTATION_SNAPPING"})
end
function fill()
  currentFill = not currentFill
  app.uiAction({["action"]="ACTION_TOOL_FILL", ["enabled"] = currentFill})
end

function tool()
  if (lastClass == "tool") then
    currentTool = currentTool % #toolList + 1
  end
  app.uiAction({["action"] = "ACTION_TOOL_" .. toolList[currentTool]})
  lastClass = "tool"
end

-- COLORS SHORTCUTS
-- local colorList = {
--   {"white", 0xffffff},
--   {"gray", 0x808080},
--   {"lightblue", 0x00c0ff},
--   {"red", 0xff0000},
--   {"lightgreen", 0x00ff00},
--   {"orange", 0xff8000},
--   {"black", 0x000000},
--   {"green", 0x008000},
--   {"blue", 0x3333cc},
--   -- {"magenta", 0xff00ff},
--   {"yellow", 0xffff00},
-- }
--
-- function setColor(index)
--   app.changeToolColor({["color"] = colorList[index][2], ["selection"] = true})
-- end
-- function color1() setColor(1) end
-- function color2() setColor(2) end
-- function color3() setColor(3) end
-- function color4() setColor(4) end
-- function color5() setColor(5) end
-- function color6() setColor(6) end
-- function color7() setColor(7) end
-- function color8() setColor(8) end
-- function color9() setColor(9) end
-- function color0() setColor(10) end

function select()
  if (lastClass == "select") then
    currentSelect = currentSelect % #selectList + 1
  end
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_" .. selectList[currentSelect]})
  lastClass = "select"
end

function drawingtype()
  currentTool = 1
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
  if (lastClass == "tool") then
    currentDrawingtype = currentDrawingtype % #drawingtypeList + 1
  end
  app.uiAction({["action"] = "ACTION_" .. drawingtypeList[currentDrawingtype]})
  lastClass = "tool"
end

function linestyle()
  currentTool = 1
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
  if (lastClass == "tool") then
    currentLinestyle = currentLinestyle % #linestyleList + 1
  end
  app.uiAction({["action"] = "ACTION_TOOL_LINE_STYLE_" .. linestyleList[currentLinestyle]})
  lastClass = "tool"
end
