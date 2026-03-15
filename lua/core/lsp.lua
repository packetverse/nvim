local M = {}

function M.load_lsps()
  local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
  local files = vim.fn.readdir(lsp_dir)

  for _, file in ipairs(files) do
    if file:match("%.lua$") then
      local name = file:gsub("%.lua$", "")
      local ok, config = pcall(require, "lsp." .. name)

      if ok and type(config) == "table" then
        vim.lsp.config(name, config)
      end

      vim.lsp.enable(name)
    end
  end
end

function M.toggle_inlay_hints(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local active_clients = {}

  for _, client in ipairs(clients) do
    if client:supports_method("textDocument/inlayHint") then
      table.insert(active_clients, client.id)
    end
  end

  if #active_clients == 0 then
    print("[LSP] No LSP client(s) with inlay hints for buffer " .. bufnr)
    return
  end

  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

  for _, _ in ipairs(active_clients) do
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
  end

  print("[LSP] Inlay hints " .. (not enabled and "enabled" or "disabled") .. " for buffer " .. bufnr)
end

function M.stop_lsps(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    vim.notify("[LSP] No active clients", vim.log.levels.INFO, { title = "LSP" })
    return
  end

  for _, client in ipairs(clients) do
    client.stop(client)
  end
  vim.notify("[LSP] Stopped LSP client(s) for buffer " .. bufnr, vim.log.levels.INFO, { title = "LSP" })
end

function M.restart_lsps(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    vim.notify("[LSP] No active clients", vim.log.levels.INFO, { title = "LSP" })
    return
  end

  for _, client in ipairs(clients) do
    local config = vim.deepcopy(client.config)
    client.stop(client)

    vim.defer_fn(function()
      vim.lsp.start(config, { bufnr = bufnr })
    end, 100)
  end
  vim.notify("[LSP] Restarted LSP client(s) for buffer " .. bufnr, vim.log.levels.INFO, { title = "LSP" })
end

function M.get_lsps(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    vim.notify("[LSP] No active clients", vim.log.levels.INFO, { title = "LSP" })
    return
  end

  for _, client in ipairs(clients) do
    vim.notify("[LSP] " .. client.name .. " (id=" .. client.id .. ")", vim.log.levels.INFO, { title = "LSP" })
  end
end

local scroll_timer = nil

function M.scroll_pum(count, direction)
  if vim.fn.pumvisible() ~= 1 then return end

  if scroll_timer then return end
  scroll_timer = vim.defer_fn(function() scroll_timer = nil end, 50)

  local info = vim.fn.complete_info()
  local selected = info.selected
  local size = info.size or (#info.items or 0)
  if size == 0 then return end
  if selected == -1 then selected = direction == "next" and 0 or size - 1 end

  local remaining = direction == "next" and (size - 1 - selected) or selected
  local steps = math.min(count, remaining)
  if steps <= 0 then return end

  local key = direction == "next" and "<C-n>" or "<C-p>"
  local term = vim.api.nvim_replace_termcodes(key, true, true, true)

  for _ = 1, steps do
    vim.api.nvim_feedkeys(term, "n", false)
  end
end

return M
