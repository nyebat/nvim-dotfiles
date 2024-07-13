return {
    -- alpha
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            require("neodol.config.ui.alpha")
        end
    },
    -- beacon
    {
        'DanilaMihailov/beacon.nvim',
        event = "BufReadPre",
        config = function()
            require("neodol.config.ui.beacon")
        end
    },

    -- noice
    {

        "folke/noice.nvim",
        event        = "BufReadPre",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback

            {
                "rcarriga/nvim-notify",
                keys = {
                    {
                        "<leader>un",
                        function()
                            require("notify").dismiss({ silent = true, pending = true })
                        end,
                        desc = "Dismiss all Notifications",
                    },
                },
                opts = {
                    background_colour = "#000000",
                    timeout = 1500,
                    max_height = function()
                        return math.floor(vim.o.lines * 0.75)
                    end,
                    max_width = function()
                        return math.floor(vim.o.columns * 0.75)
                    end,
                },
                init = function()
                    -- when noice is not enabled, install notify on VeryLazy
                    vim.notify = require("notify")
                end,
            }
        },
        config       = function()
            require("neodol.config.ui.noice")
        end
    },

    -- barbecue
    {
        "utilyre/barbecue.nvim",
        event = "InsertEnter",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            require("neodol.config.ui.barbecue")
        end
    },

    -- imdent_blankline
    {
        -- 'lukas-reineke/indent-blankline.nvim',
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        opts = {},
        dependencies = {
            "echasnovski/mini.indentscope",
            version = false, -- wait till new 0.7.0 release to put it back on semver
        },
        config = function()
            require("neodol.config.ui.indent_blankline")
        end
    },

    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("neodol.config.ui.lualine")
        end
    },

    -- color palet
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end
    },

    -- colorscheme
    {
        -- add dracula
        "Mofiqul/dracula.nvim",
        priority = 1000,
        -- customize dracula color palette
        -- Configure LazyVim to load dracula
        config = function()
            require("neodol.config.ui.colorscheme")
        end
    },
}
