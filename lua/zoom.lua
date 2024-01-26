local api = vim.api

local M = {}

-- the zoom state
-- zoomed created zoom winid : previous winid
local saved_winids = {}

-- get a new table the contains the zoom_tab : previous_tab
-- must have separate function that calls on the fly because tab numbers can change but winid's can't
local function get_tabs()
  local res = {}
  for zoom_winid, previous_winid in pairs(saved_winids) do
    local zoom_tab = vim.fn.win_id2tabwin(zoom_winid)[1]
    local previous_tab = vim.fn.win_id2tabwin(previous_winid)[1]
    res[zoom_tab] = previous_tab
  end
  return res
end

local function get_current_tab_info()
  local current_tabnr = vim.fn.tabpagenr()
  return vim.fn.gettabinfo(current_tabnr)
end

function M.zoom()
  local current_tabnr = vim.fn.tabpagenr()
  local tabs = get_tabs()
  if tabs[current_tabnr] == nil then
    local previous_winid = vim.fn.win_getid()

    -- use tab split to retain view on zoom
    vim.cmd('tab split')

    local new_tabnr = vim.fn.win_getid()

    saved_winids[new_tabnr] = previous_winid
  else
    -- restore view on un-zoom
    local view = vim.fn.winsaveview()
    local goto_tabnr = tabs[current_tabnr]
    vim.cmd('tabclose')
    vim.cmd('tabn ' .. goto_tabnr)
    vim.fn.winrestview(view)
    saved_winids[vim.fn.win_getid()] = nil
  end
end

function M.setup()
    vim.api.nvim_create_user_command('Zoom', M.zoom)
end

return M
