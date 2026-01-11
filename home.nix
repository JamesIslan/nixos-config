{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ./scripts.nix 
    inputs.zen-browser.homeModules.twilight 
  ];
  
  home.username = "jamesislan";
  home.homeDirectory = "/home/jamesislan";
  
  home.packages = with pkgs; [
  	atool
  	kitty
  	jellyfin-media-player
  	# typora # Removed by now
    gopeed
    motrix
  	jdk
  	maven
  	affine
  	httpie
  	yt-dlp
  	syncthing
  	# prowlarr
  	nmap
  	wget
  	ffmpeg-full
  	xsane
  	unrar
  	ethtool
  	obsidian
  	smartmontools
  	gsmartcontrol
  	# obs-studio
  	gedit
  	hplip
  	anki-bin
  	handbrake
  	discord
  	obsidian
  	spotify
  	xournalpp
  	digikam
    # gnomeExtensions.pop-shell
    # gnomeExtensions.tiling-shell
    gnomeExtensions.forge
    pop-launcher
    # gnomeExtensions.focus-changer
  	# bottles
  	qbittorrent
  	shotwell
  	pdfgrep
  	# xnviewmp
	# ...
  	gparted
  	# nufraw
  	nufraw-thumbnailer
  	# ghostty
  	# git
    # git-crypt
    gnupg1
  	nodejs_24
  	pinta
  	libreoffice-qt6-fresh
  	pavucontrol
  	# xflux # Deprecated
  	vlc
    # mpv
    # mpvScripts.autosubsync-mpv
    # mpvScripts.modernz
  	syncplay
  	mkvtoolnix
  	kooha
  	chromium
  	wineWowPackages.stable
  	winetricks
  	gnome-tweaks
  	github-desktop
  	texstudio
  	gnome-boxes
  	elan
  	haskellPackages.ghc
  	gcc
  	gnumeric
  	haskellPackages.stack
  	haskellPackages.haskell-language-server
  	texliveFull
  	minicom
  	# kitty
  	waybar
  	wallust
  	hyprcursor
  	swaynotificationcenter
  	# rofi
  	vicinae
  	hyprlock
  	hyprsome
  	pyprland
  	hypridle
  	brightnessctl
  	pamixer
  	libnotify
  	xfce.thunar
  	hyprshot
  	cliphist
  	wl-clipboard
  	#xdg-desktop-portal
  	# xdg-desktop-portal-gtk
	ashell
	adw-gtk3
  	#inputs.ashell.packages.${pkgs.system}.default
  	(python3.withPackages (ps: [
  	    ps.pip
  	    ps.pygments
  	    ps.jupyter
  	    ps.notebook
  	    ps.ipykernel
  	    ps.subliminal
  	]))
  ];

  # services.tailscale.enable = true;  
  programs = {
  	bash.enable = true;
  	obs-studio.enable = true;
  	zen-browser.enable = true;
  	mpv = {
  		enable = true;
  		scripts = [ 
            pkgs.mpvScripts.autosub
            pkgs.mpvScripts.autosubsync-mpv
            pkgs.mpvScripts.modernz
        ];
       config = {
       	    "script-opts-append" = "autosub-languages=pt-BR,pt";
       	    sid = "no";
       	    osd-font-size = 30;
       };
  	};
  	git = {
  		enable = true;
  		settings = {
 			user.name = "Joamerson Islan";
  	    	user.email = "joamersonislan38@gmail.com";
		    credential.helper = "store";	
  		};
  	};
    ghostty = {
      enable = true;
      settings = {
        "keybind" = "ctrl+backspace=text:\\x17";
        "font-family" = "CartographCF Nerd Font";
        "font-size" = 14;
        "theme" = "Dark Modern";
        "window-padding-x" = 10;
        "window-padding-y" = 10;
      };
    };
  	zsh = {
  		enable = true;
  		# enableCompletion = true;
  		# autosuggestions.enable = true;
  		# syntaxHighlightling.enable = true;
  		# histSize = 1000;
  		oh-my-zsh = {
  			enable = true;
  			theme = "jispwoso";
  			plugins = [ "git" "sudo" "z" ];
  		};
  		# initContent = "OIIIII";
  	};

  	vscode = {
  	    enable = true;
  	    #package = pkgs.vscode.fhsWithPackages (ps: with ps; [ pico-sdk picotool libusb1 ]);
        package = pkgs.vscode;
  	};
  	

  	micro = {
  	    enable = true;
  	    settings = {
			"clipboard" = "terminal";
		    "cursor" = "underline";
		    "blinkingcursor" = false;
		    "colorscheme" = "monokai";
		    "autoindent" = false;
            "tabstospaces" = true;
            "tabsize" = 2;
            "rmtrailingws" = true;
            
			keybindings = {
			  "F4" = "setall autoindent off; setall tabstospaces on";
			  "F5" = "setall autoindent on";
			};
  	  };
  	};
  };
  
  dconf.settings = {
      "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "forge@jmmaranan.com"
            # "pop-shell@system76.com"
            # "tilingshell@ferrarodomenico.com"
            # "focus-changer@heartmire"
          ];
      };
      "org/gnome/shell/extensions/forge" = {
         focus-border-toggle = false;
      };
      "org/gnome/shell/extensions/forge/keybindings" = {
         window-focus-left  = ["<Super>Left"];
         window-focus-right = ["<Super>Right"];
         window-focus-up    = ["<Super>Up"];
         window-focus-down  = ["<Super>Down"];
         window-resize-left  = ["<Super><Shift>Left"];
         window-resize-right = ["<Super><Shift>Right"];
         window-resize-right-increase = ["<Super><Shift>Right"];
         window-resize-right-decrease = ["<Super><Shift>Left"];
         window-resize-bottom-increase = ["<Super><Shift>Up"];
         window-resize-bottom-decrease = ["<Super><Shift>Down"];
         window-resize-left-increase   = [];
         window-resize-left-decrease   = [];
         window-resize-top-increase    = [];
         window-resize-top-decrease    = [];
      };
     
      # "org/gnome/shell/extensions/pop-shell" = {
      #     tile-by-default = true;
      #     show-title = false; # Hide title bars for cleaner look
      #     gap-inner = 0;
      #     gap-outer = 0;
      #     active-hint = false;
      #     # hint-color-rgba = "rgb(113, 198, 241)"; # Cyan color
      #     tile-move-left = ["<Super><Control>left"];
      #     tile-move-right = ["<Super><Control>right"];
      #     tile-move-up = ["<Super><Control>up"];
      #     tile-move-down = ["<Super><Control>down"];
      # };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/wm/preferences" = {
          focus-mode = "sloppy";
          button-layout = ":minimize,maximize,close";
      };

      "org/gnome/desktop/wm/keybindings" = {
            minimize = [];
            maximize = [];
            unmaximize = [];
            toggle-maximized = ["<Super><Control>f"];
            toggle-fullscreen = ["<Super><Shift>f"];
            close = ["<Alt>q"];
            begin-move = [];
            begin-resize = [];
            move-to-monitor-left = [];
            move-to-monitor-right = [];
            move-to-monitor-up = [];
            move-to-monitor-down = [];
            switch-to-workspace-left = [];
            switch-to-workspace-right = [];
            switch-to-workspace-up = [];
            switch-to-workspace-down = [];
            move-to-workspace-left = [];
            move-to-workspace-right = [];
            move-to-workspace-up = [];
            move-to-workspace-down = [];
      };
      
      "org/gnome/mutter/keybindings" = {
            toggle-tiled-left = [];
            toggle-tiled-right = [];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
          home = [ "<Super>e" ];
      };
      
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>t";
          command = "ghostty";
          name = "Open Terminal";
      };
  };

  gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
  };
  
  xdg.userDirs = {
      enable = true;
      createDirectories = true;
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      videos = "$HOME/Videos";
      pictures = "$HOME/Pictures";
  };

  xdg.dataFile."jellyfinmediaplayer/mpv.conf".text = ''
      # Cache up to 500MB (in Kilobytes)
      demuxer-max-bytes=500000KiB
      
      # Attempt to buffer up to 5 minutes (300 seconds)
      cache-secs=300
  '';
#   wayland.windowManager.hyprland = {
#       enable = true;
#       settings = {
#         # Configuração de Monitores (Auto)
#         monitor = [ ",preferred,auto,1" ];
#         exec-once = [
#         	"chromium"
#         	"ghostty"
#         	"vicinae server"
#         	"ashell"
#         ];
# 
#         animations = {
#         	enabled = true;
#         	bezier = [
#         		"minhaCurva, 0.05, 0.9, 0.1, 1.05"
#         	];
#         	animation = [
#    	           "windowsIn, 1, 3, minhaCurva, popin 80%"
#    	           "windowsOut, 1, 3, minhaCurva, popin 80%"
#    	           "workspaces, 1, 3, default"
#         	];
#         };
# 
#         input = {
#         	kb_layout = "br";
#         	touchpad = {
#         		natural_scroll = true;
#         	};
#         };
#   
#         # Atalhos de teclado
#         "$mainMod" = "SUPER";
#         bind = [
#           "ALT, Q, killactive,"
#           "$mainMod, M, exit,"
#           "$mainMod SHIFT, F, fullscreen, 1"
#           "$mainMod CTRL, F, fullscreen"
#           "$mainMod, left, movefocus, l"
#           "$mainMod, right, movefocus, r"
#           "$mainMod, up, movefocus, u"
#           "$mainMod, down, movefocus, d"
#           # "$mainMod, V, togglefloating,"
#           # Application shortcuts
#           "$mainMod, T, exec, ghostty"
#           "$mainMod, E, exec, nautilus"
#           "$mainMod, D, exec, vicinae toggle"
#           "$mainMod, V, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
#           "$mainMod SHIFT, S, exec, hyprshot --mode region"
#         ];
#         bindm = [
#           "$mainMod, mouse:272, movewindow"
#           "$mainMod, mouse:273, resizewindow"
#         ];
#         binde = [
#           "$mainMod SHIFT, left, resizeactive, -50 0"
#           "$mainMod SHIFT, right, resizeactive, 50 0"
#           "$mainMod SHIFT, up, resizeactive, 0 -50"
#           "$mainMod SHIFT, down, resizeactive, 0 50"
#         ];
#   
#         decoration = {
#           rounding = 10;
#           # blur = {
#           # 	enable = true;
#           # 	size = 3;
#           # 	passes = 1;
#           # 	new_optimizations = true;
#           # };
#         };
# 
# 		misc = {
# 			force_default_wallpaper = 0;
# 			disable_hyprland_logo = true;
# 		};
# 
# 		# monitor = [
# 		#     "eDP-1, 1920x1080@60, 0x0, 1"
# 		# ];
# 
# 		workspace = [
# 	       "1, monitor:eDP-1"
# 	       "2, monitor:eDP-1"
# 	       "3, monitor:eDP-1"
# 	       "4, monitor:eDP-1"
# 	   ];
#         
#       };
#   };

  home.stateVersion = "25.05";
}
