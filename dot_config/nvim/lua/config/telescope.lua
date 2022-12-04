local telescope = require("telescope")

telescope.setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
}

telescope.load_extension("file_browser")
telescope.load_extension("packer")
telescope.load_extension("ui-select")
