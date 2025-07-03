--[[
  ██╗     ███████╗██████╗ 
  ██║     ██╔════╝██╔══██╗
  ██║     ███████╗██████╔╝
  ██║     ╚════██║██╔═══╝ 
  ███████╗███████║██║     
  ╚══════╝╚══════╝╚═╝     
  
  Language Server Protocol Configuration
  Kali Linux + Hyprland + NeoVim
  Production-Ready LSP Setup with Mason.nvim
--]]

local M = {}

-- ═══════════════════════════════════════════════════════════════════════════════
-- DIAGNOSTIC CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════════

local function setup_diagnostics()
  local signs = {
    { name = "DiagnosticSignError", text = "✘" },
    { name = "DiagnosticSignWarn", text = "⚠" },
    { name = "DiagnosticSignHint", text = "󰌶" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = {
      enabled = true,
      source = "if_many",
      prefix = "●",
      spacing = 4,
    },
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
      format = function(diagnostic)
        local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
        return string.format("%s %s", code, diagnostic.message)
      end,
    },
  })
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- LSP KEYBINDINGS
-- ═══════════════════════════════════════════════════════════════════════════════

local function setup_keybindings(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  
  -- Navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  
  -- Documentation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  
  -- Code actions
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
  
  -- Formatting
  if client.supports_method("textDocument/formatting") then
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
  
  -- Diagnostics
  vim.keymap.set("n", "<leader>xx", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
  
  -- Workspace
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  
  -- Cyber ops specific bindings
  vim.keymap.set("n", "<leader>cs", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  
  vim.keymap.set("n", "<leader>cl", function()
    vim.lsp.codelens.run()
  end, opts)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- LSP CAPABILITIES
-- ═══════════════════════════════════════════════════════════════════════════════

local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  
  -- nvim-cmp supports additional completion capabilities
  local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  
  -- Enable folding capability
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  
  return capabilities
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- LSP ON_ATTACH FUNCTION
-- ═══════════════════════════════════════════════════════════════════════════════

local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  
  -- Setup keybindings
  setup_keybindings(client, bufnr)
  
  -- Enable inlay hints if supported
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
  
  -- Highlight references of the word under cursor
  if client.supports_method("textDocument/documentHighlight") then
    local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })
    
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })
  end
  
  -- Auto-format on save
  if client.supports_method("textDocument/formatting") then
    local format_augroup = vim.api.nvim_create_augroup("lsp-format", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      group = format_augroup,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
  
  -- Print LSP client attach info
  vim.notify(string.format("LSP [%s] attached to buffer %d", client.name, bufnr), vim.log.levels.INFO)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- LSP SERVER CONFIGURATIONS
-- ═══════════════════════════════════════════════════════════════════════════════

local function get_server_configs()
  local capabilities = get_capabilities()
  
  return {
    -- Lua Language Server
    lua_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = { "vim", "use", "describe", "it", "before_each", "after_each" },
          },
          workspace = {
            library = {
              vim.api.nvim_get_runtime_file("", true),
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
          format = {
            enable = false,
          },
          hint = {
            enable = true,
            arrayIndex = "Disable",
            await = true,
            paramName = "All",
            paramType = true,
            semicolon = "Disable",
            setType = false,
          },
        },
      },
    },
    
    -- TypeScript/JavaScript
    tsserver = {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Disable tsserver formatting in favor of prettier
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
    
    -- Python
    pyright = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "basic",
          },
        },
      },
    },
    
    -- Rust
    rust_analyzer = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            buildScripts = {
              enable = true,
            },
            features = "all",
          },
          procMacro = {
            enable = true,
          },
          diagnostics = {
            enable = true,
            experimental = {
              enable = true,
            },
          },
          inlayHints = {
            bindingModeHints = {
              enable = false,
            },
            chainingHints = {
              enable = true,
            },
            closingBraceHints = {
              enable = true,
              minLines = 25,
            },
            closureReturnTypeHints = {
              enable = "never",
            },
            lifetimeElisionHints = {
              enable = "never",
              useParameterNames = false,
            },
            maxLength = 25,
            parameterHints = {
              enable = true,
            },
            reborrowHints = {
              enable = "never",
            },
            renderColons = true,
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedConstructor = false,
            },
          },
        },
      },
    },
    
    -- Go
    gopls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    },
    
    -- C/C++
    clangd = {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    },
    
    -- Bash
    bashls = {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "sh", "bash", "zsh" },
    },
    
    -- JSON
    jsonls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        json = {
          schemas = {},
          validate = { enable = true },
        },
      },
    },
    
    -- YAML
    yamlls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = {},
        },
      },
    },
    
    -- HTML
    html = {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "htmldjango" },
    },
    
    -- CSS
    cssls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    },
    
    -- Tailwind CSS
    tailwindcss = {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    },
    
    -- Markdown
    marksman = {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "markdown", "md" },
    },
    
    -- Docker
    dockerls = {
      capabilities = capabilities,
      on_attach = on_attach,
    },
    
    -- SQL
    sqlls = {
      capabilities = capabilities,
      on_attach = on_attach,
    },
  }
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- MASON SETUP
-- ═══════════════════════════════════════════════════════════════════════════════

local function setup_mason()
  local mason_ok, mason = pcall(require, "mason")
  if not mason_ok then
    vim.notify("Mason not found!", vim.log.levels.ERROR)
    return
  end
  
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "rounded",
      width = 0.8,
      height = 0.8,
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    registries = {
      "github:mason-org/mason-registry",
    },
  })
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- MASON-LSPCONFIG SETUP
-- ═══════════════════════════════════════════════════════════════════════════════

local function setup_mason_lspconfig()
  local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not mason_lspconfig_ok then
    vim.notify("Mason-lspconfig not found!", vim.log.levels.ERROR)
    return
  end
  
  local servers = {
    "lua_ls",
    "tsserver",
    "pyright",
    "rust_analyzer",
    "gopls",
    "clangd",
    "bashls",
    "jsonls",
    "yamlls",
    "html",
    "cssls",
    "tailwindcss",
    "marksman",
    "dockerls",
    "sqlls",
  }
  
  mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
  })
  
  -- Setup handlers
  mason_lspconfig.setup_handlers({
    -- Default handler
    function(server_name)
      local lspconfig = require("lspconfig")
      local server_configs = get_server_configs()
      
      if server_configs[server_name] then
        lspconfig[server_name].setup(server_configs[server_name])
      else
        -- Fallback configuration
        lspconfig[server_name].setup({
          capabilities = get_capabilities(),
          on_attach = on_attach,
        })
      end
    end,
  })
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- ADDITIONAL TOOLS SETUP
-- ═══════════════════════════════════════════════════════════════════════════════

local function setup_additional_tools()
  local mason_tool_installer_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
  if mason_tool_installer_ok then
    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters
        "prettier",
        "stylua",
        "black",
        "isort",
        "rustfmt",
        "gofmt",
        "shfmt",
        
        -- Linters
        "eslint_d",
        "pylint",
        "flake8",
        "shellcheck",
        "hadolint",
        
        -- DAP
        "debugpy",
        "node2",
        "go-debug-adapter",
        "codelldb",
      },
      auto_update = true,
      run_on_start = false,
    })
  end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- MAIN SETUP FUNCTION
-- ═══════════════════════════════════════════════════════════════════════════════

function M.setup()
  -- Setup diagnostics first
  setup_diagnostics()
  
  -- Setup Mason
  setup_mason()
  
  -- Setup Mason-lspconfig
  setup_mason_lspconfig()
  
  -- Setup additional tools
  setup_additional_tools()
  
  -- Global LSP settings
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
  
  -- Success notification
  vim.notify("🔥 LSP Configuration Loaded Successfully! 🔥", vim.log.levels.INFO)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- LAZY.NVIM PLUGIN SPECIFICATIONS
-- ═══════════════════════════════════════════════════════════════════════════════

M.plugins = {
  -- Mason.nvim
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  
  -- Mason-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {},
  },
  
  -- Mason-tool-installer
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    opts = {},
  },
  
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
    },
    config = function()
      M.setup()
    end,
  },
  
  -- JSON/YAML schemas
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  
  -- Additional LSP UI improvements
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  
  -- LSP signature help
  {
    "ray-x/lsp_signature.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      floating_window = true,
      hint_enable = true,
      hint_prefix = "🔥 ",
      hint_scheme = "String",
      use_lspsaga = false,
      hi_parameter = "Search",
      max_height = 12,
      max_width = 120,
      handler_opts = {
        border = "rounded",
      },
    },
  },
}

return M 