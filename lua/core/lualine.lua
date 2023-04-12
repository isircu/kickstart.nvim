 -- Mode already shown by lualine, so disable default
--vim.opt.showmode = false

local current_treesitter_context = function()
  local f = require('nvim-treesitter').statusline({
    indicator_size = 300,
    type_patterns = {"class", "function", "method", "interface", "type_spec", "table", "if_statement", "for_statement", "for_in_statement"},
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  if context == "vim.NIL" then
    return " "
  end
  return " " .. context
end


local navic = require('nvim-navic')

local get_location = function()
  local location = nil
  if navic.is_available() then
    location = navic.get_location()
  else
     return 'something went wrong'
  end
  return location
end

require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {'filename'},
      -- {
      --   current_treesitter_context,
      --   color = { fg = "#03a1fc"},
      -- },

      {
        get_location,
        --navic.get_location,
        --cond = navic.is_available,
        color = { fg = "#03a1fc" },
      }

    },
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'},
}
