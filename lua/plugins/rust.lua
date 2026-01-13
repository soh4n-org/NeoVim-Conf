return {
  { import = "astrocommunity.pack.toml" },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "rust" })
      end
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      handlers = { rust_analyzer = false }, -- disable setup of `rust_analyzer`
      ---@diagnostic disable: missing-fields
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  "target",
                },
              },
              check = {
                command = "clippy",
                extraArgs = {
                  "--no-deps",
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    -- use Termux-provided codelldb instead
    opts = function(_, _opts)
      -- intentionally left blank
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    -- don't add codelldb here
    opts = function(_, _opts)
      -- intentionally left blank
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = { enabled = true },
      },
      lsp = {
        enabled = true,
        on_attach = function(...) require("astrolsp").on_attach(...) end,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      local rustaceanvim_avail, rustaceanvim = pcall(require, "rustaceanvim.neotest")
      if rustaceanvim_avail then table.insert(opts.adapters, rustaceanvim) end
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = vim.fn.has "nvim-0.11" == 1 and "^6" or "^5",
    ft = "rust",
    specs = {
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@type AstroLSPOpts
        opts = {
          handlers = { rust_analyzer = false }, -- disables the setup of `rust_analyzer`
        },
      },
    },
    opts = function()
      local adapter

      -- codelldb binary path
      local termux_codelldb = "/data/data/com.termux/files/usr/bin/codelldb"
      local termux_liblldb = "/data/data/com.termux/files/usr/lib/liblldb.so"

      -- 
      if vim.loop.fs_stat(termux_codelldb) then
        adapter = (require "rustaceanvim.config").get_codelldb_adapter(termux_codelldb, termux_liblldb)
      else
        -- fallback: check mason-managed codelldb, otherwise let rustaceanvim fallback to default adapter
        local codelldb_installed = pcall(function() return require("mason-registry").get_package "codelldb" end)
        local cfg = require "rustaceanvim.config"
        if codelldb_installed then
          local codelldb_path = vim.fn.exepath "codelldb"
          local this_os = vim.uv.os_uname().sysname

          local liblldb_path = vim.fn.expand "$MASON/share/lldb"
          if this_os:find "Windows" then
            liblldb_path = liblldb_path .. "\\bin\\lldb.dll"
          else
            liblldb_path = liblldb_path .. "/lib/liblldb" .. (this_os == "Linux" and ".so" or ".dylib")
          end
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
        else
          adapter = (require "rustaceanvim.config").get_codelldb_adapter()
        end
      end

      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts "rust_analyzer") or {}
      local server = {
        ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table) -- The rust-analyzer settings or a function that creates them.
        settings = function(project_root, default_settings)
          local astrolsp_settings = astrolsp_opts.settings or {}

          local merge_table = require("astrocore").extend_tbl(default_settings or {}, astrolsp_settings)
          local ra = require "rustaceanvim.config.server"
          -- load_rust_analyzer_settings merges any found settings with the passed in default settings table and then returns that table
          return ra.load_rust_analyzer_settings(project_root, {
            settings_file_pattern = "rust-analyzer.json",
            default_settings = merge_table,
          })
        end,
      }
      local final_server = require("astrocore").extend_tbl(astrolsp_opts, server)
      return {
        server = final_server,
        dap = { adapter = adapter, load_rust_types = true },
        tools = { enable_clippy = false },
      }
    end,
    config = function(_, opts) vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim) end,
  },
}
