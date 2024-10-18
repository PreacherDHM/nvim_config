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

local fileName = ""
local inputProject = ""
local inputConfiguration = ""

local msBuild = function()
    vim.cmd.vsplit()
    vim.cmd([[:startinsert | term MSBuild.exe ]] ..
        fileName ..
        [[ /m /t:]] ..
        inputProject ..
        [[ /p:Configuration="]] ..
        inputConfiguration ..
        [[" /p:BuildProjectReferences=false]]
    )
end

local function Build()
    if inputProject == "" then
        inputProject = vim.fn.input("project: ")
    end
    if inputConfiguration == "" then
        inputConfiguration = vim.fn.input("Configuration: ")
    end
    msBuild()
end

local function SetConfiguration()
    inputProject = vim.fn.input("project: ")
    if inputConfiguration == "" then
        inputConfiguration = vim.fn.input("Configuration: ")
    end
    msBuild()
end

local function SetProject()
    if inputProject == "" then
        inputProject = vim.fn.input("project: ")
    end
    inputConfiguration = vim.fn.input("Configuration: ")
    msBuild()
end

local run = function(table)
    fileName = findfile('*.sln')
    if fileName ~= nil then
        vim.api.nvim_set_keymap('n', '<leader>bb', '', {
            callback = Build() })
        vim.api.nvim_set_keymap('n', '<leader>bp', '', {
            callback = SetProject() })
        vim.api.nvim_set_keymap('n', '<leader>bc', '', {
            callback = SetConfiguration() })
    end
end

return run(table)
