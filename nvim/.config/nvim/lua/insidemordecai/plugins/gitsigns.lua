-- import gitsigns plugins safely
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
    return
end

-- configure gitsigns
gitsigns.setup {}
