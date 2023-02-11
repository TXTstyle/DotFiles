return {
    'nvim-lualine/lualine.nvim',
    dependencies = {{ 'kyazdani42/nvim-web-devicons', opt = true }, 'navarasu/onedark.nvim'},
    config = function()
        local c = require('onedark.colors')
        local cfg = vim.g.onedark_config
        local colors = {
            bg = c.bg0,
            fg = c.fg,
            red = c.red,
            green = c.green,
            yellow = c.yellow,
            blue = c.blue,
            purple = c.purple,
            cyan = c.cyan,
            gray = c.grey
        }

        local one_dark = {
            inactive = {
                a = { fg = colors.gray, bg = colors.bg, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.bg },
                c = { fg = colors.gray, bg = cfg.lualine.transparent and c.none or c.bg1 },
            },
            normal = {
                a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
                b = { fg = colors.fg, bg = c.bg3 },
                c = { fg = colors.fg, bg = cfg.lualine.transparent and c.none or c.bg1 },
            },
            visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
            replace = { a = { fg = colors.bg, bg = colors.red, gui = 'bold' } },
            insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
            command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
            terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
        }

        local empty = require('lualine.component'):extend()
        function empty:draw(default_highlight)
            self.status = ''
            self.applied_separator = ''
            self:apply_highlights(default_highlight)
            self:apply_section_separators()
            return self.status
        end

        -- Put proper separators and gaps between components in sections
        local function process_sections(sections)
            for name, section in pairs(sections) do
                local left = name:sub(9, 10) < 'x'
                for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
                    table.insert(section, pos * 2, { empty, color = { fg = colors.bg, bg = colors.bg } })
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

        local function search_result()
            if vim.v.hlsearch == 0 then
                return ''
            end
            local last_search = vim.fn.getreg('/')
            if not last_search or last_search == '' then
                return ''
            end
            local searchcount = vim.fn.searchcount { maxcount = 9999 }
            return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
        end

        local function modified()
            if vim.bo.modified then
                return '+'
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                return '-'
            end
            return ''
        end

        local gps = require("nvim-gps")
        gps.setup({
            depth = 2,
            separator = ' / '
        })


        require('lualine').setup {
            options = {
                theme = one_dark,
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
                        diagnostics_color = { error = { bg = colors.red, fg = colors.bg } },
                    },
                    {
                        'diagnostics',
                        source = { 'nvim' },
                        sections = { 'warn' },
                        diagnostics_color = { warn = { bg = colors.orange, fg = colors.bg } },
                    },
                    { 'filename', file_status = false,        path = 1 },
                    { modified,   color = { bg = colors.red } },
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
                lualine_x = {
                    { gps.get_location, cond = gps.is_available },
                },
                lualine_y = { search_result, 'filetype' },
                lualine_z = { '%l:%c', '%p%%/%L' },
            },
            inactive_sections = {
                lualine_c = { '%f %y %m' },
                lualine_x = {},
            },
        }
    end
}
