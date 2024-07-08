--------------------------------------------------
--                  MSBuild                     --
--      This lua file configurs and runs the    --
--      *MSBuild Tool* or any project that has  --
--              a .sln file.                    --
--------------------------------------------------

-- Configuration
local config = {
    -- Keybindings
    keybindings = {
        -- Set Project Name
        ProjectName = '',
        -- Set Configuration
        ProjectConfig = '',
        -- Set Project
        Project = ''
    }
}


local findfile = function(name)
    local cwd = vim.fn.getcwd()
    local file_exists = vim.fn.globpath("./", name)
    return file_exists
end

local inputProject = ""
local inputConfiguration = ""
local fileName = ''



local msBuild = function()
    vim.cmd.vsplit()
    vim.cmd([[:startinsert | term MSBuild.exe ]] ..
        fileName ..
        [[ /m /t:]] ..
        inputProject .. [[ /p:Configuration="]] .. inputConfiguration .. [[" /p:BuildProjectReferences=false]])
end

local SetConfiguration = function()
    inputProject = vim.fn.input("project: ")
    if inputConfiguration == "" then
        inputConfiguration = vim.fn.input("Configuration: ")
    end
    msBuild()
end

local SetProjectName = function()
    if inputProject == "" then
        inputProject = vim.fn.input("project: ")
    end
    inputConfiguration = vim.fn.input("Configuration: ")
    msBuild()
end

local SetProject = function()
    if inputProject == "" then
        inputProject = vim.fn.input("project: ")
    end
    if inputConfiguration == "" then
        inputConfiguration = vim.fn.input("Configuration: ")
    end
    msBuild()
end

local run = function()
    fileName = findfile('*.sln')
    if fileName ~= nil then
        if config.keybindings.ProjectName ~= '' then
            vim.api.nvim_set_keymap('n', config.keybindings.ProjectName, '', {
                callback = SetProject })
        end
        if config.keybindings.ProjectConfig ~= '' then
            vim.api.nvim_set_keymap('n', config.keybindings.ProjectConfig, '', {
                callback = SetProjectName })
        end
        if config.keybindings.Project ~= '' then
            vim.api.nvim_set_keymap('n', config.keybindings.Project, '', {
                callback = SetConfiguration })
        end
    end
end

return run()
