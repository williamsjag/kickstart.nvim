-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- <Space>st to open small terminal at the bottom of window
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
end, { desc = '[S]mall [T]erminal beneath window' })

-- Automatically set cwd of tab to nearest .git directory when loading a buffer

local function find_git_dir(path)
  local git_path = path .. '/.git'
  if vim.fn.isdirectory(git_path) == 1 then
    return path
  end
  -- Move to the parent directory
  local parent = vim.fn.fnamemodify(path, ':h')
  if parent == path then
    -- Reached the root directory
    return nil
  else
    return find_git_dir(parent)
  end
end

local function set_cwd_to_git()
  -- Get the file path of the buffer with the mark
  local file_path = vim.fn.expand '%:p'
  if file_path == '' then
    return
  end
  -- Get the directory of the file
  local dir = vim.fn.fnamemodify(file_path, ':h')
  -- Find the nearest .git directory
  local git_dir = find_git_dir(dir)
  if git_dir then
    -- Set the working directory for the current tab
    vim.cmd('tcd ' .. git_dir)
  else
    vim.cmd('tcd ' .. dir)
  end
end

-- Set up an autocommand to trigger when jumping to a mark
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.line '\'"' ~= 0 then
      -- Only act if a mark is followed
      set_cwd_to_git()
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
