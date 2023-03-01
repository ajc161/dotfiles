local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  },
}

telescope.load_extension("file_browser")
telescope.load_extension("packer")
telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")
