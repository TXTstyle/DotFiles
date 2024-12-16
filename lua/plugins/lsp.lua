return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
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

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
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

            local capabilities = require('blink.cmp').get_lsp_capabilities()

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
                            init_options = {
                                vue = {
                                    hybridMode = false,
                                },
                            },
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
                            settings = {
                                typescript = {
                                    inlayHints = {
                                        enumMemberValues = {
                                            enabled = true,
                                        },
                                        functionLikeReturnTypes = {
                                            enabled = true,
                                        },
                                        propertyDeclarationTypes = {
                                            enabled = true,
                                        },
                                        parameterTypes = {
                                            enabled = true,
                                            suppressWhenArgumentMatchesName = true,
                                        },
                                        variableTypes = {
                                            enabled = true,
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    ts_ls = function()
                        local vue_language_server_path = require("mason-registry").get_package("vue-language-server")
                            :get_install_path() .. "/node_modules/@vue/language-server"
                        lspc.ts_ls.setup({
                            init_options = {
                                plugins = {
                                    {
                                        name = '@vue/typescript-plugin',
                                        location = vue_language_server_path,
                                        languages = { 'vue' },
                                    },
                                },
                            },
                            capabilities = capabilities,
                            settings = {
                                typescript = {
                                    tsserver = {
                                        useSyntaxServer = false,
                                    },
                                    inlayHints = {
                                        includeInlayParameterNameHints = 'all',
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                            },
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
                            end,
                            capabilities = capabilities,
                        })
                    end,
                    rust_analyzer = function()
                        vim.g.rustacean = {
                            server = {
                                capabilities = capabilities,
                                on_attach = function(_, bufnr)
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
                            end,
                            capabilities = capabilities,
                        })
                    end,
                    gopls = function()
                        lspc.gopls.setup({
                            on_attach = function(c, b)
                                attach(c, b)
                            end,
                            capabilities = capabilities,
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
