return {
  {
    'numToStr/FTerm.nvim',
    ft = "rust",
    config = function()
      local fterm = require('FTerm')
      
      local cargo_run_term = fterm:new({
        cmd = "cargo run; echo ''; echo 'Press Enter to exit...'; read",
        name = 'CargoRun',
        dimensions = {
          height = 0.9, 
          width = 0.9,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          vim.keymap.set('n', '<leader>tr', function()
            cargo_run_term:toggle()
          end, { desc = 'Run [C]argo [R]un', buffer = true, silent = true })
        end,
      })
    end,
  }
}

