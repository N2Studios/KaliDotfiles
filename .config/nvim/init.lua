--[[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
  
  Cyber Ops & Elite Dev Configuration
  Kali Linux + Hyprland + NeoVim
  Dark Theme: Jet Black + Neon Orange
--]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- BOOTSTRAP LAZY.NVIM PLUGIN MANAGER
-- ═══════════════════════════════════════════════════════════════════════════════

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ═══════════════════════════════════════════════════════════════════════════════
-- CORE NEOVIM SETTINGS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Set leader key before lazy loading
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- Indentation & tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Performance & UI
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.showmode = false

-- Enable transparent background for Wayland/Hyprland
vim.opt.pumblend = 10
vim.opt.winblend = 10

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Backup & swap files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- ═══════════════════════════════════════════════════════════════════════════════
-- PLUGIN SPECIFICATIONS
-- ═══════════════════════════════════════════════════════════════════════════════

require("lazy").setup({
  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ COLORSCHEME & UI                                                        │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
            text = "#ffffff",
            subtext1 = "#bac2de",
            subtext0 = "#a6adc8",
            overlay2 = "#9399b2",
            overlay1 = "#7f849c",
            overlay0 = "#6c7086",
            surface2 = "#585b70",
            surface1 = "#45475a",
            surface0 = "#313244",
            peach = "#ff8800",
            yellow = "#ffaa00",
            green = "#00ff88",
            teal = "#00ffaa",
            sky = "#00aaff",
            sapphire = "#0088ff",
            blue = "#0066ff",
            lavender = "#8888ff",
            mauve = "#aa88ff",
            red = "#ff4444",
            maroon = "#ff6666",
            pink = "#ff88aa",
            flamingo = "#ffaacc",
            rosewater = "#ffccdd",
          },
        },
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
          treesitter = true,
          mason = true,
          which_key = true,
          lsp_trouble = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ STATUSLINE                                                              │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {"filename"},
          lualine_x = {"location"},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ TREESITTER - SYNTAX HIGHLIGHTING                                       │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query",
          "python", "javascript", "typescript", "tsx",
          "cpp", "c", "rust", "go",
          "html", "css", "json", "yaml", "toml",
          "bash", "fish", "dockerfile", "sql",
          "markdown", "markdown_inline", "regex",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ LSP CONFIGURATION - ENHANCED PRODUCTION SETUP                          │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  -- Mason.nvim - LSP installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "pyright", "tsserver", "rust_analyzer", "clangd",
          "gopls", "bashls", "yamlls", "jsonls", "html", "cssls"
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Load the full LSP configuration
      require("plugins.lsp").setup()
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ AUTOCOMPLETION                                                          │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ TELESCOPE - FUZZY FINDER                                                │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = require("telescope.actions").cycle_history_next,
              ["<C-p>"] = require("telescope.actions").cycle_history_prev,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "*.pyc",
            "__pycache__",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      
      require("telescope").load_extension("fzf")
      
      -- Telescope keybindings
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {})
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {})
      vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {})
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {})
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ FILE EXPLORER                                                           │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            glyphs = {
              default = "",
              symlink = "",
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
      })
      
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ GIT INTEGRATION                                                         │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1
        },
      })
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>g", ":LazyGit<CR>", { silent = true })
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ TERMINAL INTEGRATION - SIERRA AI CLI + CYBER OPS                       │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "rounded",
          winblend = 20,
          width = 0.9,
          height = 0.8,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      
      -- ═══════════════════════════════════════════════════════════════════════
      -- SIERRA AI CLI TERMINAL INTEGRATION
      -- ═══════════════════════════════════════════════════════════════════════
      
      local Terminal = require("toggleterm.terminal").Terminal
      
      -- Sierra AI CLI Terminal (ID: 1)
      local sierra_terminal = Terminal:new({
        cmd = "sierra",
        count = 1,
        direction = "float",
        float_opts = {
          border = "rounded",
          winblend = 20,
          width = 0.9,
          height = 0.8,
          row = 0.1,
          col = 0.05,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          -- Sierra-specific keybindings
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc><Esc>", [[<C-\><C-n>:close<CR>]], {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })
      
      -- Vertical Logs Terminal (ID: 2)
      local vertical_logs_terminal = Terminal:new({
        cmd = "zsh",
        count = 2,
        direction = "float",
        float_opts = {
          border = "rounded",
          winblend = 20,
          width = 0.9,
          height = 0.8,
          row = 0.1,
          col = 0.05,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          -- Auto-execute common log commands
          vim.api.nvim_feedkeys("# Vertical Intelligence Logs\n", "n", false)
          vim.api.nvim_feedkeys("# Use: tail -f /var/log/system.log | grep -i vertical\n", "n", false)
          vim.api.nvim_feedkeys("clear\n", "n", false)
          -- Vertical logs keybindings
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc><Esc>", [[<C-\><C-n>:close<CR>]], {noremap = true, silent = true})
        end,
      })
      
      -- Shell Terminal (ID: 3)
      local shell_terminal = Terminal:new({
        cmd = "zsh",
        count = 3,
        direction = "float",
        float_opts = {
          border = "rounded",
          winblend = 20,
          width = 0.9,
          height = 0.8,
          row = 0.1,
          col = 0.05,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          -- Shell keybindings
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc><Esc>", [[<C-\><C-n>:close<CR>]], {noremap = true, silent = true})
        end,
      })
      
      -- ═══════════════════════════════════════════════════════════════════════
      -- TERMINAL TOGGLE FUNCTIONS
      -- ═══════════════════════════════════════════════════════════════════════
      
      function _sierra_toggle()
        sierra_terminal:toggle()
      end
      
      function _vertical_logs_toggle()
        vertical_logs_terminal:toggle()
      end
      
      function _shell_toggle()
        shell_terminal:toggle()
      end
      
      -- ═══════════════════════════════════════════════════════════════════════
      -- CYBER OPS KEYBINDINGS
      -- ═══════════════════════════════════════════════════════════════════════
      
      -- Primary Sierra AI CLI Terminal
      vim.keymap.set("n", "<leader>tt", "<cmd>lua _sierra_toggle()<CR>", { 
        silent = true, 
        desc = "Toggle Sierra AI CLI Terminal" 
      })
      
      -- Vertical Intelligence Logs Terminal
      vim.keymap.set("n", "<leader>tl", "<cmd>lua _vertical_logs_toggle()<CR>", { 
        silent = true, 
        desc = "Toggle Vertical Logs Terminal" 
      })
      
      -- Shell Terminal
      vim.keymap.set("n", "<leader>ts", "<cmd>lua _shell_toggle()<CR>", { 
        silent = true, 
        desc = "Toggle Shell Terminal" 
      })
      
      -- Additional terminal options
      vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { 
        silent = true, 
        desc = "Toggle Float Terminal" 
      })
      vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { 
        silent = true, 
        desc = "Toggle Vertical Terminal" 
      })
      vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { 
        silent = true, 
        desc = "Toggle Horizontal Terminal" 
      })
      
      -- ═══════════════════════════════════════════════════════════════════════
      -- GLOBAL TERMINAL KEYBINDINGS
      -- ═══════════════════════════════════════════════════════════════════════
      
      -- Terminal mode escape (double escape to normal mode and close)
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { silent = true })
      
      -- Quick exit from any terminal
      vim.keymap.set("t", "<C-q>", [[<C-\><C-n>:close<CR>]], { silent = true })
      
      -- Terminal navigation
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { silent = true })
      vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { silent = true })
      vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { silent = true })
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { silent = true })
      
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ WHICH-KEY - KEYBINDING HINTS                                           │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
      })
      
      -- Register key mappings
      require("which-key").register({
        ["<leader>f"] = { name = "Find" },
        ["<leader>g"] = { name = "Git" },
        ["<leader>t"] = { 
          name = "Terminal",
          t = "Sierra AI CLI",
          l = "Vertical Logs",
          s = "Shell Terminal",
          f = "Float Terminal",
          v = "Vertical Terminal",
          h = "Horizontal Terminal",
        },
        ["<leader>c"] = { 
          name = "Code",
          a = "Code Action",
          l = "Code Lens",
          s = "Workspace Symbol",
        },
        ["<leader>x"] = { name = "Diagnostics" },
        ["<leader>w"] = { 
          name = "Workspace",
          a = "Add Folder",
          r = "Remove Folder",
          l = "List Folders",
        },
        ["<leader>r"] = "Rename Symbol",
        ["<leader>d"] = "Go to Definition",
        ["<leader>q"] = "Set Loclist",
        ["gd"] = "Go to Definition",
        ["gD"] = "Go to Declaration",
        ["gi"] = "Go to Implementation",
        ["gr"] = "Show References",
        ["gt"] = "Go to Type Definition",
        ["K"] = "Hover Documentation",
        ["[d"] = "Previous Diagnostic",
        ["]d"] = "Next Diagnostic",
      })
      
      vim.keymap.set("n", "<leader>?", function() require("which-key").show() end, { desc = "Which Key" })
    end,
  },

  -- ┌─────────────────────────────────────────────────────────────────────────┐
  -- │ ADDITIONAL UTILITIES                                                    │
  -- └─────────────────────────────────────────────────────────────────────────┘
  
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = {"string", "source"},
          javascript = {"string", "template_string"},
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "vim" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
      
      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA",
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({
        icons = false,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
        signs = {
          error = "error",
          warning = "warn",
          hint = "hint",
          information = "info"
        },
        use_diagnostic_signs = false
      })
      
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true })
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true })
    end,
  },

}, {
  -- Lazy.nvim options
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "catppuccin" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- CUSTOM KEYBINDINGS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Save file
vim.keymap.set("n", "<leader>fs", ":w<CR>", { silent = true, desc = "Save file" })

-- Clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { silent = true, desc = "Clear search highlights" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { silent = true })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", { silent = true })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", { silent = true })

-- Better paste
vim.keymap.set("v", "p", '"_dP', { silent = true })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- ═══════════════════════════════════════════════════════════════════════════════
-- AUTOCOMMANDS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto-format on save",
  group = vim.api.nvim_create_augroup("auto-format", { clear = true }),
  callback = function()
    if vim.lsp.buf.format then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close certain filetypes with q",
  group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- ═══════════════════════════════════════════════════════════════════════════════
-- CYBER OPS SPECIFIC CONFIGURATIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Custom commands for cyber ops workflows
vim.api.nvim_create_user_command("CyberMode", function()
  vim.cmd("set number!")
  vim.cmd("set relativenumber!")
  vim.cmd("set cursorline!")
  vim.notify("Cyber stealth mode toggled", vim.log.levels.INFO)
end, {})

-- Quick access to common cyber ops directories
vim.keymap.set("n", "<leader>cp", ":Telescope find_files cwd=~/Projects<CR>", { silent = true, desc = "Find in Projects" })
vim.keymap.set("n", "<leader>cs", ":Telescope find_files cwd=~/Scripts<CR>", { silent = true, desc = "Find in Scripts" })
vim.keymap.set("n", "<leader>cc", ":Telescope find_files cwd=~/.config<CR>", { silent = true, desc = "Find in Config" })

-- Quick terminal commands
vim.keymap.set("n", "<leader>th", ":ToggleTerm cmd='htop'<CR>", { silent = true, desc = "System Monitor" })
vim.keymap.set("n", "<leader>tn", ":ToggleTerm cmd='nmcli device wifi'<CR>", { silent = true, desc = "Network Info" })

-- Print success message
vim.notify("🔥 Cyber Ops NeoVim Configuration Loaded Successfully! 🔥", vim.log.levels.INFO) 