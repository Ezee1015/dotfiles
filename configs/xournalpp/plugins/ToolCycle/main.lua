local currentFill = false
local currentRotsnap = false
local currentGridsnap = false

local currentTool = 1        -- pen
local currentSelect = 1      -- rectangle
local currentDrawingtype = 1 -- default (freehand)
local currentLinestyle = 1   -- plain (continuous line)

local toolList = {"HAND", "PEN"} -- "HIGHLIGHTER", "ERASER"
local drawingtypeList = {"TOOL_DRAW_RECT", "RULER", "TOOL_DRAW_ELLIPSE", "SHAPE_RECOGNIZER"} -- "TOOL_DEFAULT",
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
