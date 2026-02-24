require("nvchad.configs.lspconfig").defaults()

-- read :h vim.lsp.config for changing options of lsp servers
-- -- load defaults i.e lua_lspls
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = vim.lsp.config

local on_attach = function(client)
  -- Enable keymaps and capabilities
  local map = vim.keymap.set

  -- Navigation
  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
  map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to definition" })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover over word" })

  -- Workspace
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add a workspace" })
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove the workspace" })
  map("n", "<leader>wl", function()
    endprint(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "Print workspaces list" })

  -- Code Actions
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

  -- Diagnostics
  map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

  -- Signature Help (triggered automatically during typing)
  map("i", "<leader>s", vim.lsp.buf.signature_help, { desc = "Show code signature" })

  -- Symbols
  map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document symbol" })
  map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Workspace symbol" })

  -- Inlay Hints (requires LSP support)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end
end

-- EXAMPLE
local servers = { "html", "cssls" }

-- lsps with default config
-- ---
for _, lsp in pairs(servers) do
  lspconfig(lsp, {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
    filetypes = { "html", "htmx", "xml" },
  })
end

-- ---
-- Lua lsp configuration
lspconfig("lua_ls", {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  filetypes = { "lua" },
})

-- Python Lsp configuration
lspconfig("pyright", {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  filetype = { "python" },
})

lspconfig("clangd", {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  filetype = { "c", "cpp", "h", "objc", "objcpp", "cuda", "proto" },
  cmd = { "clangd", "--clang-tidy", "--compile-commands-dir='.'" }, -- Use C17 standard
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
})

lspconfig("ts_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = require("lspconfig.util").root_pattern("next.config.js", "next.config.ts", "package.json", ".git"),
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
      jsxAttributeCompletionStyle = "auto",
    },
    plugins = {
      {
        name = "next",
        location = vim.fn.stdpath "data" .. "/mason/packages/nextls",
      },
    },
  },
})

lspconfig("eslint", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  settings = {
    packageManager = "npm",
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
    format = true,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "auto",
    },
  },
})

lspconfig("tailwindcss", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  init_options = {
    userLanguages = {
      typescript = "javascript",
      typescriptreact = "javascript",
    },
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
})

--- Java Lsp Configuration
lspconfig("jdtls", {
  on_attach = on_attach,
  capabilities = capabilities,
  lazy = false,
  root_dir = require("lspconfig.util").root_pattern("pom.xml", "gradle.build", ".git"),
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-Xmx2G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(vim.fn.stdpath "data" .. "/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"), -- Wildcard for version
    "-configuration",
    vim.fn.stdpath "data" .. "/mason/packages/jdtls/config_linux", -- Changed from config_win to config_linux
    "-data",
    vim.fn.stdpath "data" .. "/jdtls_workspaces/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
  },
  settings = {
    java = {
      home = "/usr/lib/jvm/java-21-openjdk", -- Typical Fedora JDK path (adjust version as needed)
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
  },
  init_options = {
    bundles = {},
  },
})

lspconfig("intelephense", {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  filetypes = { "php" },
  settings = {
    intelephense = {
      environment = {
        phpVersion = "8.2",
        includePath = { "vendor" },
      },
      files = {
        maxSize = 5000000,
      },
    },
  },
})
