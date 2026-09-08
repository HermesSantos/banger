local M = {}

local default_pairs = {
  ["true"] = "false",
  ["false"] = "true",
  ["True"] = "False",
  ["False"] = "True",
  ["TRUE"] = "FALSE",
  ["FALSE"] = "TRUE",
  ["yes"] = "no",
  ["no"] = "yes",
  ["Yes"] = "No",
  ["No"] = "Yes",
  ["YES"] = "NO",
  ["NO"] = "YES",
  ["on"] = "off",
  ["off"] = "on",
  ["On"] = "Off",
  ["Off"] = "On",
  ["ON"] = "OFF",
  ["OFF"] = "ON",
  ["1"] = "0",
  ["0"] = "1",
}

M.opts = {
  pairs = default_pairs,
  notify_on_fail = true,
}

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

local function is_keyword_char(char)
  return char ~= "" and char:match("[%w_]")
end

local function current_word_range()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  if line == "" then
    return row, nil, nil, nil
  end

  local index = col + 1
  if index > #line then
    index = #line
  end

  if index < 1 then
    return row, nil, nil, nil
  end

  local char = line:sub(index, index)
  if not is_keyword_char(char) and index > 1 then
    local previous = line:sub(index - 1, index - 1)
    if is_keyword_char(previous) then
      index = index - 1
      char = previous
    end
  end

  if not is_keyword_char(char) then
    return row, nil, nil, line
  end

  local start_col = index
  while start_col > 1 and is_keyword_char(line:sub(start_col - 1, start_col - 1)) do
    start_col = start_col - 1
  end

  local end_col = index
  while end_col <= #line and is_keyword_char(line:sub(end_col, end_col)) do
    end_col = end_col + 1
  end

  return row, start_col, end_col, line
end

function M.toggle()
  local row, start_col, end_col, line = current_word_range()
  if not start_col or not end_col or not line then
    if M.opts.notify_on_fail then
      vim.notify("No toggleable value under cursor", vim.log.levels.INFO)
    end
    return false
  end

  local word = line:sub(start_col, end_col - 1)
  local replacement = M.opts.pairs[word]
  if not replacement then
    if M.opts.notify_on_fail then
      vim.notify(("No toggle configured for '%s'"):format(word), vim.log.levels.INFO)
    end
    return false
  end

  local new_line = line:sub(1, start_col - 1) .. replacement .. line:sub(end_col)
  vim.api.nvim_set_current_line(new_line)
  vim.api.nvim_win_set_cursor(0, { row, start_col - 1 })
  return true
end

return M
