return {
    -- "numiras/semshi",
    "wookayin/semshi", -- use a maintained fork
    ft = "python",
    build = ":UpdateRemotePlugins",
    enabled = false,
    init = function()
        -- vim.cmd("autocmd FileType python Semshi enable")
        -- vim.g.semshi_no_default_maps = 1

        -- Disabled these features better provided by LSP or other more general plugins
        -- vim.g["semshi#filetypes"] = ["python"]
        -- vim.g["semshi#exclude_h1_groups"] = ["local"]
        -- vim.g["semshi#mark_selected_nodes"] = false
        -- vim.g["semshi#no_default_builtin_highlight"] = v:true
        vim.g["semshi#simplify_markup"] = false -- v:true

        -- 跟 lsp 重複了, 可以關掉, 不過打開可以檢查是否正確運行
        -- vim.g["semshi#error_sign"] = false

        vim.g["semshi#error_sign_delay"] = 1.5
        -- vim.g["semshi#always_update_all_highlights"] = v:false
        -- vim.g["semshi#tolerate_syntax_errors"] = v:true
        vim.g["semshi#update_delay_factor"] = 0.001
        -- vim.g["self_to_attribute"] = v:true

        -- This autocmd must be defined in init to take effect
        vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
            group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
            callback = function()
                -- Only add style, inherit or link to the LSP's colors
                vim.cmd([[
                highlight! semshiGlobal gui=italic
                highlight! link semshiImported @none
                highlight! link semshiParameter @lsp.type.parameter
                highlight! link semshiParameterUnused DiagnosticUnnecessary
                highlight! link semshiBuiltin @function.builtin
                highlight! link semshiAttribute @field
                highlight! link semshiSelf @lsp.type.selfKeyword
                highlight! link semshiUnresolved @lsp.type.unresolvedReference
                highlight! link semshiFree @none
            ]])
            end,
        })
    end,
}
