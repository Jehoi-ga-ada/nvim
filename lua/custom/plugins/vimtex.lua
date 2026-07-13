-- LaTeX editing + compile-to-PDF via VimTeX.
-- Compiles with latexmk (already installed at /Library/TeX/texbin) and
-- opens the PDF in macOS Preview, which auto-reloads on each recompile.
--
-- Keymaps (localleader is `\`):
--   \ll = start/stop continuous compile   \lv = view PDF
--   \lk = stop compile                     \lc = clean aux files
--   \le = show compile errors (quickfix)   \lt = table of contents
-- SyncTeX forward/inverse search is NOT wired up (Preview can't do it);
-- switch the viewer to Skim if you want that (see below).

---@module 'lazy'
---@type LazySpec
return {
  'lervag/vimtex',
  lazy = false, -- vimtex recommends against lazy-loading (breaks inverse search)
  init = function()
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'open'
    vim.g.vimtex_view_general_options = '-a Preview'
    -- latexmk is the default compiler; nothing else to configure.
  end,
}
