local dap = require 'dap'

local js_based_languages = {
  "typescript", "javascript", "javascriptreact", "typescriptreact",
  -- using pwa-chrome
  "vue"
}

for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Auto Attach (pwa-node)',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
    },
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
      type = 'pwa-chrome',
      request = 'attach',
      name = 'Attach Program (pwa-chrome = { port: 9222 })',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      port = 9222,
      webRoot = '${workspaceFolder}',
    },
  }
end

require('dap-vscode-js').setup({
  -- node_path = "node",                                                          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = os.getenv('HOME') .. "/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})
