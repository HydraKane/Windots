return {
    "scottmckendry/gotestsum.nvim",
    enabled = false,
    build = function()
        vim.cmd("silent !go install gotest.tools/gotestsum@latest")
    end,
    dir = "gotestsum",
    dev = true,
    cmd = "GoTestSum",
}
