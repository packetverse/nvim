local M = {}

local persist_file = vim.fn.stdpath("state") .. "/default_shell"

local known_shells = {
  "pwsh",
  "powershell",
  "cmd",
  "bash",
  "zsh",
  "fish",
  "sh",
  "nu",
}

local function get_installed_shells()
  local shells = {}

  for _, shell in ipairs(known_shells) do
    if vim.fn.executable(shell) == 1 then
      table.insert(shells, shell)
    end
  end

  return shells
end

local function persist(name)
  local f = io.open(persist_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

local function read_persist()
  local f = io.open(persist_file, "r")
  if not f then
    return nil
  end

  local name = f:read("*l")
  f:close()
  return name
end

function M.set(name)
  if not name then
    return
  end

  if vim.fn.executable(name) == 1 then
    vim.opt.shell = name
    persist(name)
    vim.notify("Shell set to " .. name, vim.log.levels.INFO)
  else
    vim.notify("Shell not found: " .. name, vim.log.levels.ERROR)
  end
end

function M.select_shell()
  local installed_shells = get_installed_shells()

  vim.ui.select(installed_shells, { prompt = "Select shell" }, function(choice)
    if choice then
      M.set(choice)
    end
  end)
end

function M.load_default()
  local saved = read_persist()

  if saved and vim.fn.executable(saved) == 1 then
    return saved
  end

  local installed = get_installed_shells()
  return installed[1] or vim.o.shell
end

function M.load()
  vim.opt.shell = M.load_default()
end

return M
