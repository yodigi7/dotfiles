-- Auto source files if saving init.vim or config.lua
local vim_config_map = {
    ["plugins.lua"] = function()
        package.loaded["user.plugins"] = nil -- Unload plugins file to be resourced
        vim.cmd(":source $MYVIMRC")
        vim.cmd(":PackerCompile") -- Compile lazy loaded plugins
        vim.cmd(":PackerSync") -- Clean and Install new plugins
        print("Loaded config files for vim and synced/compiled with packer")
    end,
    ["init.lua"] = function()
        vim.cmd(":source $MYVIMRC")
        print("Loaded config files for vim")
    end,
    ["autocmds.lua"] = function()
        package.loaded["user.autocmds"] = nil -- Unload plugins file to be resourced
        vim.cmd(":source $MYVIMRC")
        print("Loaded config files for vim and updated autocmds")
    end
}

local vim_conf_group = vim.api.nvim_create_augroup("VimConfigGroup",
                                                   {clear = true})
local file_update_events = {
    "BufWrite", "FileWritePre", "FileAppendPre", "FilterWritePre"
}
for map_pattern, map_callback in pairs(vim_config_map) do
    vim.api.nvim_create_autocmd(file_update_events, {
        pattern = map_pattern,
        group = vim_conf_group,
        callback = function() vim.schedule(map_callback) end
    })
end

-- local trim_whitespace_group = vim.api.nvim_create_augroup("TrimWhiteSpaceGroup", {clear=true})
-- for _, event in pairs(file_update_events) do
--     vim.api.nvim_create_autocmd(event, {
--         pattern = "*",
--         group = trim_whitespace_group,
--         callback = function ()
--             -- Hope this still works otherwise it will trim whitespace after save
--             -- vim.schedule(function ()
--                 vim.cmd(":%s/\\s*$//e|''")
--                 vim.cmd(":noh")
--             -- end)
--         end
--     })
-- end
