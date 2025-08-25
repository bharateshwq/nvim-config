-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.keymap.set("n", "<leader>rj", function()
      local filename = vim.fn.expand("%:t")
      local classname = vim.fn.expand("%:t:r")
      local filedir = vim.fn.expand("%:p:h")
      local cwd = vim.fn.getcwd()
      vim.cmd("w") -- save file
      vim.cmd("!rm -rf ./build/*.class")
      -- Compile and run java manually
      vim.cmd("!javac -d build -classpath ./libs/ " .. filename)
      vim.cmd("terminal cd " .. filedir .. " && /usr/bin/env java -classpath build:libs/ " .. classname)
    end, { desc = "Run Java or Maven" })
  end,
})
