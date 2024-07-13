---@diagnostic disable: undefined-global
return {
    -- nvim-lsp
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre" },
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            -- completion
            { "hrsh7th/cmp-nvim-lsp" },
            -- linters
            { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
            -- mason
            {
                "neovim/nvim-lspconfig",
                config = function()
                    require("neodol.plugins.lsp.handlers").setup()
                end
            },
        },
        config = function()
            require("neodol.plugins.lsp.mason")
        end
    },

    {
        "simrat39/rust-tools.nvim",
        event = { "BufReadPre" },
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'mfussenegger/nvim-dap'
        },
        config = function()
            require("neodol.plugins.lsp.rust-tools")
        end
    },

    -- cmp
    {
        "hrsh7th/nvim-cmp",
        event = { "BufReadPre" },
        dependencies = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { "hrsh7th/cmp-nvim-lsp", },
            {
                'L3MON4D3/LuaSnip',
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp",
                lazy = true,
                dependencies = { 'VonHeikemen/the-good-snippets', },
            },
            { 'saadparwaiz1/cmp_luasnip', },
            { "rafamadriz/friendly-snippets" }, -- useful snippets
            { "onsails/lspkind.nvim" },         -- vs-code like pictograms
        },
        config = function()
            require("neodol.plugins.lsp.nvim-cmp")
        end
    },

    ---@diagnostic disable-next-line: undefined-global
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "VimEnter" },
        dependencies = {
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
        },
        config = function()
            pcall(vim.cmd, 'TSUpdate')
            require("neodol.plugins.lsp.treesitter")
        end,
        opts = { highlight = { enable = false } },
    },
}
