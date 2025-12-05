-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system(
    { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  )
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.opt.number = true
vim.opt.relativenumber = true

-- ** Daily notes keymaps config **
local create_daily_note = function(notes_root, template_path)
  -- Check if notes root exists
  if vim.fn.isdirectory(notes_root) == 0 then
    vim.notify("Notes root does not exist: " .. notes_root, vim.log.levels.ERROR)
    return
  end

  -- Check if template file exists
  if vim.fn.filereadable(template_path) == 0 then
    vim.notify("Template file not found: " .. template_path, vim.log.levels.ERROR)
    return
  end

  local date = os.date("*t")
  local year = string.format("%04d", date.year)
  local month = string.format("%02d", date.month)
  local day = string.format("%02d", date.day)
  local weekday = os.date("%a")
  local date_str = string.format("%s-%s-%s-%s", year, month, day, weekday)

  local filename = string.format("%s.md", date_str)
  local dir_path = string.format("%s/%s/%s", notes_root, year, month)
  local full_path = string.format("%s/%s", dir_path, filename)

  vim.fn.mkdir(dir_path, "p")

  if vim.fn.filereadable(full_path) == 0 then
    local template_lines = {}
    local template_file = io.open(template_path, "r")
    if template_file then
      for line in template_file:lines() do
        line = line:gsub("{{date:YYYY%-MM%-DD%-ddd}}", date_str)
        table.insert(template_lines, line)
      end
      template_file:close()
    end

    local out_file = io.open(full_path, "w")
    if out_file then
      for _, line in ipairs(template_lines) do
        out_file:write(line .. "\n")
      end
      out_file:close()
    end
  end

  vim.cmd("edit " .. full_path)
end

vim.api.nvim_create_user_command("DailyMe", function()
  create_daily_note("./notes/me/days", "./notes/_templates/me-days.md")
end, {})

vim.api.nvim_create_user_command("DailyZgen", function()
  create_daily_note("./notes/zgen/days", "./notes/_templates/zgen-days.md")
end, {})
-- Daily notes config end


-- ** Setup lazy.nvim **
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      "ellisonleao/gruvbox.nvim",
      opts = { contrast = "hard" },
      config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.api.nvim_command("colorscheme gruvbox")
      end,
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = { enabled = true },
})
