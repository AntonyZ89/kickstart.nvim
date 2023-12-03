-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    {
      'mxsdev/nvim-dap-vscode-js',
      dependencies = {
        {
          "microsoft/vscode-js-debug",
          build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
        }
      }
    },
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      config = function(_, opts)
        local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
        require("dap-python").setup(path, opts)
      end,
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- load node config
    require('kickstart.plugins.debug.node')

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      { desc = 'Debug: Set Breakpoint' }
    )

    -- Dap UI setup
    --
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
