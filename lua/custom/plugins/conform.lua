return {
  'stevearc/conform.nvim',

  opts = {
    notify_on_error = true,

    format_on_save = function(bufnr)
      if vim.g.FORMAT_ON_SAVE == 0 then
        return
      end

      return {
        timeout_ms = 3000,
        lsp_fallback = true,
      }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },

      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },

      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },

      vue = { 'prettierd' },

      css = { 'prettierd' },
      scss = { 'prettierd' },

      json = { 'prettierd' },
      yaml = { 'prettierd' },
      markdown = { 'prettierd' },
    },
  },
}
