vim.cmd([[
  let mapleader = " "

  " map escape to kj
  inoremap kj <ESC>

  " cancel search term highlights
  nnoremap <leader>j :noh<CR>

  " open quicklist
  nnoremap <leader>co :copen<CR>

  " close quicklist
  nnoremap <leader>cc :cclose<CR>

  " Next item on quicklist
  nnoremap <leader>cn :cn<cr>

  " Previous item on quicklist
  nnoremap <leader>cp :cp<cr>
]])

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
