{
  pkgs,
  user,
}: let
  spring-extension =
    pkgs.fetchzip
    {
      url = "https://github.com/spring-projects/sts4/releases/download/4.17.2.RELEASE/vscode-spring-boot-1.44.0-RC.2.vsix";
      extension = "zip";
      stripRoot = false;
      sha256 = "09gf4pkxfr5jfy3ykqbrsnpcag7jchx0ikzaaf9qbmlq74pbblnn";
    };
in
  /*
  lua
  */
  ''
    local root_directory = require('jdtls.setup').find_root({'mvnw', 'gradlew'}) or vim.fn.getcwd()
    local bundles = {
      vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar", 1),
      vim.fn.glob("${spring-extension}/extension/jars/io.projectreactor.reactor-core.jar",1),
      vim.fn.glob("${spring-extension}/extension/jars/org.reactivestreams.reactive-streams.jar",1),
      vim.fn.glob("${spring-extension}/extension/jars/jdt-ls-commons.jar",1),
      vim.fn.glob("${spring-extension}/extension/jars/jdt-ls-extension.jar",1),
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar", 1), "\n"))
    local jarfile = vim.fn.glob('${pkgs.jdt-language-server}/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*',1)
    local config = {
      cmd = {

        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', jarfile,

        '-configuration', vim.fn.expand('$HOME/.nvimhack'),

        '-data', vim.fn.expand('$HOME/.cache/jdtls') .. root_directory,
      },
      root_dir = root_directory,
      on_attach = function(client, bufnr)
          require('jdtls').setup_dap( { hotcodereplace = 'auto'})
          require('jdtls.dap').setup_dap_main_class_configs()
        end,
      init_options = {
        bundles = bundles,
      }

    }
    require('jdtls').start_or_attach(config)

    vim.keymap.set('n', '<A-o>', ":lua require'jdtls'.organize_imports()<CR>")
    vim.keymap.set('n', '<leader>xv', ":lua require('jdtls').extract_variable()<CR>")
    vim.keymap.set('x', '<leader>xv', ":lua require('jdtls').extract_variable(true)<CR>")
    vim.keymap.set('n', '<leader>xc', ":lua require('jdtls').extract_constant()<CR>")
    vim.keymap.set('x', '<leader>xc', ":lua require('jdtls').extract_constant(true)<CR>")
    vim.keymap.set('x', '<leader>xm', ":lua require('jdtls').extract_method(true)<CR>")
  ''
