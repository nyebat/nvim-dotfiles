    vim.cmd([[highlight Beacon guibg=white ctermbg=15]])
    vim.g.beacon_size = 18
    vim.g.beacon_show_jumps = 0
    vim.g.beacon_minimal_jump = 0

    vim.keymap.set('n', '<leader>.', '<cmd>BeaconToggle<cr>')
