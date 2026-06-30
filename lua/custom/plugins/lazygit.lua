-- Lazygit: a full git TUI in a floating window inside Neovim.
-- Requires the `lazygit` binary (installed via Homebrew).
-- Open with <leader>gg, quit it with `q`.

---@module 'lazy'
---@type LazySpec
return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazy[g]it' },
  },
}
