--------------------------------------------------
--                  MSBuild                     --
--      This lua file configurs and runs the    --
--      *MSBuild Tool* or any project that has  --
--              a .sln file.                    --
--------------------------------------------------

local findfile = function(name)
    local cwd = vim.fn.getcwd()
    local file_exists = vim.fn.globpath("./", name)
    return file_exists
end

local inputProject = ""
local inputConfiguration = ""

local msBuild = function()
    vim.cmd.vsplit()
    vim.cmd([[:startinsert | term MSBuild.exe ]] ..
        fileName ..
        [[ /m /t:]] ..
        inputProject .. [[ /p:Configuration="]] .. inputConfiguration .. [[" /p:BuildProjectReferences=false]])
end

local run = function()
    fileName = findfile('*.sln')
    if fileName ~= nil then
        vim.api.nvim_set_keymap('n', '<leader>bb', '', {
            callback = function()
                if inputProject == "" then
                    inputProject = vim.fn.input("project: ")
                end
                if inputConfiguration == "" then
                    inputConfiguration = vim.fn.input("Configuration: ")
                end
                msBuild()
            end
        })
        vim.api.nvim_set_keymap('n', '<leader>bp', '', {
            callback = function()
                inputProject = vim.fn.input("project: ")
                if inputConfiguration == "" then
                    inputConfiguration = vim.fn.input("Configuration: ")
                end
                msBuild()
            end
        })
        vim.api.nvim_set_keymap('n', '<leader>bc', '', {
            callback = function()
                if inputProject == "" then
                    inputProject = vim.fn.input("project: ")
                end
                inputConfiguration = vim.fn.input("Configuration: ")
                msBuild()
            end
        })
    end
end

return run()
