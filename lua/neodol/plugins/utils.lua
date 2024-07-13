return {
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                auto_restore_enable = false,
                auto_session_suppress_dirs = { "~/" },
                -- auto_session_suppress_dirs = nil,
            })
        end,
    },
    -- nvimtree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { { '<leader>e', '<cmd>NvimTreeToggle<cr>' }, },
        config = function()
            require("neodol.config.utils.nvimtree")
        end
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        event = "BufReadPre",
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' }
        },
        config = function()
            require("neodol.config.utils.bufferline")
        end

    },
    --
    -- nvim surround
    {
        --[[  Old text                    Command         New text
        --------------------------------------------------------------------------------
        surr*ound_words             ysiw)           (surround_words)
        *make strings               ys$"            "make strings"
        [delete ar*ound me!]        ds]             delete around me!
        remove <b>HTML t*ags</b>    dst             remove HTML tags
        'change quot*es'            cs'"            "change quotes"
        <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
        delete(functi*on calls)     dsf             function calls
        --]]
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "InsertEnter",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- auto pairs
    {
        "jiangmiao/auto-pairs", event = "InsertEnter"
    },

    -- comment / uncomment
    {
        -- <gcc> comment single line
        -- <gbc> comment multyline
        'numToStr/Comment.nvim',
        event = "InsertEnter",
        config = function()
            require('Comment').setup()
        end
    },

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            require("neodol.config.utils.telescope")
        end

    },

    -- toggleterm
    {
        "akinsho/toggleterm.nvim",
        branch = "main",
        config = function()
            require("neodol.config.utils.toggleterm")
        end
    },

    -- which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
}
