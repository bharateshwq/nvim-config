return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      jdtls = function()
        local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        local lombok_path = jdtls_path .. "/lombok.jar"

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

        local config = {
          cmd = {
            "java",
            "-javaagent:" .. lombok_path,
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar",
            "-configuration", jdtls_path .. "/config_linux", -- or config_mac / config_win
            "-data", workspace_dir,
          },
          root_dir = require("lspconfig.util").root_pattern(".git", "mvnw", "gradlew", "build.gradle", "pom.xml"),
        }

        require("jdtls").start_or_attach(config)
        return true
      end,
    },
  },
}
