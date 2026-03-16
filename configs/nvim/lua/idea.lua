
local function getEmbededImage(filePath)
    if filePath == nil then
        return false, ""
    end

    filePath = vim.fn.expand(filePath)

    if not FileExists(filePath) then
        error("File `" .. filePath .. "`does not exists!")
    end

    local command = "convert '" .. filePath .. "' -strip PNG:- | base64 | tr -d '\n'"
    local result = vim.fn.system(command):gsub("\n", "")

    if vim.v.shell_error ~= 0 then
        error("Command `" .. command .. "` failed with exit code " .. vim.v.shell_error)
    end

    return true, result
end

local function insertEmbeddedImage(line, pos, filePath)
  local ok, embededImg = getEmbededImage(filePath)
  if not ok then
      error("Unable to get the embedded image")
  end

  local insert = '<img src="data:image/png;base64,' .. embededImg .. '">'
  local nline = line:sub(0, pos) .. insert  .. line:sub(pos+1)
  local ok, err = pcall(vim.api.nvim_set_current_line, nline)
  if not ok then
    error(err)
  end
end

local function searchBackwards(text, startPos, char)
  while startPos >= 0 and text:sub(startPos,startPos) ~= char do
      startPos = startPos - 1
  end

  return (startPos ~= -1) and true or false, startPos
end

local function searchForward(text, startPos, char)
  while startPos < string.len(text) and text:sub(startPos,startPos) ~= char do
      startPos = startPos + 1
  end

  return (startPos == string.len(text)) and false or true, startPos
end

local function convertImageIntoEmbedded()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  local ok, startPos = searchBackwards(line, cursor[2], '!')
  if not ok then
      error("Unable to find the start of the image")
  end

  local ok, endPos = searchForward(line, cursor[2], ')')
  if not ok then
      error("Unable to find the end of the image")
  end

  local ok, startPathPos = searchBackwards(line, endPos, '(')
  if not ok then
      error("Unable to find the start of the image path")
  end

  local filePath = line:sub(startPathPos+1, endPos-1)
  line = line:sub(0, startPos-1) .. line:sub(endPos+1)

  insertEmbeddedImage(line, startPos-1, filePath)
end

local function pasteEmbeddedImage()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local filePath = vim.fn.getreg("+"):gsub("\n", "");

  insertEmbeddedImage(line, cursor[2], filePath)
end

vim.api.nvim_create_user_command("IdeaConvertImageIntoEmbedded", convertImageIntoEmbedded, {})
vim.keymap.set("n" , "<leader>ic", convertImageIntoEmbedded);

vim.api.nvim_create_user_command("IdeaPasteEmbeddedImage", pasteEmbeddedImage, {})
vim.keymap.set("n" , "<leader>ip", pasteEmbeddedImage);
