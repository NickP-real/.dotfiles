local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
    disable = { "python", "dart" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gni",
      scope_incremental = "gnc",
      node_decremental = "gnm",
    },
  },
  autotag = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
    colors = {
      "#abb2bf", -- bright white
      "#c678dd", -- purple
      -- "#528bff", -- bright blue
      "#61afef", -- blue
      "#98c379", -- green
      "#e5c07b", -- bright yellow
      "#d19a66", -- bright orange
      "#e86671", -- bright red

      -- "#798294", -- white
      -- "#c678dd", -- purple
      -- "#61afef", -- blue
      -- "#98c379", -- green
      -- "#ebd09c", -- yellow
      -- "#e59b4e", -- orange
      -- "#e06c75", --red,

      -- "#e06c75", - red
      -- "#ebd09c", -- yellow
      -- "#e59b4e", -- orange
      -- "#98c379", -- green
      -- "#61afef", -- blue
      -- "#56b6c2", -- cyan
      -- "#c678dd", -- purple
    },
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["uc"] = "@comment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",
        ["<leader>sf"] = "@function.outer",
        ["<leader>se"] = "@element",
      },
      swap_previous = {
        ["<leader>sA"] = "@parameter.inner",
        ["<leader>sF"] = "@function.outer",
        ["<leader>sE"] = "@element",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      ["[F"] = "@function.outer",
      goto_previous_end = {
        ["[]"] = "@class.outer",
      },
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = ",", -- (Optional) keymap to select the previous selection
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
      ["i;"] = "textsubjects-container-inner",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  matchup = {
    enable = true,
  },
})
