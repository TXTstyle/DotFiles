return {
    'nvim-lualine/lualine.nvim',
    dependencies = { { "nvim-tree/nvim-web-devicons", opt = true } },
    config = function()
        local flavour = require("catppuccin").flavour or vim.g.catppuccin_flavour or "macchiato"
        local colors = require('catppuccin.palettes').get_palette(flavour)

        local theme = require('catppuccin.utils.lualine')(flavour)

        theme.normal.c.bg = colors.base

        local empty = require('lualine.component'):extend()
        function empty:draw(default_highlight)
            self.status = ''
            self.applied_separator = ''
            self:apply_highlights(default_highlight)
            self:apply_section_separators()
            return self.status
        end

        local function getWords()
            if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
                return tostring(vim.fn.wordcount().visual_words) .. " words"
            end
                return tostring(vim.fn.wordcount().words) .. " words"
        end

        -- Put proper separators and gaps between components in sections
        local function process_sections(sections)
            for name, section in pairs(sections) do
                local left = name:sub(9, 10) < 'x'
                for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
                    table.insert(section, pos * 2, { empty, color = { fg = colors.base, bg = colors.base } })
                end
                for id, comp in ipairs(section) do
                    if type(comp) ~= 'table' then
                        comp = { comp }
                        section[id] = comp
                    end
                    comp.separator = left and { right = '' } or { left = '' }
                end
            end
            return sections
        end

        local function modified()
            if vim.bo.modified then
                return '+'
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                return '-'
            end
            return ''
        end

        require('lualine').setup {
            options = {
                theme = theme,
                component_separators = '',
                section_separators = { left = '', right = '' },
                extensions = { 'fugitive' },
                disabled_filetypes = { 'NvimTree' }
            },
            sections = process_sections {
                lualine_a = { 'mode' },
                lualine_b = {
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        source = { 'nvim' },
                        sections = { 'error' },
                        diagnostics_color = { error = { bg = colors.red, fg = colors.base } },
                    },
                    {
                        'diagnostics',
                        source = { 'nvim' },
                        sections = { 'warn' },
                        diagnostics_color = { warn = { bg = colors.orange, fg = colors.base } },
                    },
                    { modified, color = { bg = colors.red } },
                    {
                        '%w',
                        cond = function()
                            return vim.wo.previewwindow
                        end,
                    },
                    {
                        '%r',
                        cond = function()
                            return vim.bo.readonly
                        end,
                    },
                    {
                        '%q',
                        cond = function()
                            return vim.bo.buftype == 'quickfix'
                        end,
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    'filetype',
                    {
                        getWords,
                        cond = function()
                            local ftp = vim.bo.filetype
                            return ftp == "typst" or ftp == "latex"
                        end
                    },
                },
                lualine_z = { '%l:%c', '%p%%/%L' },
            },
            inactive_sections = {
                lualine_c = { '%f %y %m' },
                lualine_x = {},
            },
        }
    end
}
