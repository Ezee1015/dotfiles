-- Function to verify a folder exists
function IsDir(file)
  local isok, errstr, errcode = os.rename(file, file)

  if isok == nil then
     if errcode == 13 then
        -- Permission denied, but it exists
        return true
     end
     return false
  end
  return true
end
-- Taken from: <https://stackoverflow.com/a/4991602>
function FileExists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

vim.o.termguicolors = true

-- lua/basic.lua
require("basic")
-- lua/maps.lua
require("maps")
-- lua/compile.lua
require("compile")
-- lua/lazy_init.lua
require("lazy_init")
-- lua/floaterm.lua
require("floaterm")
-- lua/marklink.lua
require("marklink")
-- lua/idea.lua
require("idea")
-- lua/numbertoggle.lua
require("numbertoggle")
