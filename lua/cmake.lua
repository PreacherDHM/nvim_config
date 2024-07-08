local findfile = function(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local run = function()
    if findfile('CMakeLists.txt') then
        vim.keymap.set('n', '<leader>bb', function()
            local cwd = vim.fn.getcwd()
            vim.cmd.vsplit()
            vim.cmd([[:startinsert | term cmake.exe --build .\build\"]])
            vim.cmd([[:!cmake -E copy ./build/compile_commands.json ./]])
            vim.cmd([[:so C:/Users/jesse/AppData/Local/nvim/init.lua]])
        end
        )
        vim.api.nvim_set_keymap('n', '<leader>bc', '', {
            callback = function()
                local cwd = vim.fn.getcwd()
                vim.cmd([[:startinsert | term cmake.exe -B ./build ]])
                vim.cmd([[:!cmake -E copy ./build/compile_commands.json ./]])
                vim.cmd([[:so C:/Users/jesse/AppData/Local/nvim/init.lua]])
            end,
            desc = "Builds Cmake executable",
            expr = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>bf', '', {
            callback = function()
                local input = vim.fn.input("What Makefile: ")
                local cwd = vim.fn.getcwd()
                vim.cmd([[::startinsert | term cmake.exe -B ./build -G "]] .. input .. [[" .]])
                vim.cmd([[:!cmake -E copy ./build/compile_commands.json ./]])
                vim.cmd([[:so C:/Users/jesse/AppData/Local/nvim/init.lua]])
            end,
            desc = "Builds Cmake executable",
            expr = true,
        })
    else
    end
    return 0
end
return run()
