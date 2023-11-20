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
    'leoluz/nvim-dap-go',
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
    local js_based_languages = {
      "typescript", "javascript", "javascriptreact", "typescriptreact",
      -- using pwa-chrome
      "vue"
    }

    -- require('mason-nvim-dap').setup {
    --   -- Makes a best effort to setup the various debuggers with
    --   -- reasonable debug configurations
    --   automatic_setup = true,
    --   automatic_installation = false,
    --
    --   -- You can provide additional configuration to the handlers,
    --   -- see mason-nvim-dap README for more information
    --   handlers = {
    --     python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
    --   },
    --
    --   -- You'll need to check that you have the required things installed
    --   -- online, please don't ask me how to install them :)
    --   ensure_installed = {
    --     -- Update this to ensure that you have the debuggers for the langs you want
    --     -- TODO: uncomment when debugging go
    --     -- 'delve',
    --     'python',
    --     'typescript',
    --     'javascript',
    --     'typescriptreact'
    --   },
    -- }


    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Current File (pwa-node)',
          cwd = vim.fn.getcwd(),
          args = { '${file}' },
          sourceMaps = true,
          protocol = 'inspector',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Current File (pwa-node with ts-node)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { '--loader', 'ts-node/esm' },
          runtimeExecutable = 'node',
          args = { '${file}' },
          sourceMaps = true,
          protocol = 'inspector',
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Current File (pwa-node ts-node-dev)',
          cwd = vim.fn.getcwd(),
          runtimeExecutable = 'ts-node-dev',
          runtimeArgs = { '--respawn', '--loader', 'ts-node/esm' },
          args = { '${file}' },
          sourceMaps = true,
          protocol = 'inspector',
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Current File (pwa-node with deno)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { 'run', '--inspect-brk', '--allow-all', '${file}' },
          runtimeExecutable = 'deno',
          attachSimplePort = 9229,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Test Current File (pwa-node with jest)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
          runtimeExecutable = 'node',
          args = { '${file}', '--coverage', 'false' },
          rootPath = '${workspaceFolder}',
          sourceMaps = true,
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Test Current File (pwa-node with vitest)',
          cwd = vim.fn.getcwd(),
          program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
          args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
          autoAttachChildProcesses = true,
          smartStep = true,
          console = 'integratedTerminal',
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch Test Current File (pwa-node with deno)',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
          runtimeExecutable = 'deno',
          attachSimplePort = 9229,
        },
        {
          type = 'pwa-chrome',
          request = 'attach',
          name = 'Attach Program (pwa-chrome = { port: 9222 })',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          port = 9222,
          webRoot = '${workspaceFolder}',
        },
        {
          type = 'node2',
          request = 'attach',
          name = 'Attach Program (Node2)',
          processId = require('dap.utils').pick_process,
        },
        {
          type = 'node2',
          request = 'attach',
          name = 'Attach Program (Node2 with ts-node)',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
          port = 9229,
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach Program (pwa-node)',
          cwd = vim.fn.getcwd(),
          processId = require('dap.utils').pick_process,
          skipFiles = { '<node_internals>/**' },
        },
      }
    end

    require('dap-vscode-js').setup({
      -- node_path = "node",                                                           -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = os.getenv('HOME') .. "/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
      -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
