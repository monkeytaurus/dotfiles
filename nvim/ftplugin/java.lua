local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

-- Setup Workspace
local home = os.getenv "HOME"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local workspace_dir = workspace_path .. project_name

-- Determine OS
local os_config = "linux"
if vim.fn.has "mac" == 1 then
	os_config = "mac"
end

-- Setup Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Setup Testing and Debugging
--[[ local bundles = {} ]]
-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
-- vim.list_extend(
--   bundles,
--   vim.split(
--     vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
--     "\n"
--   )
-- )

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
	capabilities = capabilities,

	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					-- {
					-- 	-- name = "JavaSE-11",
					-- 	-- path = "~/.sdkman/candidates/java/11.0.17-tem",
					-- },
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk/",
					},
				},
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
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				-- settings = {
				-- 	url = "~/.local/share/eclipse/eclipse-java-google-style.xml",
				-- 	profile = "GoogleStyle",
				--
				-- }
				--
				enabled = false,
			},
		},
		signatureHelp = { enabled = true },
		extendedClientCapabilities = extendedClientCapabilities,
	},
}

-- config["on_attach"] = function(client, bufnr)
-- local _, _ = pcall(vim.lsp.codelens.refresh)
-- require("jdtls").setup_dap({ hotcodereplace = "auto" })
-- require("lvim.lsp").on_attach(client, bufnr)
--   local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
--   if status_ok then
--     jdtls_dap.setup_dap_main_class_configs()
--   end
-- end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})


require("jdtls").start_or_attach(config)





-- local jdtls_ok, jdtls = pcall(require, "jdtls")
--
-- if not jdtls_ok then
-- 	return
-- end
--
-- local has_cmp, cmp = pcall(require, "cmp")
--
-- if not has_cmp then
-- 	return
-- end
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--
-- local extendedClientCapabilities = jdtls.extendedClientCapabilities
-- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
--
-- local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
--
-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--
-- -- Find root directory
-- -- Need root files for LSP to run
-- local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
-- local root_dir = require("jdtls.setup").find_root(root_markers)
-- if root_dir == "" then
-- 	return
-- end
--
-- capabilities = capabilities
--
-- local config = {
-- 	-- The command that starts the language server
-- 	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
-- 	cmd = {
--
-- 		-- 💀
-- 		"java", -- or '/path/to/java17_or_newer/bin/java'
-- 		-- depends on if `java` is in your $PATH env variable and if it points to the right version.
--
-- 		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
-- 		"-Dosgi.bundles.defaultStartLevel=4",
-- 		"-Declipse.product=org.eclipse.jdt.ls.core.product",
-- 		"-Dlog.protocol=true",
-- 		"-Dlog.level=ALL",
-- 		"-Xms1g",
-- 		"--add-modules=ALL-SYSTEM",
-- 		"--add-opens",
-- 		"java.base/java.util=ALL-UNNAMED",
-- 		"--add-opens",
-- 		"java.base/java.lang=ALL-UNNAMED",
--
-- 		-- 💀
-- 		-- "-jar","$HOME/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
-- 		"-jar",
-- 		vim.fn.expand(
-- 		"~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"),
--
-- 		-- "/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar",
-- 		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
-- 		-- Must point to the                                                     Change this to
-- 		-- eclipse.jdt.ls installation                                           the actual version
--
-- 		-- 💀
-- 		"-configuration", "~/.local/share/nvim/mason/packages/jdtls/config_linux/",
--
-- 		-- "/path/to/jdtls_install_location/config_SYSTEM",
-- 		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
-- 		-- Must point to the                      Change to one of `linux`, `win` or `mac`
-- 		-- eclipse.jdt.ls installation            Depending on your system.
--
-- 		-- 💀
-- 		-- See `data directory configuration` section in the README
-- 		"-data",
-- 		vim.fn.expand("~/.cache/jdtls-workspace/") .. workspace_dir,
-- 	},
--
-- 	-- 💀
-- 	-- This is the default if not provided, you can remove it. Or adjust as needed.
-- 	-- One dedicated LSP server & client will be started per unique root_dir
-- 	root_dir = root_dir,
--
-- 	-- Here you can configure eclipse.jdt.ls specific settings
-- 	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- 	-- for a list of options
-- 	settings = {
-- 		java = {
-- 			signatureHelp = { enabled = true },
-- 			-- Jet brains own Java Decompiler (fernflower1)
-- 			contentProvider = { preferred = "fernflower" },
-- 			extendedClientCapabilities = extendedClientCapabilities,
-- 			eclipse = {
-- 				downloadSources = true,
-- 			},
-- 			configuration = {
-- 				-- Specifies how modifications on build files update the Java classpath/configuration
-- 				-- interactive asks about updating on every modification
-- 				updateBuildConfiguration = "interactive",
-- 			},
-- 			-- Enable/disable eager download of Maven source artifacts
-- 			maven = {
-- 				downloadSources = true,
-- 			},
-- 			implementationsCodeLens = {
-- 				enabled = true,
-- 			},
-- 			referencesCodeLens = {
-- 				enabled = true,
-- 			},
-- 			references = {
-- 				includeDecompiledSources = true,
-- 			},
-- 			inlayHints = {
-- 				parameterNames = {
-- 					enabled = "all", -- literals, all, none
-- 				},
-- 			},
-- 			format = {
-- 				enabled = true,
-- 				settings = {
-- 					url = "$HOME/.local/share/eclipse/eclipse-java-google-style.xml",
-- 					profile = "GoogleStyle",
-- 				}
-- 			},
-- 		},
-- 		completion = {
-- 			-- variables or methods that belong to the class itself
-- 			favoriteStaticMembers = {
-- 				"org.hamcrest.MatcherAssert.assertThat",
-- 				"org.hamcrest.Matchers.*",
-- 				"org.hamcrest.CoreMatchers.*",
-- 				"org.junit.jupiter.api.Assertions.*",
-- 				"java.util.Objects.requireNonNull",
-- 				"java.util.Objects.requireNonNullElse",
-- 				"org.mockito.Mockito.*",
-- 			},
-- 		},
-- 		sources = {
-- 			organizeImports = {
-- 				-- Specifies the number of imports added before a star-import declaration is used, default is 99.
-- 				starThreshold = 9999,
-- 				-- Specifies the number of static imports added before a star-import declaration is used
-- 				staticStarThreshold = 9999,
-- 			},
-- 		},
-- 		codeGeneration = {
-- 			toString = {
-- 				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
-- 			},
-- 			useBlocks = true,
-- 		},
-- 	},
--
-- 	-- Language server `initializationOptions`
-- 	-- You need to extend the `bundles` with paths to jar files
-- 	-- if you want to use additional eclipse.jdt.ls plugins.
-- 	--
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require("jdtls").start_or_attach(config)
