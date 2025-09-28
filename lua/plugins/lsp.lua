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
        },
        opts = {
            inlay_hint = { enable = true },
            servers = {
                clangd = {
                    mason = function()
                        if not jit.os == "OSX" then
                            return false
                        end
                    end,
                },
            }
        },
        config = function()
            vim.g.diagnostics_on = false
            local notify = require('notify')
            -- function to toggle "normal" diagnostics or lsp-lines diagnostics.
            local function toggle_diagnostics()
                vim.g.diagnostics_on = not vim.g.diagnostics_on
                if vim.g.diagnostics_on then
                    vim.diagnostic.config({
                        virtual_lines = {
                            severity = {
                                min = "ERROR",
                            }
                        },

                    })
                    notify("Warnings disabled")
                else
                    vim.diagnostic.config({
                        virtual_lines = {
                            severity = {
                                min = "HINT",
                            }
                        },
                    })
                    notify("Warnings enabled")
                end
            end


            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')

            local attach = function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.lsp.inlay_hint.enable(true, nil)

                vim.keymap.set("n", "<Leader>tw", toggle_diagnostics,
                    { desc = "Toggle Warnings", buffer = bufnr, remap = false })
                vim.keymap.set("n", "<A-f>", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "ƒ", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "<Leader>d", '<cmd>Telescope lsp_document_symbols<cr>', opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end,
                    { buffer = bufnr, remap = false, desc = "code_action" })
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
                    { buffer = bufnr, remap = false, desc = "rename" })
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            lsp_zero.extend_lspconfig({
                lsp_attach = attach,
                capabilities = capabilities,
            })

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

            local clangd_cmd = function()
                local cmd = {
                    'clangd',
                    '--background-index',
                    "--clang-tidy",
                    "--completion-style=detailed",
                }
                if jit.os == "OSX" then
                    return cmd
                else
                    table.insert(cmd, '--query-driver=/usr/bin/*gcc')
                    return cmd
                end
            end

            local vanilla_clangd = {
                cmd = clangd_cmd(),
                inlayHints = {
                    functionReturnTypes = true,
                    variableTypes = true,
                    parameterNames = true,
                },
                on_attach = function(c, b)
                    local clangd = require('lspconfig.configs.clangd').commands.ClangdSwitchSourceHeader[1];
                    local opts = { buffer = b, remap = false, desc = "Switch Source Header" }
                    vim.keymap.set("n", "<Leader>r", clangd, opts)
                    attach(c, b)
                end,
                capabilities = capabilities,
            }

            local cwd = vim.fn.getcwd()
            if not string.find(cwd, "esp") then
                vim.lsp.config('clangd', vanilla_clangd)
            end
            vim.lsp.enable('clangd')

            vim.lsp.config('pylsp', {
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
            })

            vim.lsp.config('rust_analyzer', {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    client.cancel_request = function(_, _)
                    end
                    attach(client, bufnr);
                end,
                settings = {
                    ['rust-analyzer'] = {
                        check = {
                            command = 'clippy',
                            extraArgs = { '--no-deps' },
                        },
                        checkOnSave = true,
                        inlayHints = {
                            bindingModeHints = {
                                enable = true,
                            },
                            closureReturnTypeHints = {
                                enable = true,
                            },
                            lifetimeElisionHints = {
                                enable = 'always',
                            },
                            typeHints = {
                                enable = true,
                            },
                        },
                    },
                },
            })
            local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
                '/vue-language-server' .. '/node_modules/@vue/language-server'
            local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
            local vue_plugin = {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
                configNamespace = 'typescript',
            }
            local vtsls_config = {
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                vue_plugin,
                            },
                        },
                    },
                },
                filetypes = tsserver_filetypes,
            }

            local ts_ls_config = {
                init_options = {
                    plugins = {
                        vue_plugin,
                    },
                },
                filetypes = tsserver_filetypes,
            }

            -- If you are on most recent `nvim-lspconfig`
            local vue_ls_config = {}
            vim.lsp.config('vtsls', vtsls_config)
            vim.lsp.config('vue_ls', vue_ls_config)
            vim.lsp.config('ts_ls', ts_ls_config)
            vim.lsp.config('vtsls', vtsls_config)
            vim.lsp.enable({ 'vtsls', 'vue_ls' }) -- If using `ts_ls` replace `vtsls` to `ts_ls`

            vim.lsp.config('html', {
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
            })

            vim.lsp.config('emmet_ls', {
                capabilities = capabilities,
                filetypes = { 'html', 'js', 'css', 'scss', 'sass' },
                root_dir = function()
                    return vim.fn.getcwd();
                end,
                on_attach = attach,
            })

            vim.lsp.config('eslint', {
                root_dir = function()
                    return vim.fn.getcwd();
                end,
                capabilities = capabilities,
                on_attach = attach,
            })

            vim.lsp.config('gopls', {
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

            vim.lsp.config('glsl_analyzer', {
                capabilities = capabilities,
                on_attach = function(client, buffer)
                    client.cancel_request = function(_, _)
                    end
                    attach(client, buffer);
                end,

            })

            vim.lsp.config('qmlls', {
                capabilities = capabilities,
                cmd = { 'qmlls6', '-E' },
            })
            vim.lsp.enable('qmlls')

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'tinymist',
                },
                automatic_enable = true,
                automatic_installation = true,
            })
        end
    }
}
