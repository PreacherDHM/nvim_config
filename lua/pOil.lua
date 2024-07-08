require("oil").setup({
	skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
            return vim.startswith(name, '.')
        end
    },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
