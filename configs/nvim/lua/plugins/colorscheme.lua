return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function ()
    require("tokyonight").setup({
      transparent = true
    })
    vim.cmd.colorscheme("tokyonight")
    -- vim.o.backgrund = 'dark'

    -- Transparent background
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}
