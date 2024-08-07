local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local dashboard = require("alpha.themes.dashboard")
local logo = {
    " ",
    "  ███╗  ██╗██████╗ █████╗ ██████╗  █████╗ ██╗ ",
    "  ████╗ ██║██╔═══╝██╔══██╗ ██╔═██╗██╔══██╗██║ ",
    "  ██╔██╗██║████╗  ██║  ██║ ██║ ██║██║  ██║██║ ",
    "  ██║╚████║██╔═╝  ██║  ██║ ██║ ██║██║  ██║██║ ",
    "  ██║ ╚███║██████╗╚█████╔╝██████╔╝╚█████╔╝██████╗ ",
    "  ╚═╝  ╚══╝╚═════╝ ╚════╝ ╚═════╝  ╚════╝ ╚═════╝ ",
    " ",
}
dashboard.section.header.val = logo --vim.split(logo, "\n")
dashboard.section.buttons.val = {
    dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("h", "󰈞 " .. " Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("g", "󰷊 " .. " Find text", ":Telescope live_grep <CR>"),
    dashboard.button("r", "󰙰 " .. " Load session", ":SessionRestore <CR>"),
    dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
    dashboard.button("l", "󰒲 " .. " Plugins", ":Lazy<CR>"),
    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.opts.layout[1].val = 3
vim.keymap.set('n', '<leader>fa', '<cmd>:Alpha<cr>', { desc = "Alpha" })

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
            require("lazy").show()
        end,
    })
end

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})

vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
