return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = false,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

        },
        config = function()
            local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }

            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            local select_opts = {}

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                sources = {
                    { name = 'nvim_lsp', priority = 1000 },
                    { name = 'nvim_lua', priority = 1000 },
                    { name = 'luasnip',  priority = 750 },
                    { name = 'buffer',   priority = 500 },
                    { name = 'path',     priority = 450 },
                },
                mapping = {
                    -- confirm selection
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    -- navigate items on the list
                    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
                    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

                    -- toggle completion
                    ['<C-k>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end),

                    -- snippets navigation
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        vim_item.menu = string.format('%s %s', ({
                            buffer = "[Buffer]",
                            path = "[Path]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name], vim_item.kind)
                        vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                        return vim_item
                    end
                },
                Snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                experimental = {
                    ghost_text = false,
                }
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
        },
        opts = {
            inlay_hint = { enable = true },
        },
        config = function()
            -- function to toggle "normal" diagnostics or lsp-lines diagnostics.
            local function toggle_diagnostics()
                local diagnostics_on = require("lsp_lines").toggle()
                if diagnostics_on then
                    vim.diagnostic.config({
                        virtual_text = false,
                    })
                else
                    vim.diagnostic.config({
                        virtual_text = {
                            enable = true,
                            spacing = 8,
                            prefix = "●",
                            severity = {
                                min = "ERROR",
                            }
                        },
                    })
                end
            end


            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')

            lsp_zero.extend_lspconfig()

            local attach = function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.lsp.inlay_hint.enable(true, nil)

                vim.keymap.set("n", "<Leader>td", toggle_diagnostics,
                    { desc = "Toggle lsp_lines", buffer = bufnr, remap = false })
                vim.keymap.set("n", "<A-f>", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "ƒ", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "<Leader>d", '<cmd>Telescope lsp_document_symbols<cr>', opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end,
                    { buffer = bufnr, remap = false, desc = "code_action" })
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
                    { buffer = bufnr, remap = false, desc = "rename" })
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end

            lsp_zero.on_attach(function(client, bufnr)
                attach(client, bufnr)
            end)

            local lspc = require('lspconfig')

            local capabilities = lsp_zero.get_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            require('flutter-tools').setup({
                lsp = {
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        vim.bo.tabstop = 2
                        vim.bo.shiftwidth = 2
                        vim.bo.expandtab = true
                        vim.bo.softtabstop = 2
                        attach(client, bufnr)
                    end,
                },
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'volar',
                    'rust_analyzer',
                    'pylsp',
                    'clangd',
                    'lua_ls',
                    'emmet_ls',
                    -- 'eslint',
                    'cssls',
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls({
                            settings = {
                                Lua = {
                                    hint = { enable = true }
                                }
                            }
                        })
                        lspc.lua_ls.setup(lua_opts)
                    end,
                    volar = function()
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
                            filetypes = { 'typescript', 'javascript', 'vue', 'json' },
                            init_options = {
                                vue = {
                                    hybridMode = false,
                                },
                            },
                            root_dir = function()
                                return vim.fn.getcwd();
                            end
                        })
                    end,
                    ts_ls = function()
                        local vue_language_server_path = require("mason-registry").get_package("vue-language-server")
                        :get_install_path() .. "/node_modules/@vue/language-server"
                        lspc.ts_ls.setup({
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
                            init_options = {
                                plugins = {
                                    {
                                        name = '@vue/typescript-plugin',
                                        location = vue_language_server_path,
                                        languages = { 'vue' },
                                    },
                                },
                            },
                            root_dir = function()
                                return vim.fn.getcwd();
                            end
                        })
                    end,
                    html = function()
                        lspc.html.setup({
                            capabilities = capabilities,
                        })
                    end,
                    emmet_ls = function()
                        lspc.emmet_ls.setup({
                            capabilities = capabilities,
                            filetypes = { 'html', 'vue', 'js', 'css', 'scss', 'sass' },
                            root_dir = function()
                                return vim.fn.getcwd();
                            end
                        })
                    end,
                    eslint = function()
                        lspc.eslint.setup({
                            root_dir = function()
                                return vim.fn.getcwd();
                            end
                        })
                    end,
                    rust_analyzer = function()
                        vim.g.rustacean = {
                            server = {
                                on_attach = function(_, _)
                                    local bufnr = vim.api.nvim_get_current_buf()
                                    attach(_, bufnr);
                                end
                            }
                        }
                    end,
                    clangd = function()
                        lspc.clangd.setup({
                            on_attach = function(c, b)
                                local opts = { buffer = b, remap = false, desc = "Switch Source Header" }
                                vim.keymap.set("n", "<Leader>r", function() vim.cmd('ClangdSwitchSourceHeader') end, opts)
                                attach(c, b)
                            end
                        })
                    end,
                    gopls = function()
                        lspc.gopls.setup({
                            on_attach = function(c, b)
                                attach(c, b)
                            end,
                            settings = {
                                gopls = {
                                    hints = {
                                        assignVariableTypes = true,
                                        compositeLiteralFields = true,
                                        compositeLiteralTypes = true,
                                        constantValues = true,
                                        functionTypeParameters = true,
                                        parameterNames = true,
                                        rangeVariableTypes = true,
                                    },
                                },
                            },
                            root_dir = function()
                                return vim.fn.getcwd()
                            end,
                        })
                    end,
                    pest_ls = function()
                        require("pest-vim").setup {}
                    end
                }
            })

            require("lsp_lines").setup()
        end
    }
}
