return {
	-- Comentar lineas de código
  -- {"numToStr/Comment.nvim",
  --   opts = {
  --     toggler = { -- LHS of toggle mappings in NORMAL mode
  --       line = 'gcc', -- Line-comment toggle keymap
  --       block = 'gbb', -- Block-comment toggle keymap
  --     },
  --   }
  -- }
  {
    'nvim-mini/mini.comment',
    version = false,
    config = function()
      require("mini.comment").setup({
        mappings = {
          comment = 'gc',
          comment_line = 'gcc',
          comment_visual = 'gc',
          textobject = 'gc',
        }
      })
    end
  },
}
