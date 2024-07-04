-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("graphVIMewer")
-- ~/.config/nvim/init.lua


vim.api.nvim_create_user_command("ShowGraph", function(opts)
  require("plugins.graphVIMewer").show_graph(opts.args)
end, { nargs = 1, complete = "file" })

