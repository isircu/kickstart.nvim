local cmd = vim.cmd

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = 'Clean trailing whitespace on save',
    pattern = {"*"},
    callback = function()
		local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
    end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
 -- au FileType gitcommit let b:EditorConfig_disable = 1

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit" },
    callback = function()
        vim.b.EditorConfig_disable = 1
    end,
})
