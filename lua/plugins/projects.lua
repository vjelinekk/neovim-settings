return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "pattern", "lsp" }, -- Detects project root using .git or LSP
            patterns = { ".git", "Makefile", "package.json", "CMakeLists.txt" }, -- Define project root markers
        })
        require("telescope").load_extension("projects")
    end,

    vim.keymap.set('n', '<leader>tp', function()
        require("telescope").extensions.projects.projects()
    end, { desc = "Find projects" })
}

