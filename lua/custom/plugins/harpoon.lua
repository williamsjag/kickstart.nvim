return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      -- REQUIRED
      local harpoon = require 'harpoon'
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = '[A]dd to harpoon list' })

      vim.keymap.set('n', '<leader>hr', function()
        harpoon:list():remove()
      end, { desc = '[R]emove from harpoon list' })
      vim.keymap.set('n', '<leader>ho', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[O]pen harpoon list' })

      vim.keymap.set('n', '<leader>h1', function()
        harpoon:list():select(1)
      end, { desc = 'Open [1]' })
      vim.keymap.set('n', '<leader>h2', function()
        harpoon:list():select(2)
      end, { desc = 'Open [2]' })
      vim.keymap.set('n', '<leader>h3', function()
        harpoon:list():select(3)
      end, { desc = 'Open [3]' })
      vim.keymap.set('n', '<leader>h4', function()
        harpoon:list():select(4)
      end, { desc = 'Open [4]' })
      vim.keymap.set('n', '<leader>h5', function()
        harpoon:list():select(5)
      end, { desc = 'Open [5]' })
      vim.keymap.set('n', '<leader>h6', function()
        harpoon:list():select(6)
      end, { desc = 'Open [6]' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
      harpoon:extend {
        UI_CREATE = function(cx)
          vim.keymap.set('n', '<C-v>', function()
            harpoon.ui:select_menu_item { vsplit = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-x>', function()
            harpoon.ui:select_menu_item { split = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-t>', function()
            harpoon.ui:select_menu_item { tabedit = true }
          end, { buffer = cx.bufnr })
        end,
      }
    end,
  },
  -- TELESCOPE version
  --     local harpoon = require('harpoon')
  --     harpoon:setup ({})
  --
  --     -- basic telescope configuration
  --     local conf = require('telescope.config').values
  --     local function toggle_telescope(harpoon_files)
  --       local file_paths = {}
  --       for _, item in ipairs(harpoon_files.items) do
  --         table.insert(file_paths, item.value)
  --       end
  --
  --       require('telescope.pickers')
  --         .new({}, {
  --           prompt_title = 'Harpoon',
  --           finder = require('telescope.finders').new_table {
  --             results = file_paths,
  --           },
  --           previewer = conf.file_previewer {},
  --           sorter = conf.generic_sorter {},
  --         })
  --         :find()
  --     end
  --
  --     vim.keymap.set('n', '<leader>ho', function()
  --       toggle_telescope(harpoon:list())
  --     end, { desc = '[O]pen [H]arpoon window' })
  --     vim.keymap.set('n', '<leader>ha', function()
  --       harpoon:list():add()
  --     end, { desc = '[A]dd to [H]arpoon list' })
  --   end,
  -- },
}

-- vim: ts=2 sts=2 sw=2 et
