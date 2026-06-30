-- Linting

---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = { 'markdownlint' }, -- Make sure to install `markdownlint` via mason / npm
      python = { 'mypy' }, -- Add mypy here
      -- DevOps linters (CLIs installed via mason-tool-installer in init.lua)
      dockerfile = { 'hadolint' },
      terraform = { 'tflint' },
      yaml = { 'yamllint' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      ansible = { 'ansible_lint' },
    }

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- instead set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    --
    -- However, note that this will enable a set of default linters,
    -- which will cause errors unless these tools are available:
    -- {
    --   clojure = { "clj-kondo" },
    --   dockerfile = { "hadolint" },
    --   inko = { "inko" },
    --   janet = { "janet" },
    --   json = { "jsonlint" },
    --   markdown = { "vale" },
    --   rst = { "vale" },
    --   ruby = { "ruby" },
    --   terraform = { "tflint" },
    --   text = { "vale" }
    -- }
    --
    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft['text'] = nil
    local mypy = lint.linters.mypy
    mypy.args = {
      '--show-column-numbers',
      '--show-error-codes',
      '--hide-error-context',
      '--incremental',
      -- Use the VIRTUAL_ENV variable you set in your main init.lua
      '--python-executable',
      vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. '/bin/python') or 'python',
    }
    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if not vim.bo.modifiable then return end

        -- Only run linters whose executable is actually installed. This avoids
        -- errors (e.g. inside netrw's BufEnter) when a configured linter such
        -- as `markdownlint` is missing from the system.
        local available = {}
        for _, name in ipairs(lint.linters_by_ft[vim.bo.filetype] or {}) do
          local linter = lint.linters[name]
          local cmd = type(linter) == 'table' and linter.cmd or nil
          cmd = type(cmd) == 'function' and cmd() or cmd
          if cmd and vim.fn.executable(cmd) == 1 then table.insert(available, name) end
        end
        if #available > 0 then lint.try_lint(available) end
      end,
    })
  end,
}
