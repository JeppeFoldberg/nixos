{ config, pkgs, ... }:

{
  home.username = "jeppe";
  home.homeDirectory = "/home/jeppe";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor - should probably be changed! 
  # xresources.properties = {
  #   "Xcursor.size" = 24;
  #   "Xft.dpi" = 96;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    neofetch
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    # mtr # A network diagnostic tool
    # iperf3
    # dnsutils  # `dig` + `nslookup`
    # ldns # replacement of `dig`, it provide the command `drill`
    # aria2 # A lightweight multi-protocol & multi-source command-line download utility
    # socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    # ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Jeppe Foldberg";
    userEmail = "Jeppe_05@msn.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = true;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      package.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      hs = "nmcli -a d wifi connect 'Jeppe - iPhone (3)'"; # Short for hotspot! 
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  programs.vim = {
    enable = true;
    settings = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };
  };

  # programs.neovim = 
  # let 
  #   toLua = str: "lua << EOF \n${str}\nEOF\n";
  # in
  # {
    # enable = true;
    # plugins = with pkgs.vimPlugins; [
      # {
        # plugin = nvim-lspconfig # damn fine cup of lsps
        # config = ""
      # }
      # {
        # plugin = comment-nvim # these suckers 
        # config = tolua "require(\"Comment\").setup()";
      # }
      # {
        # plugin = lazydev-nvim # reload config and ui
        # config = ""
      # }
      # {
        # plugin = telescope-nvim # quickly find files 
        # config = ""
   #    }
      # {
#         plugin = nvim-cmp # tab-complete plugin
        # config = ""
      # }
      # {
        # plugin = lualine-nvim
        # config = ""
      # }

      # (nvim-treesitter.withplugins (p: [
        # p.tree-sitter-nix
        # p.tree-sitter-bash
        # p.tree-sitter-lua
        # p.tree-sitter-rust
      # ]));

      # telescope-fzf-native-nvim
      # vim-nix
   #  ];
  #   aliases to swap out vim everywhere - enable when ready 
    # viAlias = true;
    # vimAlias = true;
    # vimdiffAlias = true;
 #  };

  programs.wofi = {
    enable = true;
    settings = {
      height = 350;
      width = 500;
    };
    style = ( builtins.readFile ./styles/wofi-macchiato.css );
  };

  programs.waybar = {
    enable = true;
    style = ( builtins.readFile ./styles/waybar-macchiato.css );
    settings = ( builtins.fromJSON ( builtins.readFile ./dotfiles/waybar_config ));
  };

  # services! 
  # gammastep is a automatic blue light filter
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 55.7;
    longitude = 12.6;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
