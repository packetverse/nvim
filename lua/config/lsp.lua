-- Diagnostics configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "■",
    spacing = 2,
    source = "if_many",
  },
  severity_sort = true,
  update_in_insert = true,
  float = {
    max_height = 20,
    max_width = 80,
    anchor_bias = "auto",
    source = "if_many",
  },
})

-- LSP loading
vim.schedule(function()
  require("core.lsp").load_lsps()
end)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("nine/lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    local opts = { buffer = bufnr, silent = true, noremap = true }

    -- Keymaps
    vim.keymap.set("n", "<leader>ls", function()
      require("core.lsp").stop_lsps(bufnr)
    end, opts)
    vim.keymap.set("n", "<leader>lr", function()
      require("core.lsp").restart_lsps(bufnr)
    end, opts)
    vim.keymap.set("n", "<leader>li", function()
      require("core.lsp").get_lsps(bufnr)
    end, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

    -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- LSP Progress
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and ""
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
