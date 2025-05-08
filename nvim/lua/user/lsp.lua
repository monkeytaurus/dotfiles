local util = require("lspconfig.util")
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }


  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float, opts)
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

-- Emmet

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

lspconfig["pyright"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- Rust
lspconfig["rust_analyzer"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {},
  },
})

-- HTML LSP
lspconfig.html.setup({
  on_attach = on_attach,
  -- Cmd refers to running a server from the command line. It is the command that is used to start up the language server.
  cmd = { "vscode-html-language-server", "--stdio" },
  filtypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
  single_file_support = true,
})

-- C++, C
lspconfig.sourcekit.setup({
  on_attach = on_attach,
  cmd = { "sourcekit-lsp" },
  filetypes = { "c", "cpp" },
})

-- CSS

lspconfig.cssmodules_ls.setup({
  cmd = { "cssmodules-language-server" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  --root_dir = root_pattern("package.json"),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.cssls.setup({
  capabilities = capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = true },
  --root_dir = root_pattern("package.json", ".git"),
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },

    single_file_support = true,
  },
})

lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  cmd = { "emmet-ls", "--stdio" },
  capabilities = capabilities,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
  single_file_support = true,
})


lspconfig.lua_ls.setup({
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  log_level = 2,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true,
})

lspconfig.bashls.setup({
  cmd = { "bash-language-server", "start" },
  cmd_nev = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
  },
  filetypes = { "sh" },
  single_file_support = true,
})

lspconfig.vimls.setup({
  cmd = { "vim-language-server", "--stdio" },
  filetypes = { "vim" },
  init_options = {
    diagnostic = {
      enable = true,
    },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      runtimepath = true,
    },
    isNeovim = true,
    iskeyword = "@,48-57,_,192-255,-#",
    runtimepath = "",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true,
    },
    vimruntime = "",
  },
  single_file_support = true,
})

--


lspconfig.clangd.setup({
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({
        async = true,
      })
    end, { buffer = bufnr })
  end,

  -- cmd = {
  --   "clangd",
  --   "--clang-tidy",
  --   '--fallback-style="{IndentWidth: 4, ContinuationIndentWidth: 4, UseTab: Never}"'     
  -- },
  --

  cmd = {
    "clangd", "--clang-tidy", "--background-index", "--fallback-style=Google"
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac"
    )(fname) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
  end,

  single_file_support = true,
})

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    hostInfo = "neovim"
  }
})

lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    packageManager = "npm"
  },
  root_dir = util.root_pattern(".eslintrc", ".eslintrc.js", "package.json", ".git")
})


