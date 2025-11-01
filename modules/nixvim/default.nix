{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      ignorecase = true;
      smartcase = true;
      clipboard = "unnamedplus";
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;
      termguicolors = true;
    };

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };

    plugins = {
      # === CODING ===
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;

      mini = {
        enable = true;
        modules = {
          pairs = { };
          comment = { };
          ai = { };
        };
      };

      # === EDITOR ===
      neo-tree = {
        enable = true;
        settings = {
        close_if_last_window = true;
        window = {
          width = 30;
          position = "left";
        };
      };
    }; 

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
        };
      };

      which-key = {
        enable = true;
        settings.delay = 300;
      };

      trouble.enable = true;
      flash.enable = true;

      # === FORMATTING ===
      conform-nvim = {
        enable = true;
        settings = {
          formatOnSave = {
            lspFallback = true;
            timeoutMs = 500;
          };
          formattersByFt = {
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
          };
        };
      };

      # === LINTING ===
      lint = {
        enable = true;
        lintersByFt = { };
      };

      # === LSP ===
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          nixd.enable = true;
        };
      };

      # === TREESITTER ===
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # === UI ===
      lualine = {
        enable = true;
        settings.options.theme = "auto";
      };

      bufferline = {
        enable = true;
        settings.options.diagnostics = "nvim_lsp";
      };

      indent-blankline = {
        enable = true;
        settings.scope.enabled = true;
      };

      alpha = {
        enable = true;
        theme = "dashboard";
      };

      web-devicons.enable = true;
      noice.enable = true;
      notify.enable = true;

      # === UTIL ===
      persistence.enable = true;
    };

    extraPackages = with pkgs; [
      stylua
      nixfmt-classic
      lua-language-server
      nixd
      ripgrep
      fd
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle file explorer";
      }
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Toggle diagnostics";
      }
    ];
  };
}