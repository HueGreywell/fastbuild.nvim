local init = require("fastbuild.init")

vim.api.nvim_create_user_command("FastBuild", init.save_plugin, { nargs = 0 })
