if vim.g.loaded_banger then
  return
end
vim.g.loaded_banger = 1

vim.api.nvim_create_user_command("BangerToggle", function()
  require("banger").toggle()
end, {
  desc = "Toggle the value under cursor",
})
