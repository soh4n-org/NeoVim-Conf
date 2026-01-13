 if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  lazy = false, -- disable lazy loading
  priority = 10000, -- load AstroUI first
  opts = {
    -- Colorscheme set on startup
    colorscheme = "astrodark",
    -- Configure how folding works
    folding = {
      enabled = function(bufnr) return require("astrocore.buffer").is_valid(bufnr) end,
      methods = { "lsp", "treesitter", "indent" },
    },

    -- VISUAL CUSTOMIZATIONS
    highlights = {
      -- "init" applies to ALL colorschemes
      init = {
        -- MODERN BACKGROUND:
        -- Setting bg to "NONE" allows your terminal's default background (usually a nice gray)
        -- to show through, creating a transparent/modern effect.
        Normal = { bg = "NONE", ctermbg = "NONE" },
        NormalNC = { bg = "NONE", ctermbg = "NONE" },
        NeoTreeNormal = { bg = "NONE", ctermbg = "NONE" },
        NeoTreeNormalNC = { bg = "NONE", ctermbg = "NONE" },
        
        -- Make floating windows blend or stand out slightly
        NormalFloat = { bg = "NONE" },
        FloatBorder = { fg = "#7aa2f7", bg = "NONE" },
        
        -- Make line numbers subtle
        LineNr = { fg = "#565f89" },
        
        -- Modern visual selection (softer blue/gray)
        Visual = { bg = "#1f2f2a" },
      },
      
      -- Specific overrides for astrodark if you toggle transparency off later
      astrodark = {
        -- If you decide to remove the "NONE" above, this sets a soft charcoal gray
        -- instead of the pitch black #000000 you had before.
        Normal = { bg = "#2E3440" }, 
      },
    },

    -- ICONS (Comprehensive Nerd Font set)
    icons = {
      -- UI
      ActiveLsp = "",
      BufferClose = "󰅖",
      DapBreakpoint = "",
      DefaultFile = "",
      Diagnostic = "",
      DiagnosticError = "",
      DiagnosticHint = "󰌵",
      DiagnosticInfo = "",
      DiagnosticWarn = "",
      Ellipsis = "…",
      FileModified = "",
      FileReadOnly = "",
      FoldClosed = "",
      FoldOpened = "",
      FolderClosed = "",
      FolderEmpty = "",
      FolderOpen = "",
      Git = "",
      GitAdd = "",
      GitBranch = "",
      GitChange = "",
      GitConflict = "",
      GitDelete = "",
      GitIgnored = "◌",
      GitRenamed = "➜",
      GitStaged = "✓",
      GitUnstaged = "✗",
      GitUntracked = "★",
      LSPLoaded = "",
      LSPLoading1 = "",
      LSPLoading2 = "",
      LSPLoading3 = "",
      MacroRecording = "",
      Paste = "",
      Search = "",
      Selected = "❯",
      Spellcheck = "暈",
      TabClose = "󰅙",
    },

    -- STATUSLINE & BARS
    status = {
      attributes = {
        mode = { bold = true },
        git_branch = { bold = true },
      },
      colors = {
        git_branch_fg = "#98c379",
        mode_normal = "#61afef",
      },
      icon_highlights = {
        breadcrumbs = true, -- Enable nice coloring for breadcrumbs
        file_icon = {
          tabline = function(self) return self.is_active or self.is_visible end,
          statusline = true,
        },
      },
      separators = {
        none = { "", "" },
        left = { "", " " },
        right = { " ", "" },
        center = { "  ", "  " },
        tab = { "", "" },
        breadcrumbs = "  ",
        path = "  ",
      },
      -- Winbar (Top bar with breadcrumbs) configuration
      winbar = {
        enabled = {
          filetype = { 
            "gitsigns.blame",
            "lua",
            "python",
            "javascript",
            "typescript", 
            "html", 
            "css", 
            "json",
            "rust"
          },
        },
        disabled = {
          buftype = { "nofile", "terminal", "prompt" },
          filetype = { "alpha", "dashboard", "neo-tree", "Trouble" },
        },
      },
    },

    -- LAZYGIT INTEGRATION
    lazygit = {
      theme_path = vim.fs.normalize(vim.fn.stdpath "cache" .. "/lazygit-theme.yml"),
      theme = {
        [241] = { fg = "Special" },
        activeBorderColor = { fg = "MatchParen", bold = true },
        cherryPickedCommitBgColor = { fg = "Identifier" },
        cherryPickedCommitFgColor = { fg = "Function" },
        defaultFgColor = { fg = "Normal" },
        inactiveBorderColor = { fg = "FloatBorder" },
        optionsTextColor = { fg = "Function" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
        selectedLineBgColor = { bg = "Visual" },
        unstagedChangesColor = { fg = "DiagnosticError" },
      },
    },
  },
}


