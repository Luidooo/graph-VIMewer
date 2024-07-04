-- ~/.config/nvim/lua/plugins/graphVIMewer.lua

local M = {}

local function readInput_File(filepath)
  local edges = {}
  for line in io.lines(filepath) do
    local n1, n2 = string.match(line, "(%w+), (%w+)")
    if n1 and n2 then
      table.insert(edges, { n1, n2 })
    end
  end
  return edges
end

local function build_graph_representation(edges)
  local graph = {}
  for _, edge in ipairs(edges) do
    local node1, node2 = edge[1], edge[2]
    if not graph[node1] then
      graph[node1] = {}
    end
    if not graph[node2] then
      graph[node2] = {}
    end
    table.insert(graph[node1], node2)
    table.insert(graph[node2], node1)
  end
  return graph
end

local function display_graph(graph)
  local buf = vim.api.nvim_get_current_buf()
  local modifiable = vim.api.nvim_buf_get_option(buf, 'modifiable')
  if not modifiable then
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
  end

  local lines = {}
  for node, neighbors in pairs(graph) do
    table.insert(lines, node .. ": " .. table.concat(neighbors, ", "))
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  if not modifiable then
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  end
end

function M.show_graph(filepath)
  local edges = readInput_File(filepath)
  local graph = build_graph_representation(edges)
  display_graph(graph)
end

return M


