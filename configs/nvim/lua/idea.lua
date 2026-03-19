local function getEmbededImage(filePath)
    if filePath == nil then
        return false, ""
    end

    filePath = vim.fn.expand(filePath)

    if not FileExists(filePath) then
        error("File `" .. filePath .. "` does not exists!")
    end

    local command = "convert '" .. filePath .. "' -strip PNG:- | base64 | tr -d '\n'"
    local result = vim.fn.system(command):gsub("\n", "")

    if vim.v.shell_error ~= 0 then
        error("Command `" .. command .. "` failed with exit code " .. vim.v.shell_error)
    end

    return true, result
end

local function insertEmbeddedImage(line, pos, embeddedImage)
  local insert = '<img src="data:image/png;base64,' .. embeddedImage .. '">'
  local nline = line:sub(0, pos) .. insert  .. line:sub(pos+1)
  local ok, err = pcall(vim.api.nvim_set_current_line, nline)
  if not ok then
    error(err)
  end
end

local function searchCharBackwards(text, startPos, char)
  while startPos >= 0 and text:sub(startPos,startPos) ~= char do
      startPos = startPos - 1
  end

  return (startPos ~= -1) and true or false, startPos
end

local function searchCharForwards(text, startPos, char)
  while startPos < string.len(text) and text:sub(startPos,startPos) ~= char do
      startPos = startPos + 1
  end

  return (startPos == string.len(text)) and false or true, startPos
end

local function convertImageIntoEmbedded()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  local ok, startPos = searchCharBackwards(line, cursor[2], '!')
  if not ok then
      error("Unable to find the start of the image")
  end

  local ok, endPos = searchCharForwards(line, cursor[2], ')')
  if not ok then
      error("Unable to find the end of the image")
  end

  local ok, startPathPos = searchCharBackwards(line, endPos, '(')
  if not ok then
      error("Unable to find the start of the image path")
  end

  local filePath = line:sub(startPathPos+1, endPos-1)
  line = line:sub(0, startPos-1) .. line:sub(endPos+1)

  local ok, embeddedImage = getEmbededImage(filePath)
  if not ok then
      error("Unable to get the embedded image")
  end

  insertEmbeddedImage(line, startPos-1, embeddedImage)
end

local function pasteEmbeddedImageFromClipboardPath()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local filePath = vim.fn.getreg("+"):gsub("\n", "");

  local ok, embeddedImage = getEmbededImage(filePath)
  if not ok then
      error("Unable to get the embedded image")
  end

  insertEmbeddedImage(line, cursor[2], embeddedImage)
end

local function pasteEmbeddedImageFromClipboardImage()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  local getImageFromClipboardCmd = "xclip -o -sel clipboard" -- X11
  local command = getImageFromClipboardCmd .. " | convert -strip PNG:- - | base64 | tr -d '\n'"
  local result = vim.fn.system(command):gsub("\n", "")

  if vim.v.shell_error ~= 0 then
      error("Command `" .. command .. "` failed with exit code " .. vim.v.shell_error)
  end

  insertEmbeddedImage(line, cursor[2], result)
  return true, result
end

-------------------------
-- MAPS
-------------------------

-- For notes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "html" },
  callback = function(event)
    vim.api.nvim_buf_create_user_command(event.buf, "IdeaConvertImageIntoEmbedded", convertImageIntoEmbedded, {})
    vim.keymap.set("n" , "<leader>ic", convertImageIntoEmbedded, { buffer = event.buf });

    vim.api.nvim_buf_create_user_command(event.buf, "IdeaPasteEmbeddedImageFromClipboardPath", pasteEmbeddedImageFromClipboardPath, {})
    vim.keymap.set("n" , "<leader>ip", pasteEmbeddedImageFromClipboardPath, { buffer = event.buf });

    vim.api.nvim_buf_create_user_command(event.buf, "IdeaPasteEmbeddedImageFromClipboardImage", pasteEmbeddedImageFromClipboardImage, {})
    vim.keymap.set("n" , "<leader>ii", pasteEmbeddedImageFromClipboardImage, { buffer = event.buf });
  end,
})
