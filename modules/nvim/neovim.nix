{
  unstable,
  config,
  lib,
  user,
  ...
}:
with lib; let
  autosemicolon = unstable.vimUtils.buildVimPlugin {
    name = "autosemicolon";
    src = unstable.fetchFromGitHub {
      owner = "dr0med4r";
      repo = "autosemicolon";
      rev = "8c339e18691214e1fa8784a26144a7d498116e74";
      sha256 = "sha256-DApFW+UkkHA5kmwNLLWcnmFP9Y6WN0hjQXzTYUSNX+4=";
    };
  };
  configHome = config.xdg.configHome;
  # files to source
  # order is important
  nvim-files = [
    "settings.lua"
    "keybinds.lua"
    "snippets.lua"
    "lsp.lua"
    "mini.lua"
    "treesitter.lua"
    "dap.lua"
    "toggleterm.lua"
    "grammar.lua"
    "bufferline.lua"
    "lualine.lua"
    "toggleterm.lua"
    "trouble.lua"
    "ntree.lua"
    "telescope.lua"
  ];
  cfg = config.home-modules.nvim;
in {
  options.home-modules.nvim = {
    enable = mkEnableOption "enable custom nvim";
    neovide = mkEnableOption "enable neovide";
  };

  config = mkIf cfg.enable {
    xdg.configFile =
      # merges all filenames in nvim-files to attrs like <filename>.source = ./<filename>;
      mergeAttrs
      (listToAttrs (map
        (x:
          nameValuePair "nvim/${x}"
          (listToAttrs (lists.toList (nameValuePair "source" ./${x}))))
        nvim-files))
      {
        "nvim/lua/dr0med4r/utils.lua".source = ./lua/dr0med4r/utils.lua;
        "nvim/ftplugin/java.lua".text = import ./java.lua.nix {
          pkgs = unstable;
          inherit user;
        };
        ".config/clangd/config.yaml".text =
          import ./clangd.nix unstable;
        "nvim/queries/comment/highlights.scm".text = "";
      };

    home = {
      packages = mkIf cfg.neovide [
        (unstable.symlinkJoin {
          name = "neovide";
          paths = [unstable.neovide];
          buildInputs = [unstable.makeWrapper];
          postBuild = ''
            wrapProgram $out/bin/neovide \
            --set NEOVIDE_FORK 0 \
            --unset NEOVIDE_MAXIMIZED \
          '';
        })
      ];
      file.".nvimhack/config.ini".source =
        config.lib.file.mkOutOfStoreSymlink
        "${unstable.jdt-language-server}/share/java/jdtls/config_linux/config.ini";
    };

    programs.neovim = {
      package = unstable.neovim-unwrapped;
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
      extraConfig = with lib; ''
        ${concatStringsSep "\n" (map (fileName: "luafile ${configHome}/nvim/${fileName}") nvim-files)}
      '';
      withNodeJs = true;
      extraPackages = with unstable; [
        ripgrep
        ltex-ls
        texlab
        nodejs
        clang-tools
        nil
        alejandra
        rust-analyzer
        nodePackages_latest.pyright
        lua-language-server
        jdt-language-server
        lldb
        vscode-extensions.vscjava.vscode-java-debug
        vscode-extensions.vscjava.vscode-java-test
      ];

      plugins = with unstable.vimPlugins; let
        # link all treesitter parsers in one directory to reduce length of runtimepath of neovim
        treesitter-all = unstable.symlinkJoin {
          name = "treesitter-all";
          paths = nvim-treesitter.withAllGrammars.dependencies;
        };
      in [
        # appearance
        nvim-web-devicons
        tokyonight-nvim
        indent-blankline-nvim
        treesitter-all
        guess-indent-nvim
        nvim-treesitter-context

        # ui
        nvim-tree-lua
        undotree
        lualine-nvim
        bufferline-nvim
        toggleterm-nvim
        dressing-nvim

        # Telescope
        popup-nvim
        plenary-nvim
        telescope-nvim

        # lsp
        nvim-lspconfig
        rustaceanvim
        flutter-tools-nvim
        nvim-jdtls
        trouble-nvim
        nvim-lightbulb
        neodev-nvim
        autosemicolon
        # remove after nvim 0.10
        playground

        # snippets
        cmp-nvim-lsp
        cmp-nvim-lsp-signature-help
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp
        luasnip
        cmp_luasnip
        friendly-snippets

        # convenience
        mini-nvim

        # Debugger
        nvim-dap
        nvim-dap-ui
      ];
    };
  };
}
