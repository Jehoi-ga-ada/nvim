-- Git conflict resolution: highlights <<<<<<< markers and gives keymaps
-- to pick a side and jump between conflicts.
--   co = ours   ct = theirs   cb = both   c0 = none
--   ]x / [x = next / prev conflict
-- :GitConflictListQfix opens all conflicts in the quickfix list.

---@module 'lazy'
---@type LazySpec
return {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = 'BufReadPre',
  opts = {},
}
