local lazygit_status_ok, _ = pcall(require, "lazygit")
if not lazygit_status_ok then
    return
end

require('lazygit.utils').project_root_dir() -- Makes sure that any opened buffer which is contained in a git repo will be tracked
