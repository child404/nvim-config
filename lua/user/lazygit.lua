local lazygit_status_ok, lazygit = pcall(require, "lazygit")
if not lazygit_status_ok then
    return
end

require("telescope").load_extension("lazygit")
require('lazygit.utils').project_root_dir()
