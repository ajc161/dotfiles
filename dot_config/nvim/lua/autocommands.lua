function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{"autocmd", def}, " ")
      vim.cmd(command)
    end
    vim.cmd("augroup END")
  end
end


local autocmds = {
    reload_vimrc = {
        {"BufWritePost",[[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]},
    },
    packer = {
        { "BufWritePost", "plugins.lua", "PackerCompile" },
    },
    terminal_job = {
        { "TermOpen", "*", "startinsert" },
        { "TermOpen", "*", "setlocal signcolumn=no nonumber norelativenumber" },
    },
    resize_windows_proportionally = {
        { "VimResized", "*", ":wincmd =" },
    },
    toggle_search_highlighting = {
        { "InsertEnter", "*", "setlocal nohlsearch" },
    },
    relative_number = {
        { "InsertEnter", "*", "setlocal norelativenumber" },
        { "InsertLeave", "*", "setlocal relativenumber" },
    },
}

nvim_create_augroups(autocmds)
