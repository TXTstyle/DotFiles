return {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    priority = 90,
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { "simrat39/rust-tools.nvim" },
        { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        -- Snippet Collection (Optional)
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local kind_icons = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = ""
        }

        local lsp = require('lsp-zero')
        lsp.preset('recommended')
        lsp.nvim_workspace()

        lsp.ensure_installed({
            'volar',
            'rust_analyzer',
            'pylsp',
            'clangd',
            'lua_ls',
            'csharp_ls',
            'cssls',
            'bashls',
        })

        lsp.skip_server_setup({ 'rust_analyzer' })

        lsp.set_preferences({
            configure_diagnostics = true,
        })


        -- Fix Undefined global 'vim'
        lsp.configure('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local select_opts = { behavior = 'select' }

        lsp.setup_nvim_cmp({
            mapping = {
                -- confirm selection
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-y>'] = cmp.mapping.confirm({ select = false }),

                -- navigate items on the list
                ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                ['<Down>'] = cmp.mapping.select_next_item(select_opts),
                ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

                -- scroll up and down in the completion documentation
                ['<C-f>'] = cmp.mapping.scroll_docs(5),
                ['<C-u>'] = cmp.mapping.scroll_docs( -5),

                -- toggle completion
                ['<C-e>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                        fallback()
                    else
                        cmp.complete()
                    end
                end),
                -- ... Your other mappings ...

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable( -1) then
                        luasnip.jump( -1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- ... Your other mappings ...
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.menu = string.format('%s %s', ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name], vim_item.kind)
                    vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                    return vim_item
                end
            }
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local lspc = require('lspconfig')

        lspc.html.setup {
            capabilities = capabilities,
        }

        lsp.configure('rust_analyzer', {
            settings = {
                ['rust-analyzer'] = {
                    checkOnSave = {
                        allFeatures = true,
                        overrideCommand = {
                            'cargo', 'clippy', '--workspace', '--message-format=json',
                            '--all-targets', '--all-features'
                        }
                    },
                    tools = {
                        inlay_hints = {
                            auto = false
                        }
                    },
                    diagnostics = {
                        enable = true,
                        experimental = {
                            enable = true,
                        },
                    },
                }
            }
        })

        local attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            vim.keymap.set("n", "<Leader>td", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
            vim.keymap.set("n", "<Leader>r", function() vim.cmd('ClangdSwitchSourceHeader') end, opts)
            vim.keymap.set("n", "<A-f>", function() vim.lsp.buf.format() end, { buffer = bufnr })
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "<Leader>d", '<cmd>Telescope lsp_document_symbols<cr>', opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end

        lsp.on_attach(function(client, bufnr)
            attach(client, bufnr)
        end)

        local rust_lsp = lsp.build_options('rust_analyzer', {})
        lsp.setup()

        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            update_in_insert = true,
            underline = true,
            severity_sort = false,
            float = true,
        })

        lspc.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { 'html', 'vue', 'js', 'css', 'scss', 'sass' },
            root_dir = function()
                return vim.loop.cwd()
            end
        })

        lspc.volar.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                client.server_capabilities.document_formatting = true
                client.server_capabilities.document_range_formatting = true
                vim.bo.tabstop = 2
                vim.bo.shiftwidth = 2
                vim.bo.expandtab = true
                vim.bo.softtabstop = 2
                attach(client, bufnr)
            end,
            root_dir = function()
                return vim.loop.cwd()
            end
        })

        lspc.eslint.setup({
            capabilities = capabilities,
            root_dir = function()
                return vim.loop.cwd()
            end
        })

        require("rust-tools").setup({ server = rust_lsp })

        require("lsp_lines").setup()
    end
}
