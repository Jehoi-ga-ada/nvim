-- DevOps filetype plugins
--
-- These add proper filetype detection + syntax for tools whose files
-- aren't recognized well out of the box. LSP, linting, and formatting
-- for these are configured in init.lua (servers table, conform, nvim-lint).
--
-- Note: formatting is handled by conform (terraform_fmt / packer_fmt),
-- so the plugins' own format-on-save is left OFF to avoid double-running.

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

  -- Helm: sets filetype=helm for chart templates so helm_ls attaches
  -- and gotmpl-in-yaml doesn't show as broken YAML.
  {
    'towolf/vim-helm',
    ft = { 'helm', 'yaml' },
  },

  -- Ansible: sets filetype=ansible for playbooks/roles so ansiblels
  -- and ansible-lint kick in (see init.lua ansiblels.filetypes).
  {
    'pearofducks/ansible-vim',
    ft = { 'ansible', 'yaml.ansible' },
  },
}
