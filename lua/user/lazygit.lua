local lazygit_status_ok, lazygit = pcall(require, "lazygit")
if not lazygit_status_ok then
    return
end


require('telescope').load_extension('lazygit') -- Integration with telescope
require('lazygit.utils').project_root_dir() -- Makes sure that any opened buffer which is contained in a git repo will be tracked
