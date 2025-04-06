-- Script that allows you to insert a link in a markdown file with it's title
-- It gets the URL from the clipboard

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
    local colFrom = vim.fn.getpos("v")[3]
    local colTo = vim.fn.getpos(".")[3]
    local lineFrom = vim.fn.getpos("v")[2]
    local lineTo = vim.fn.getpos(".")[2]

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
  local cmd = "curl -Ls \"" .. url .. "\" | grep -oE \"<title>.*</title>\" | sed 's/<title>//' | sed 's/<\\/title>//'"
  return vim.fn.system(cmd):gsub("\n", "")
end

function MarklinkFromClipboard()
  local url = vim.fn.getreg("+"):gsub("\n", "");

  if checkURL(url) then
    local title = getTitle(url)
    if not insertLink(url, title) then return false end
    return true;
  end

  error("Copied text is not a link!\nCopied: " .. url)
  return false
end

vim.api.nvim_create_user_command("MarklinkClipboard", MarklinkFromClipboard, {})
vim.keymap.set({"n", "v"}, "<leader>l", MarklinkFromClipboard);
