# banger.nvim

Toggle boolean-like values under the cursor in Neovim.

## Features

- Toggles `true` <-> `false`
- Toggles `yes` <-> `no`
- Toggles `on` <-> `off`
- Toggles `1` <-> `0`
- Preserves case variants like `True` <-> `False` and `ON` <-> `OFF`

## Installation

### lazy.nvim

```lua
{
  "hrmz/banger.nvim",
  opts = {},
}
```

## Usage

Use the built-in command:

```vim
:BangerToggle
```

Or create your own keymap:

```lua
vim.keymap.set("n", "!", function()
  require("banger").toggle()
end, { desc = "Toggle boolean under cursor" })
```

## Configuration

These are the default options:

```lua
require("banger").setup({
  notify_on_fail = true,
  pairs = {
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
  },
})
```

You can extend or replace pairs:

```lua
require("banger").setup({
  pairs = {
    ["enable"] = "disable",
    ["disable"] = "enable",
  },
})
```

## License

MIT
