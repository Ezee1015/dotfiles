-- Script that allows you to insert a link in a markdown file with it's title
-- It gets the URL from the clipboard

local function getSelectionBounds()
  local lineFrom = vim.fn.getpos("v")[2]
  local lineTo = vim.fn.getpos(".")[2]
  local colFrom = vim.fn.getpos("v")[3]
  local colTo = vim.fn.getpos(".")[3]

  if lineFrom > lineTo then
    local aux = lineTo
    lineTo = lineFrom
    lineFrom = aux
  end

  if colFrom > colTo and lineFrom == lineTo then
    local aux = colTo
    colTo = colFrom
    colFrom = aux
  end

  return lineFrom, lineTo, colFrom, colTo
end

local function insertLink(url, title)
  local append = '[' .. title .. '](' .. url .. ')'
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local nline

  local from, to

  if vim.fn.mode() == "n" then
    local pos = cursor[2] + 1
    from = pos
    to = pos + 1

  elseif vim.fn.mode() == "v" then
    local lineFrom, lineTo, colFrom, colTo = getSelectionBounds()
    if lineFrom ~= lineTo then
      error("Multiple line visual selection not available")
      return false
    end

    from = colFrom - 1
    to = colTo + 1
  else
    error("Mode not accepted")
    return false
  end

  nline = line:sub(0, from) .. append  .. line:sub(to)
  local ok, err = pcall(vim.api.nvim_set_current_line, nline)
  if not ok then
    error(err .. "\n--> URL: " .. url .. "\n--> TITLE: " .. title)
  end

  -- Escape visual mode
  if vim.fn.mode() == "v" then
    local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'x', false)
  end
  vim.api.nvim_win_set_cursor(0, {cursor[1], from + append:len() - 1})
end

local function checkURL(url)
  if not url or not string.match(url, '^https?://[^ >,;]*') then
    return false
  end

  return true
end

local function getTitle(url)
  local cmd = "curl -Ls \"" .. url .. "\" | grep -oE \"<title>.*</title>\" | sed 's/<title>//' | sed 's/<\\/title>//' | head -1"
  return vim.fn.system(cmd):gsub("\n", "")
end

local function Marklink(url, origin)
  if not checkURL(url) then
    error(origin .. " text is not a link!\nCopied: " .. url)
    return false
  end

  local title = getTitle(url)
  if not insertLink(url, title) then return false end
  return true;
end

function MarklinkFromClipboard()
  local url = vim.fn.getreg("+"):gsub("\n", "");
  return Marklink(url, "Copied")
end

function MarklinkFromVisual()
  if vim.fn.mode() ~= "v" then
    error("Not in visual mode")
    return false
  end

  local lineFrom, lineTo, colFrom, colTo = getSelectionBounds()

  if lineFrom ~= lineTo then
    error("Multiple line visual selection not available")
    return false
  end

  local line = vim.api.nvim_get_current_line()
  local url = line:sub(colFrom, colTo)

  return Marklink(url, "Selected")
end

vim.api.nvim_create_user_command("MarklinkClipboard", MarklinkFromClipboard, {})
vim.api.nvim_create_user_command("MarklinkVisual", MarklinkFromVisual, {})

vim.keymap.set({"n", "v"}, "<leader>l", MarklinkFromClipboard);
vim.keymap.set("v", "<leader><S-l>", MarklinkFromVisual);
