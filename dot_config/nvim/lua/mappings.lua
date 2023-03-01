local ts = require("telescope")
local dap = require("dap")
local tsb = require("telescope.builtin")
local wk = require("which-key")

-- set timeout for which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

wk.setup {}

wk.register({
  b = {
    name = "Buffers",
    a = { "<cmd>b#<cr>", "Alternate" },
  },
  d = {
    name = "DAP",
    B = { function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "Set breakpoint condition" },
    P = { function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, "Set breakpoint condition" },
    b = { dap.toggle_breakpoint, "Toggle breakpoint" },
    c = { dap.continue, "Continue" },
    l = { dap.run_last, "Run last" },
    r = { dap.repl.toggle, "Toggle REPL" },
    sO = { dap.step_out, "Step out" },
    si = { dap.step_into, "Step into" },
    so = { dap.step_over, "Step over" },
  },
  f = {
    name = "Telescope search",
    ["."] = { tsb.resume, "Resume" },
    [":"] = { tsb.command_history, "Command history" },
    ["/"] = { tsb.search_history, "Search history" },
    b = { tsb.buffers, "Buffers" },
    e = { ts.extensions.file_browser.file_browser, "File browser" },
    f = { tsb.find_files, "Find files" },
    g = { ts.extensions.live_grep_args.live_grep_args, "Live grep args" },
    h = { tsb.help_tags, "Help tags" },
    j = { tsb.jumplist, "Jumplist" },
    k = { tsb.keymaps, "Keymaps" },
    m = { tsb.marks, "Marks" },
    o = { tsb.oldfiles, "Old files" },
    s = { tsb.spell_suggest, "Spell suggest" },
    w = { tsb.grep_string, "Grep string" },
  },
  g = {
    name = "Git",
    C = { tsb.git_bcommits, "Git buffer commits" },
    S = { tsb.git_stash, "Git stash" },
    b = { tsb.git_branches, "Git branches" },
    c = { tsb.git_commits, "Git commits" },
    f = { tsb.git_files, "Git files" },
    s = { tsb.git_status, "Git status" },
  },
  l = {
    name = "LSP",
    A = { vim.lsp.buf.code_action, "LSP code action" },
    C = { tsb.lsp_outgoing_calls, "Git files" },
    E = { tsb.diagnostics, "Diagnostics", buffer = 0 },
    H = { vim.lsp.buf.signature_help, "LSP signature help" },
    R = { vim.lsp.buf.rename, "LSP rename" },
    S = { tsb.lsp_workspace_symbols, "Git files" },
    c = { tsb.lsp_incoming_calls, "Git files" },
    d = { tsb.lsp_definitions, "LSP definitions" },
    e = { tsb.diagnostics, "Diagnostics" },
    f = { vim.lsp.buf.format, "LSP format" },
    h = { vim.lsp.buf.hover, "LSP hover" },
    i = { tsb.lsp_implementations, "LSP implementations" },
    r = { tsb.lsp_references, "LSP references" },
    s = { tsb.lsp_document_symbols, "Git files" },
    t = { tsb.lsp_type_definitions, "LSP type definitions" },
  },
}, { prefix = "<leader>" })
