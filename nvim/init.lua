local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'Shatur/neovim-ayu'

    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'

    use 'nvim-treesitter/nvim-treesitter'

    use 'lervag/vimtex'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

vim.o.termguicolors = true
require('ayu').colorscheme()

require('lualine').setup({
    options = {
        theme = 'ayu',
        icons_enabled = false,
        component_separators = {
            left = '',
            right = ''
        },
        section_separators = {
            left = '',
            right = ''
        },
        disabled_filetypes = {
            'packer',
            'NvimTree'
        }
    }
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({
    renderer = {
        icons = {
            show = {
                git = false,
                file = false,
                folder = false,
                folder_arrow = true
            },
            glyphs = {
                folder = {
                    arrow_closed = '+',
                    arrow_open = '-'
                }
            }
        }
    }
})
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>')

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'c',
        'cpp',
        'python',
        'lua',
        'vim'
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true
    }
})

vim.opt.encoding = 'utf-8'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.numberwidth = 6
vim.opt.signcolumn = 'number'
