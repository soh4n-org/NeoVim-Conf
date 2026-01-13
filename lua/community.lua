-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.recipes.cache-colorscheme" },
  { import = "astrocommunity.completion.cmp-nerdfont" },
  -- { import = "astrocommunity.completion.avante-nvim" },
  { import = "astrocommunity.comment.ts-comments-nvim" },
  -- { import = "astrocommunity.recipes.astrolsp-auto-signature-help" },
  { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },
  -- import/override with your plugins folder
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.editing-support.multicursors-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim"},
  { import = "astrocommunity.debugging.nvim-dap-view" },
}
