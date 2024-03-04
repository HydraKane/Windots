return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "smiteshp/nvim-navic",
    },
    config = function()
        -- Go
        --require("lspconfig").gopls.setup({
        --settings = {
        --gopls = {
        --completeUnimported = true,
        --analyses = {
        --unusedparams = true,
        --},
        --staticcheck = true,
        --},
        --},
        --})

        -- Templ
        --require("lspconfig").templ.setup({})
        --vim.filetype.add({
        --extension = {
        --templ = "templ",
        --},
        --})

        -- Bicep
        --local bicep_path = vim.fn.stdpath("data") .. "/mason/packages/bicep-lsp/bicep-lsp.cmd"
        --require("lspconfig").bicep.setup({
        --cmd = { bicep_path },
        --})
        --vim.filetype.add({
        --extension = {
        --bicepparam = "bicep",
        --},
        --})

        -- Dockerfile
        require("lspconfig").dockerls.setup({})

        -- Docker Compose
        require("lspconfig").docker_compose_language_service.setup({})

        -- C#
        local omnisharp_path = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/omnisharp.dll"
        require("lspconfig").omnisharp.setup({
            cmd = { "dotnet", omnisharp_path },
            enable_ms_build_load_projects_on_demand = true,
        })

        -- JSON
        require("lspconfig").jsonls.setup({
            -- lazy-load schemastore when needed
            on_new_config = function(new_config)
                new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
                json = {
                    format = {
                        enable = true,
                    },
                    validate = { enable = true },
                },
            },
        })

        -- Markdown
        require("lspconfig").marksman.setup({})

        -- HTML
        require("lspconfig").html.setup({})

        -- Tailwind CSS
        require("lspconfig").tailwindcss.setup({})

        -- YAML
        require("lspconfig").yamlls.setup({})

        -- Lua
        require("lspconfig").lua_ls.setup({
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                        },
                    })

                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
                return true
            end,
        })

        -- Python
        require("lspconfig").pyright.setup({})
        require("lspconfig").ruff_lsp.setup({
            -- Define the key mapping for organize imports
            keys = {
                {
                    "<leader>co",
                    function()
                        vim.lsp.buf.code_action({
                            apply = true,
                            context = {
                                only = { "source.organizeImports" },
                                diagnostics = {},
                            },
                        })
                    end,
                    desc = "Organize Imports",
                },
            },
            -- Define the on_attach function for ruff_lsp
            on_attach = function(client, _)
                if client.name == "ruff_lsp" then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end,
        })

        -- PowerShell
        local mason_registry = require("mason-registry")
        local bundle_path = mason_registry.get_package("powershell-editor-services"):get_install_path()
        require("lspconfig").powershell_es.setup({
            bundle_path = bundle_path,
            init_options = {
                enableProfileLoading = false,
            },
        })

        -- Ltex LS (LanguageTool)
        local ltex_cmd = vim.fn.stdpath("data") .. "/mason/packages/ltex-ls/ltex-ls-16.0.0/bin/ltex-ls"
        require("lspconfig").ltex.setup({
            cmd = { ltex_cmd },
            settings = {
                ltex = {
                    checkFrequency = "save",
                    language = "zh-TW",
                },
            },
        })
    end,
}
