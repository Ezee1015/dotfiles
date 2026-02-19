vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "MatchParen", { fg="#1c1c1c", bg="#5f8787", reverse=true })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg="#ffaf5f", bold=true })
vim.api.nvim_set_hl(0, "MatchParen", { fg="#ffdd33", bold=true })

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require("tokyonight").setup({
        transparent = true
      })
      -- vim.cmd.colorscheme("tokyonight")

      -- vim.o.backgrund = 'dark'
      -- Transparent background
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
  },

  -- {
  --   "blazkowolf/gruber-darker.nvim",
  --   lazy = false
  -- },
}
