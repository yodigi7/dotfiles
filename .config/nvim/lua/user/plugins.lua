vim = vim -- Gets rid of eroneous warnings in linting
local programming_languages = {'java', 'python', 'javascript', 'go', 'lua'} -- Add additional coding filetypes here
require('packer').startup(function(use)
    use {
        '~/kattis_plugin',
        disable = true,
        requires = {{'https://github.com/nvim-lua/plenary.nvim'}}
    }
    use 'https://github.com/wbthomason/packer.nvim'
    use {
        'https://github.com/nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "java", "javascript", "typescript", "python", "go",
                    "comment", "json", "jsdoc", "json", "markdown", "regex",
                    "vim"
                }, -- Ensure these are always installed
                auto_install = true, -- Auto install when entering buffer
                highlight = {
                    enable = true -- Enable tree sitter advanced highlighting
                }
            }
        end
    }
    -- 'gx' to go to the github links
    use {
        'https://github.com/unblevable/quick-scope',
        config = function()
            vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
            vim.g.qs_filetype_blacklist = {
                'startify', 'TelescopePrompt', 'TelescopeResults'
            }
        end
    } -- Highlight optimal thing to search
    use {
        'https://github.com/NMAC427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end
    } -- For determining tab style for file
    use {
        'https://github.com/PeterRincker/vim-argumentative',
        disable = true,
        ft = programming_languages
    } -- For manipulating function arguments such as swapping position - TODO: figure out if worth keeping
    use {
        'https://github.com/lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                show_current_context = true, -- Highlight the current outermost closure
                show_current_context_start = true, -- Highlight the start of the current closure
                use_treesitter = true
            }
        end,
        requires = {{"https://github.com/nvim-treesitter/nvim-treesitter"}}
    } -- For showing the vertical columns on tabs for easy tabbing info
    use 'https://github.com/wellle/targets.vim' -- Add new text objects such as din{ to find next instance of {} and to delete everything inside
    use {'https://github.com/michaeljsmith/vim-indent-object'}
    use {
        'https://github.com/justinmk/vim-sneak',
        -- disable = true,
        config = function()
            vim.g['sneak#label'] = true
            vim.keymap.set("n", "<leader>;", "<Plug>Sneak_;", {noremap = false})
            vim.keymap.set("n", "<leader>,", "<Plug>Sneak_,", {noremap = false})
        end -- Make it similar to easymotion after first hit
    } -- Sneak command to do f but with 2 chars and multiline
    use 'https://github.com/gruvbox-community/gruvbox' -- Updated gruvbox color scheme -- original: 'https://github.com/morhetz/gruvbox'
    -- use 'https://github.com/joshdick/onedark.vim' -- Color scheme
    -- TODO: checkout lualine: https://github.com/nvim-lualine/lualine.nvim
    use {
        'https://github.com/vim-airline/vim-airline',
        config = function()
            vim.g["airline#extensions#tabline#enabled"] = false -- Enable bufferline
            vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
        end
    } -- Status bar
    use {
        'https://github.com/akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'https://github.com/kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup({
                options = {separator_style = 'thick'},
                highlights = {buffer_selected = {italic = false}}
            })
        end
    }
    -- TODO: https://github.com/noib3/nvim-cokeline#sparkles-features
    use 'https://github.com/kyazdani42/nvim-web-devicons'
    use 'https://github.com/folke/which-key.nvim' -- Show options for keybindings when in progress
    use {
        'https://github.com/lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                current_line_blame = true,
                numhl = true,
                on_attach = function(bufnr)
                    local function localmap(mode, lhs, rhs, opts)
                        opts = vim.tbl_extend('force',
                                              {noremap = true, silent = true},
                                              opts or {})
                        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                    end
                    localmap('n', '<leader>gh', '<cmd>Gitsigns stage_hunk<CR>')
                    localmap('v', '<leader>gh', '<cmd>Gitsigns stage_hunk<CR>')
                end
            })
        end,
        disable = true
    } -- Basic additional Git integration with sidebar
    use {
        'https://github.com/vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {{syntax = 'markdown', ext = '.md'}}
        end
    } -- Vim wiki
    use 'https://github.com/tpope/vim-repeat' -- Allow plugins to work with dot command
    use {'https://github.com/tpope/vim-surround'} -- Surrounding ysw)
    use 'https://github.com/tpope/vim-fugitive' -- Git integration
    use {
        'https://github.com/tpope/vim-projectionist',
        ft = programming_languages
    } -- Jump from implementation to test files
    use {
        'https://github.com/tpope/vim-dispatch',
        cmd = {'Dispatch', 'Make'},
        config = function()
            local dispatch_map = {
                java = {test = "mvn clean test", build = "mvn clean install"},
                python = {test = "pytest", install = "pip install"},
                javascript = {
                    test = "npm test",
                    run = "npm start",
                    install = "npm install"
                }
            }
            local dispatch_group = vim.api.nvim_create_augroup("DispatchGroup",
                                                               {clear = true})
            for language, commands in pairs(dispatch_map) do
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = {language},
                    group = dispatch_group,
                    callback = function()
                        vim.b.dispatch_commands = commands
                        vim.b.dispatch = commands["test"] -- default to use test command
                    end
                })
            end
        end
    } -- Dispatch built/test/etc jobs to async terminal
    use {
        'https://github.com/kana/vim-textobj-entire',
        requires = {{'https://github.com/kana/vim-textobj-user'}}
    } -- Around everything
    use {
        'https://github.com/preservim/tagbar',
        ft = programming_languages,
        disable = true
    } -- Tagbar for code navigation - TODO: probably remove
    -- DAP (Debugger)
    -- List of DAP adapters - use https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    use {
        'https://github.com/mfussenegger/nvim-dap',
        config = function()
            local dap = require("dap")
            -- Node JS Setup
            dap.adapters.node2 = {
                type = 'executable',
                command = 'node',
                args = {
                    os.getenv('HOME') ..
                        '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'
                }
            }
            dap.configurations.javascript = {
                {
                    name = 'Launch',
                    type = 'node2',
                    request = 'launch',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal'
                }, {
                    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
                    name = 'Attach to process',
                    type = 'node2',
                    request = 'attach',
                    processId = require'dap.utils'.pick_process
                }
            }
        end
    }
    use {
        'https://github.com/mfussenegger/nvim-dap-python',
        ft = 'python',
        requires = {{'https://github.com/mfussenegger/nvim-dap'}}
    }
    use {
        'https://github.com/leoluz/nvim-dap-go',
        ft = 'go',
        config = function() require("dap-go").setup() end,
        requires = {{"https://github.com/mfussenegger/nvim-dap"}}
    }
    use {
        'https://github.com/rcarriga/nvim-dap-ui',
        requires = {{"https://github.com/mfussenegger/nvim-dap"}},
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
        -- ft = programming_languages,
    }
    use {
        'https://github.com/theHamsta/nvim-dap-virtual-text',
        ft = programming_languages
    }
    use 'https://github.com/nvim-lua/plenary.nvim' -- General utils for a lot of plug-ins
    -- Telescope
    use {
        'https://github.com/nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {{'https://github.com/nvim-lua/plenary.nvim'}},
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_config = {prompt_position = "top"},
                    sorting_strategy = "ascending"
                },
                extensions = {
                    file_browser = {
                        -- hijack_netrw = true, -- TODO: makes `gx` not work
                        mappings = {
                            i = {["?"] = "which_key"},
                            n = {["?"] = "which_key"}
                        }
                    }
                }
            })
            require("telescope").load_extension("file_browser")
        end
    }
    use {
        'https://github.com/nvim-telescope/telescope-file-browser.nvim',
        requires = {{'https://github.com/nvim-telescope/telescope.nvim'}}
    }
    use {
        'https://github.com/ThePrimeagen/harpoon',
        -- disable = true,
        requires = {{'https://github.com/nvim-lua/plenary.nvim'}}
    } -- Harpoon - TODO: figure out if will use or not
    use {
        'https://github.com/ThePrimeagen/refactoring.nvim',
        requires = {
            {'https://github.com/nvim-lua/plenary.nvim'},
            {'https://github.com/nvim-treesitter/nvim-treesitter'}
        }
    }
    use {'https://github.com/neovim/nvim-lspconfig'} -- LSP config
    use {
        'https://github.com/williamboman/mason.nvim',
        config = function() require("mason").setup() end
    } -- Installer for lsp and formatters etc.
    -- Run :Mason
    use {
        'https://github.com/numToStr/FTerm.nvim',
        config = function()
            require'FTerm'.setup({
                dimensions = {
                    height = 1,
                    width = 1,
                }
            })
        end,
    }
    use {
        "https://github.com/RishabhRD/nvim-cheat.sh",
        requires = {{'https://github.com/RishabhRD/popfix'}},
        as = "nvim-cheat"
    }
    use {
        'https://github.com/echasnovski/mini.nvim',
        branch = "stable",
        config = function()
            require("mini.comment").setup()
            require("mini.sessions").setup({
                hooks = {
                    pre = {
                        write = function()
                            -- Delete unsaveable buffer before saving
                            -- TODO: do this for all open buffers, not just ones currently focused
                            while (vim.bo.buftype == "nowrite" or vim.bo.buftype ==
                                "prompt" or vim.bo.buftype == "nofile" or
                                vim.bo.buftype == "terminal") do
                                vim.cmd("bdelete")
                            end
                        end
                    }
                }
            })
            local starter = require("mini.starter")
            starter.setup({
                items = {
                    starter.sections.sessions(10, true), {
                        name = "Standup",
                        action = ":e ~/vimwiki/work/Standup.md",
                        section = "Bookmarks"
                    }, {
                        name = "Passwords",
                        action = ":e ~/vimwiki/work/Passwords.md",
                        section = "Bookmarks"
                    },
                    {
                        name = "VimWiki",
                        action = ":e ~/vimwiki/index.md",
                        section = "Bookmarks"
                    }, starter.sections.builtin_actions()
                }
            })
        end
    }
    -- TODO: Reorganize
    use 'https://github.com/hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'https://github.com/hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'https://github.com/saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'https://github.com/L3MON4D3/LuaSnip' -- Snippets plugin
    use 'https://github.com/rafamadriz/friendly-snippets' -- snippets list
    use {
        'https://github.com/jose-elias-alvarez/null-ls.nvim',
        config = function()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    -- null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.json_tool,
                    -- null_ls.builtins.formatting.lua_format,
                    null_ls.builtins.formatting.trim_whitespace,
                    -- null_ls.builtins.code_actions.eslint,
                    null_ls.builtins.diagnostics.pylint
                },
                -- you can reuse a shared lspconfig on_attach callback here
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- vim.lsp.buf.formatting_sync()
                            end
                        })
                    end
                end
            })
        end
    } -- Formatter integration with lsp
    use {
        'https://github.com/windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup({}) end
    }
    use {
        'https://github.com/nvim-treesitter/nvim-treesitter-context',
        requires = {{'https://github.com/nvim-treesitter/nvim-treesitter'}}
    } -- Stick scroll for showing context of scope I am in
    use {
        -- 'https://github.com/folke/todo-comments.nvim', -- FIXME: use this when issue is fixed: https://github.com/folke/todo-comments.nvim/issues/97
        'https://github.com/vinnyA3/todo-comments.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function() require("todo-comments").setup{}; end,
    }
    use {
        'https://github.com/7kfpun/finance.vim',
        config = function()
            vim.g.finance_format = '{1. symbol}: {2. price} ({3. volume})'
            vim.g.finance_cn_format = '{name}: {price} ({updown}/{percent}%)'
        end,
        requires = {{'https://github.com/mattn/webapi-vim'}}
    }
end)
-- TODO:: checkout https://github.com/shift-d/scratch.nvim
-- TODO: checkout for git diffs: https://github.com/sindrets/diffview.nvim
-- TODO: checkout for note taking: https://github.com/nvim-orgmode/orgmode
-- TODO: total possible list: https://github.com/rockerBOO/awesome-neovim
-- TODO: Check out below
-- use 'https://github.com/folke/trouble.nvim' -- Showing pretty list for diagnotics, references, quickfix, locationlists, etc.
-- use 'https://github.com/arafatamim/trouble.nvim' -- Fork of above to work with coc
-- TODO: This causes issues when undoing especially with the auto trim whitespaces
-- use {
--     'https://github.com/Pocco81/AutoSave.nvim',
--     config = function()
--         require('autosave').setup({
--             conditions = {
--                 filename_is_not = {'plugins.lua'}
--             },
--         })
--     end
-- }
-- TODO: checkout alternatives: https://github.com/ggandor/lightspeed.nvim, https://github.com/ggandor/leap.nvim
-- TODO: https://github.com/AckslD/nvim-trevJ.lua/ - for collapsing/expanding oneliners
-- TODO: https://github.com/diepm/vim-rest-console - for replacing postman
-- TODO: https://github.com/bayne/vim-dot-http -- for running curl requests
-- TODO: check in with overloading leader key feature request: https://github.com/justinmk/vim-sneak/issues/298
-- TODO: some bugs, probably not worth keeping
-- use {
--     "https://github.com/gaelph/logsitter.nvim",
--     requires = {{"https://github.com/nvim-treesitter/nvim-treesitter"}},
--     config = function()
--         local logsitter = vim.api.nvim_create_augroup("LogSitter",
--                                                       {clear = true})
--         vim.api.nvim_create_autocmd("FileType", {
--             group = logsitter,
--             pattern = {"javascript", "typescript", "go", "lua"},
--             callback = function()
--                 vim.keymap.set("n", "<leader>l",
--                                function()
--                     require("logsitter").log()
--                 end, {buffer = 0})
--             end
--         })
--     end
-- } -- TurboLog for efficient logging
