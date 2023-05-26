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

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    use 'nvim-treesitter/nvim-treesitter'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    use 'L3MON4D3/LuaSnip'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'c',
        'cpp',
        'cmake',
        'python',
        'lua'
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true
    }
})

local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    widnow = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-h>'] = cmp.mapping.abort()
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' }
    })
})

require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'cmake',
        'jedi_language_server',
        'lua_ls'
    }
})

local on_attach = function(_, _)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')
lspconfig['clangd'].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
lspconfig['cmake'].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
lspconfig['jedi_language_server'].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
lspconfig['lua_ls'].setup({
    on_attach = on_attach,
    capabilities = capabilities,
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

vim.opt.breakindent = true
vim.opt.linebreak = true
