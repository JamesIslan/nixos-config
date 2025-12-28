{ config, pkgs, ... }:

{
  home.username = "jamesislan";
  home.homeDirectory = "/home/jamesislan";
  
  home.packages = with pkgs; [
  	atool
  	kitty
  	jellyfin-media-player
  	# typora # Removed by now
  	jdk
  	maven
  	affine
  	httpie
  	yt-dlp
  	syncthing
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
  	# bottles
  	qbittorrent
  	shotwell
  	pdfgrep
  	# xnviewmp
	# ...
  	gparted
  	# nufraw
  	nufraw-thumbnailer
  	ghostty
  	# git
  	nodejs_24
  	pinta
  	libreoffice-qt6-fresh
  	pavucontrol
  	# xflux # Deprecated
  	vlc
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
  	    # Add all your python tools here
  	    ps.pip
  	    ps.pygments
  	    ps.jupyter
  	    ps.notebook
  	    ps.ipykernel
  	]))
  ];

  # services.tailscale.enable = true;  
  programs = {
  	bash.enable = true;
  	obs-studio.enable = true;
  	git = {
  		enable = true;
 		settings.user.name = "Joamerson Islan";
  	    settings.user.email = "joamersonislan38@gmail.com";
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
		    "cursor" = "underline";
		    "blinkingcursor" = false;
		    "colorscheme" = "monokai";
  	  };
  	};
  };

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
  
  xdg.configFile."ghostty/config".text = ''
    font-family = "CartographCF Nerd Font"
    font-size = 16

    # theme = "FrontEndDelight"
    # theme = "Ayu"
    # theme = "Chalk"
    theme = "Dark Modern"
    # theme = "Elementary"
    window-padding-x = 10
    window-padding-y = 10
  '';

  home.stateVersion = "25.05";
}
