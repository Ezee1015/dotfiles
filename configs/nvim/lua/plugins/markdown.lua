vim.g.table_mode_syntax = 0 -- disable the table syntax for improve speed

return {
  -- Live preview de markdown
  -- Fix: https://github.com/iamcco/markdown-preview.nvim/issues/424
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
  },

  "dhruvasagar/vim-table-mode",

  -- {"mzlogin/vim-markdown-toc",
  --   lazy = false,
  --   keys = {
  --     { '<leader>toc', 'gg:GenTocGFM<CR>', { noremap= true } }
  --   }
  -- },

  -- {'jakewvincent/mkdnflow.nvim',
  --   opts = {
  --     modules = {
  --       cmp = true
  --     },
  --     links = {
  --       conceal = true,
  --       transform_explicit = function(text)
  --         text = text:gsub(" ", "-")
  --         text = text:lower()
  --         -- text = os.date('%Y-%m-%d_')..text
  --         return(text)
  --       end
  --     },
  --     mappings = {
  --       MkdnEnter = {{'n', 'v', 'i'}, '<CR>'},
  --       MkdnTab = false,
  --       MkdnSTab = false,
  --       MkdnNextLink = {'n', ']l'},
  --       MkdnPrevLink = {'n', '[l'},
  --       MkdnNextHeading = {'n', ']]'},
  --       MkdnPrevHeading = {'n', '[['},
  --       MkdnGoBack = {'n', '<BS>'},
  --       MkdnGoForward = {'n', '<Del>'},
  --       MkdnCreateLink = false, -- see MkdnEnter
  --       MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader><S-p>'}, -- see MkdnEnter
  --       MkdnFollowLink = false, -- see MkdnEnter
  --       MkdnDestroyLink = {'n', '<M-CR>'},
  --       MkdnTagSpan = {'v', '<M-CR>'},
  --       MkdnMoveSource = {'n', '<F2>'},
  --       MkdnYankAnchorLink = {'n', 'yaa'},
  --       MkdnYankFileAnchorLink = {'n', 'yfa'},
  --       MkdnIncreaseHeading = {'n', '+'},
  --       MkdnDecreaseHeading = {'n', '-'},
  --       MkdnToggleToDo = {{'n', 'v'}, '<leader>ts'},
  --       MkdnNewListItem = false,
  --       MkdnNewListItemBelowInsert = {'n', 'o'},
  --       MkdnNewListItemAboveInsert = {'n', 'O'},
  --       MkdnExtendList = false,
  --       MkdnUpdateNumbering = {'n', '<leader>nn'},
  --       MkdnTableFormat = {'n', '<leader>tf'},
  --       MkdnTableNextCell = {'i', ']|'},
  --       MkdnTablePrevCell = {'i', '[|'},
  --       MkdnTableNextRow = false,
  --       MkdnTablePrevRow = {'i', '<M-CR>'},
  --       MkdnTableNewRowBelow = {'n', '<leader>ir'},
  --       MkdnTableNewRowAbove = {'n', '<leader>iR'},
  --       MkdnTableNewColAfter = {'n', '<leader>ic'},
  --       MkdnTableNewColBefore = {'n', '<leader>iC'},
  --       MkdnFoldSection = {'n', '<leader>f'},
  --       MkdnUnfoldSection = {'n', '<leader>F'}
  --     },
  --     tables = {
  --       trim_whitespace = true,
  --       format_on_move = true,
  --       auto_extend_rows = false,
  --       auto_extend_cols = false,
  --       style = {
  --           cell_padding = 0,
  --           separator_padding = 0,
  --           outer_pipes = true,
  --           mimic_alignment = false
  --       }
  --   },
  --   }
  -- },

  -- { "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function ()
  --     require("headlines").setup({
  --       markdown = {
  --         headline_highlights = {
  --             'Headline1',
  --             'Headline2',
  --             'Headline3',
  --             'Headline4',
  --             'Headline5',
  --             'Headline6',
  --         },
  --         bullet_highlights = {
  --             "@text.title.1.marker.markdown",
  --             "@text.title.2.marker.markdown",
  --             "@text.title.3.marker.markdown",
  --             "@text.title.4.marker.markdown",
  --             "@text.title.5.marker.markdown",
  --             "@text.title.6.marker.markdown",
  --         },
  --         -- bullets = { "◉", "○", "3", "✸", "✿", "6" },
  --         bullets = { "◉", "◎", "○", "✿", "▶", "⤷" },
  --         codeblock_highlight = "CodeBlock",
  --         dash_highlight = "Dash",
  --         dash_string = "-",
  --         quote_highlight = "Quote",
  --         quote_string = "┃",
  --         -- TO MAKE THE HEADERS TALLER
  --         fat_headlines = false, -- true
  --         -- fat_headline_lower_string = "🬂",
  --         fat_headline_lower_string = "▀",
  --         fat_headline_upper_string = "▃",
  --       },
  --       -- Neorg
  --       norg = {
  --         -- headline_highlights = {
  --         --     'Headline1',
  --         --     'Headline2',
  --         --     'Headline3',
  --         --     'Headline4',
  --         --     'Headline5',
  --         --     'Headline6',
  --         -- },
  --         headline_highlights = false,
  --         codeblock_highlight = "CodeBlock",
  --         dash_highlight = "Dash",
  --         dash_string = "-",
  --         doubledash_highlight = "DoubleDash",
  --         doubledash_string = "=",
  --         quote_highlight = "Quote",
  --         quote_string = "┃",
  --         fat_headlines = true,
  --         fat_headline_lower_string = "▀",
  --         fat_headline_upper_string = "▃",
  --       }
  --     }) -- setup()
  --
  --     vim.api.nvim_set_hl(0, 'Headline1', { fg = '#e90101', bg = '#402626', italic = false })
  --     vim.api.nvim_set_hl(0, 'Headline2', { fg = '#007df2', bg = '#2e486a', italic = false })
  --     vim.api.nvim_set_hl(0, 'Headline3', { fg = '#15aabf', bg = '#35545f', italic = true })
  --     vim.api.nvim_set_hl(0, 'Headline4', { fg = '#1dc13e', bg = '#264026', italic = true })
  --     vim.api.nvim_set_hl(0, 'Headline5', { fg = '#d96e0f', bg = '#403526', italic = true })
  --     vim.api.nvim_set_hl(0, 'Headline6', { fg = '#f59f00', bg = '#403d26', italic = true })
  --
  --   end
  -- },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    config = function()
      require('render-markdown').setup({
        heading = {
          -- Useful context to have when evaluating values.
          -- | level    | the number of '#' in the heading marker         |
          -- | sections | for each level how deeply nested the heading is |

          -- Turn on / off heading icon & background rendering.
          enabled = true,
          -- Additional modes to render headings.
          render_modes = false,
          -- Turn on / off atx heading rendering.
          atx = true,
          -- Turn on / off setext heading rendering.
          setext = true,
          -- Turn on / off any sign column related rendering.
          sign = true,
          -- Replaces '#+' of 'atx_h._marker'.
          -- Output is evaluated depending on the type.
          -- | function | `value(context)`              |
          -- | string[] | `cycle(value, context.level)` |
          -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          icons = { "◉ ", "◎ ", "○ ", "✿ ", "▶ ", "⤷" },
          -- Determines how icons fill the available space.
          -- | right   | '#'s are concealed and icon is appended to right side                          |
          -- | inline  | '#'s are concealed and icon is inlined on left side                            |
          -- | overlay | icon is left padded with spaces and inserted on left hiding any additional '#' |
          position = 'overlay',
          -- Added to the sign column if enabled.
          -- Output is evaluated by `cycle(value, context.level)`.
          signs = { '󰫎 ' },
          -- Width of the heading background.
          -- | block | width of the heading text |
          -- | full  | full width of the window  |
          -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
          width = 'full',
          -- Amount of margin to add to the left of headings.
          -- Margin available space is computed after accounting for padding.
          -- If a float < 1 is provided it is treated as a percentage of available window space.
          -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
          left_margin = 0,
          -- Amount of padding to add to the left of headings.
          -- Output is evaluated using the same logic as 'left_margin'.
          left_pad = 0,
          -- Amount of padding to add to the right of headings when width is 'block'.
          -- Output is evaluated using the same logic as 'left_margin'.
          right_pad = 0,
          -- Minimum width to use for headings when width is 'block'.
          -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
          min_width = 0,
          -- Determines if a border is added above and below headings.
          -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
          border = false,
          -- Always use virtual lines for heading borders instead of attempting to use empty lines.
          border_virtual = false,
          -- Highlight the start of the border using the foreground highlight.
          border_prefix = false,
          -- Used above heading for border.
          above = '▄',
          -- Used below heading for border.
          below = '▀',
          -- Highlight for the heading icon and extends through the entire line.
          -- Output is evaluated by `clamp(value, context.level)`.
          backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg',
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
          },
          -- Highlight for the heading and sign icons.
          -- Output is evaluated using the same logic as 'backgrounds'.
          foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
          },
          -- Define custom heading patterns which allow you to override various properties based on
          -- the contents of a heading.
          -- The key is for healthcheck and to allow users to change its values, value type below.
          -- | pattern    | matched against the heading text @see :h lua-patterns |
          -- | icon       | optional override for the icon                        |
          -- | background | optional override for the background                  |
          -- | foreground | optional override for the foreground                  |
          custom = {},
        },
        sign = {
          enabled = false,
        },
        pipe_table = {
          -- Turn on / off pipe table rendering.
          enabled = true,
          -- Additional modes to render pipe tables.
          render_modes = false,
          -- Pre configured settings largely for setting table border easier.
          -- | heavy  | use thicker border characters     |
          -- | double | use double line border characters |
          -- | round  | use round border corners          |
          -- | none   | does nothing                      |
          preset = 'none',
          -- Determines how the table as a whole is rendered.
          -- | none   | disables all rendering                                                  |
          -- | normal | applies the 'cell' style rendering to each row of the table             |
          -- | full   | normal + a top & bottom line that fill out the table when lengths match |
          style = 'full',
          -- Determines how individual cells of a table are rendered.
          -- | overlay | writes completely over the table, removing conceal behavior and highlights |
          -- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
          -- | padded  | raw + cells are padded to maximum visual width for each column             |
          -- | trimmed | padded except empty space is subtracted from visual width calculation      |
          cell = 'padded',
          -- Amount of space to put between cell contents and border.
          padding = 1,
          -- Minimum column width to use for padded or trimmed cell.
          min_width = 0,
          -- Characters used to replace table border.
          -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
          -- stylua: ignore
          border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
          },
          -- Always use virtual lines for table borders instead of attempting to use empty lines.
          -- Will be automatically enabled if indentation module is enabled.
          border_virtual = false,
          -- Gets placed in delimiter row for each column, position is based on alignment.
          alignment_indicator = '━',
          -- Highlight for table heading, delimiter, and the line above.
          head = 'RenderMarkdownTableHead',
          -- Highlight for everything else, main table rows and the line below.
          row = 'RenderMarkdownTableRow',
          -- Highlight for inline padding used to add back concealed space.
          filler = 'RenderMarkdownTableFill',
        },
      })

      vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { fg = '#e90101', bg = '#402626', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { fg = '#007df2', bg = '#2e486a', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { fg = '#15aabf', bg = '#35545f', italic = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { fg = '#1dc13e', bg = '#264026', italic = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { fg = '#d96e0f', bg = '#403526', italic = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { fg = '#f59f00', bg = '#403d26', italic = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('Highlighter', {}),
        pattern = 'markdown',
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })

    end
  }
}
