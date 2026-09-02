-- DevOps filetype plugins
--
-- These add proper filetype detection + syntax for tools whose files
-- aren't recognized well out of the box. LSP, linting, and formatting
-- for these are configured in init.lua (servers table, conform, nvim-lint).
--
-- Note: formatting is handled by conform (terraform_fmt / packer_fmt),
-- so the plugins' own format-on-save is left OFF to avoid double-running.
--
-- Helm needs no plugin: init.lua detects filetype=helm and treesitter has a
-- `helm` parser. vim-helm was removed -- its ftdetect rewrote 'filetype' from a
-- non-nested FileType autocmd, so FileType helm never fired and the buffer kept
-- a stale `yaml` highlighter (templates rendered nearly colourless).
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'helm',
  callback = function(args)
    vim.bo[args.buf].commentstring = '{{/* %s */}}'
  end,
})

---@module 'lazy'
---@type LazySpec
return {
  -- Terraform / HCL: :Terraform commands, syntax, better indentation.
  {
    'hashivim/vim-terraform',
    ft = { 'terraform', 'terraform-vars', 'hcl' },
    init = function()
      vim.g.terraform_fmt_on_save = 0 -- conform owns formatting
      vim.g.terraform_align = 1
    end,
  },

  -- Ansible: sets filetype=ansible for playbooks/roles so ansiblels
  -- and ansible-lint kick in (see init.lua ansiblels.filetypes).
  {
    'pearofducks/ansible-vim',
    ft = { 'ansible', 'yaml.ansible' },
  },
}
