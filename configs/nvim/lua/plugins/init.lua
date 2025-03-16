-- TagBar
vim.g.tagbar_autofocus = 1
-- vim-visual-multi
vim.g.VM_show_warnings = 0
vim.g.VM_leader = 'ç'

return {
	-- Saltar entre palabras
  {"phaazon/hop.nvim",
    config = true,
    keys = {
      {'<leader>f', '<cmd>HopChar2<CR>', desc="Buscar palabras por 2 caracteres" },
      {'<leader>F', '<cmd>HopWord<CR>' , desc="Buscar palabras"                  },
    }
  },

  -- Multiple cursors
  "mg979/vim-visual-multi",

  -- Colorizado de códigos hexadecimales y de etiquetas rgb()
  {"norcalli/nvim-colorizer.lua",
    opts = {
      '*' -- Execute for all filetypes. See docs --> :h colorizer.lua
    },
    lazy = false
  },

  -- Indentation
  {"lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = {
          'help',
          'startify',
        }
      }
    },
    lazy=false
  },

	-- Lista de variables y funciones globales
	{"preservim/tagbar",
    keys = {
      { '<F8>', ':TagbarToggle<CR>', { silent= true, desc="TagBar"} }
    }
  },

	-- Indica a la izquierda de la ventana los marks
	"kshenoy/vim-signature",

	-- Historial, estilo Git, de cambios
	{"mbbill/undotree",
    keys = {
      { '<F5>', ':UndotreeToggle<CR>', { noremap= true } }
    },

    cmd="UndotreeToggle"
  },

	-- Integrar con tmux
	"christoomey/vim-tmux-navigator",

  {"kristijanhusak/vim-carbon-now-sh",
    cmd = "CarbonNowSh",
    keys = {
      { "<F10>", ":CarbonNowSh<CR>", mode="v"},
      { "<F10>", "mfggVG:CarbonNowSh<CR>`fdmf", mode="n"}
    },
  }
}
