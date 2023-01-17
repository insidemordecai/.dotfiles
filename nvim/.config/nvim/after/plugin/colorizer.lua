-- import colorizer plugin safely
local status, colorizer = pcall(require, "colorizer")
if (not status) then return end

-- configure colorizer
colorizer.setup({
  '*';
})
