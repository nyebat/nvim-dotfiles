-- [[ LAZY PLUGINS ]]

local lazy = {}

function lazy.install(path)
    if not vim.loop.fs_stat(path) then
        print('Installing lazy.nvim....')
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            path,
        })
        print('Done.')
    end
end

lazy.opts = {
    ui = {
        border = 'rounded',
    },
    install = {
        missing = true,                        -- install missing plugins on startup.
        colorscheme = { "dracula", "habamax" } -- use this theme during first install process
    },
    change_detection = {
        enabled = false, -- check for config file changes
        notify = false,  -- get a notification when changes are found
    },
    checker = {
        -- automatically check for plugin updates
        enabled = false,
        -- concurrency = nil, ---@type number? set to 1 to check fo
        notify = true, -- get a notification when new updates ar
        -- frequency = 3600,     -- check for updates every hour
        -- check_pinned = false, -- check for pinned packages that
    },
}

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

function lazy.setup(plugins)
    -- You can "comment out" the line below after lazy.nvim is installed
    lazy.install(lazy.path)

    vim.opt.rtp:prepend(lazy.path)
    require('lazy').setup(plugins, lazy.opts)
end

lazy.setup({
    -- Load them from the lua/config folder
    { import = "neodol.plugins" },
})
