# FastBuild.nvim

> **Note:** FastBuild.nvim is designed to be used with `lazy.nvim`

**FastBuild.nvim** is a Neovim plugin that allows you to quickly load and register local plugins with minimal setup. It enables per-project plugin configuration by detecting and loading a `setup()` function defined in your plugin's `fastbuild.lua`.


## How It Works

When you create a plugin, you add a `lua/<plugin_name>/fastbuild.lua` file containing a `setup()` function. When you run the `:FastBuild` command, FastBuild will detect this file and generate a registration snippet. On your next Neovim startup, this snippet ensures the plugin's `setup()` function is automatically called.


## Registering a Plugin

1. **Navigate to your plugin's root directory.**  
   This is the directory containing `plugin/`, `lua/`, and other plugin files.

2. **Add a `lua/<plugin_name>/fastbuild.lua` file.**  
   This file should return a table with a `setup()` function. Example:

   ```lua
   -- lua/my_plugin/fastbuild.lua
   return {
     setup = function()
       print("My Plugin is setting up!")
     end,
   }
   ```

3. **Run the `:FastBuild` command in Neovim.**

   ```vim
   :FastBuild
   ```

   This command will:
   - Detect the current working directory.
   - Look for the `lua/<plugin_name>/fastbuild.lua` file.
   - Register the plugin for lazy loading.

---

## Installing

Add this block to your `init.lua` or to your plugin list for `lazy.nvim`.  
This block will load `FastBuild.nvim` and automatically include all local plugins added with `:FastBuild`.

```lua
local plugins = {
  { 'HueGreywell/fastbuild.nvim' }
}

local fastbuild_file = vim.fn.stdpath("cache") .. "/fastbuild.lua"
if vim.fn.filereadable(fastbuild_file) == 1 then
  local ok, fastbuild_plugins = pcall(dofile, fastbuild_file)
  if ok and type(fastbuild_plugins) == "table" then
    vim.list_extend(plugins, fastbuild_plugins)
  end
end

return plugins
```

