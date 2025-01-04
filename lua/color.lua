local themes = { 'tokyonight', 'ashen', 'citruszest', 'kanagawa', 'onedark', 'rose-pine', 'tundra' }
-- Function to set a random theme
local function set_random_theme()
  math.randomseed(os.time()) -- Seed the random number generator
  local random_theme = themes[math.random(#themes)]
  vim.cmd('colorscheme ' .. random_theme)
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  print('Colorscheme set to: ' .. random_theme)
end

-- Set a random theme
vim.keymap.set('n', '<leader>cr', set_random_theme, { desc = 'Set random theme' })

-- Define keymaps for installed plugins
local function get_theme_files()
  local themes_dir = vim.fn.stdpath 'config' .. '/lua/custom/plugins/themes' -- Path to your themes folder
  local theme_files = {}

  -- Use vim.uv to read the directory
  local handle, err = vim.uv.fs_scandir(themes_dir)
  if not handle then
    vim.notify('Error reading directory: ' .. err, vim.log.levels.ERROR)
    return theme_files
  end

  -- Iterate through the directory contents
  while true do
    local name, file_type = vim.uv.fs_scandir_next(handle) -- Retrieve the filename and file type
    if not name then
      break
    end

    if file_type == 'file' and name:match '%.lua$' then
      local theme_name = name:gsub('%.lua$', '') -- Remove the `.lua` suffix
      if type(theme_name) == 'string' then
        table.insert(theme_files, theme_name) -- Insert valid string theme name
      else
        vim.notify('Invalid theme name: ' .. tostring(theme_name), vim.log.levels.WARN)
      end
    end
  end

  return theme_files
end

-- Function to create keybinds dynamically
local function setup_theme_keybinds()
  local themes = get_theme_files()

  if #themes == 0 then
    vim.notify('No themes found in the directory!', vim.log.levels.ERROR)
    return
  end

  for index, theme in ipairs(themes) do
    local key = '<leader>c' .. index
    vim.keymap.set('n', key, function()
      local success, err = pcall(function()
        vim.cmd('colorscheme ' .. theme)
      end)
      if success then
        print('Colorscheme set to: ' .. theme)
      else
        vim.notify('Failed to set colorscheme: ' .. theme .. '\nError: ' .. err, vim.log.levels.ERROR)
      end
    end, { desc = 'Set theme to ' .. theme })
  end
end

-- Call the function to create the keybinds
setup_theme_keybinds()

-- Return random theme for access elsewhere
return {
  set_random_theme = set_random_theme,
}
