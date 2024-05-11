vim.api.nvim_create_user_command(
    "SetGrammar",
    function(opts)
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("lspconfig").ltex.setup {
            settings = {
                ltex = {
                    enabled = {
                        "bibtex",
                        "context",
                        "context.tex",
                        "html",
                        "latex",
                        "markdown",
                        "org",
                        "restructuredtext",
                        "rsweave",
                        "java",
                        "git-commit",
                        "git-rebase",
                        "cpp",
                        "c",
                        "html",
                        "lua"
                    },
                    language = opts.fargs[1]
                }
            },
            capabilities = capabilities
        }
        vim.cmd("LspStart ltex")
    end,
    {
        nargs = 1,
        complete = function()
            return { "de-DE", "en-US" }
        end
    }

)
