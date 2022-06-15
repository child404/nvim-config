local status_ok, ayu = pcall(require, "ayu")

if not status_ok then
    return
end

local opts = {
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {
        MatchParen = {bg = "#404755"},
        LspSignatureActiveParameter = {bg = "#404755"},
        LspReferenceRead = {bg = "#404755"},
        LspReferenceText = {bg = "#404755"},
        LspReferenceWrite = {bg = "#404756"},
        -- NormalNC = {bg = '#0f151e', fg = '#808080'},
    }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
}
ayu.setup(opts)
ayu.colorscheme()

