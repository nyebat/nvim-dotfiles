-- -- nvim/lua/user/cmp.lua
--
-- local cmp_status_ok, cmp = pcall(require, "cmp")
-- if not cmp_status_ok then
--     return
-- end
--
-- local luasnip = require('luasnip')
-- local select_opts = { behavior = cmp.SelectBehavior.Select }
--
-- require('luasnip.loaders.from_vscode').lazy_load()
--
-- cmp.setup({
--     snippet = {
--         expand = function(args)
--             luasnip.lsp_expand(args.body)
--         end
--     },
--     sources = {
--         { name = 'path' },
--         { name = 'nvim_lsp', keyword_length = 1 },
--         { name = 'buffer',   keyword_length = 3 },
--         { name = 'luasnip',  keyword_length = 2 },
--     },
--     window = {
--         documentation = cmp.config.window.bordered(),
--         completion = cmp.config.window.bordered()
--     },
--     formatting = {
--         fields = { 'menu', 'abbr', 'kind' },
--         format = function(entry, item)
--             local menu_icon = {
--                 nvim_lsp = 'λ',
--                 luasnip = '⋗',
--                 buffer = 'Ω',
--                 path = '🖫',
--             }
--
--             item.menu = menu_icon[entry.source.name]
--             return item
--         end,
--     },
--     mapping = {
--         ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
--         ['<Down>'] = cmp.mapping.select_next_item(select_opts),
--
--         ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
--         ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
--
--         ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-d>'] = cmp.mapping.scroll_docs(4),
--
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--         ['<CR>'] = cmp.mapping.confirm({ select = false }),
--
--         ['<C-f>'] = cmp.mapping(function(fallback)
--             if luasnip.jumpable(1) then
--                 luasnip.jump(1)
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--
--         ['<C-b>'] = cmp.mapping(function(fallback)
--             if luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--
--         ['<Tab>'] = cmp.mapping(function(fallback)
--             local col = vim.fn.col('.') - 1
--
--             if cmp.visible() then
--                 cmp.select_next_item()
--                 --cmp.select_next_item(select_opts)
--             elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--                 fallback()
--             else
--                 cmp.complete()
--             end
--         end, { 'i', 's' }),
--
--         ['<S-Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item(select_opts)
--                 --cmp.select_prev_item(select_opts)
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--     },
-- })

local cmp = require("cmp")

local luasnip = require("luasnip")

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()
local lspkind = require("lspkind")

cmp.setup({
    completion = {
        completeopt = "menu,menuone,preview,noselect",
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered()
    },
    -- sources for autocompletion
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" },  -- text within current buffer
        { name = "path" },    -- file system paths
    }),

    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = lspkind.cmp_format({
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, item)
                local menu_icon = {
                    nvim_lsp = 'λ ',
                    luasnip = '⋗ ',
                    buffer = 'Ω ',
                    path = '🖫 ',
                }

                item.menu = menu_icon[entry.source.name]
                return item
            end
        })
    },
})
