# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # home-manager.nixosModules.home-manager
    ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # programs.dconf.enable = true;
  
  networking = {
	hostName = "nixos";
	networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Recife";

  # Select internationalisation properties.
  i18n = {
  	defaultLocale = "en_US.UTF-8";
  	extraLocaleSettings = {
	    LC_ADDRESS = "pt_BR.UTF-8";
	    LC_IDENTIFICATION = "pt_BR.UTF-8";
	    LC_MEASUREMENT = "pt_BR.UTF-8";
    	LC_MONETARY = "pt_BR.UTF-8";
	    LC_NAME = "pt_BR.UTF-8";
	    LC_NUMERIC = "pt_BR.UTF-8";
	    LC_PAPER = "pt_BR.UTF-8";
	    LC_TELEPHONE = "pt_BR.UTF-8";
	    LC_TIME = "pt_BR.UTF-8";
	};	
  };

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    printing.enable = true;
  	flatpak.enable = true;
  	pulseaudio.enable = false;
  	tailscale.enable = true;
  	xserver = {
  		enable = true;
  		xkb = {
  		    layout = "br";
  		    variant = "";
  		};
  	};
  	pipewire = {
  	    enable = true;
  	    alsa.enable = true;
  	    alsa.support32Bit = true;
  	    pulse.enable = true;
  	};
  	syncthing = {
		enable = true;
		openDefaultPorts = true;
  	};
  	udev.extraRules = ''
  	    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", MODE="0666"
  	  '';
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";
  
  hardware = {
    graphics.enable = true;
  };
 
  security.rtkit.enable = true;

  # Define a user account.
  users.users.jamesislan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Joamerson Islan";
    extraGroups = [ "networkmanager" "wheel" "video" "vboxusers"];
  };
  
  # home-manager.useGlobalPkgs = true;
  # home-manager.users.jamesislan = import ./home.nix;

  programs = {
    firefox.enable = true;
    virt-manager.enable = true;
    zsh.enable = true;
    # hyprland = {
    #     enable = false;
    #     withUWSM = true;
    #     xwayland.enable = true;
    # };
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  virtualisation = {
	libvirtd.enable = true;
	spiceUSBRedirection.enable = true;
	virtualbox.host = {
	    enable = false;
	    enableExtensionPack = true; # Optional (for USB 2.0/3.0 support)
	};
  };

  users.groups.libvirtd.members = ["jamesislan"];

  environment = {
    systemPackages = with pkgs; [];
  	gnome.excludePackages = with pkgs; [
  	  	gnome-console
  	  	gnome-weather
  	  	gnome-maps
  	  	
  	];

  	sessionVariables = {
  	    WLR_NO_HARDWARE_CURSORS = "1";
  	    NIXOS_OZONE_WL = "1";
  	    MOZ_ENABLE_WAYLAND = "1";
  	    # GTK_THEME = "Adwaita:dark"; 
  	};
  };

#   xdg.terminal-exec = {
#       enable = true;
#       settings = {
#           default = [ "ghostty.desktop" ];
#       };
#   };
# 
#   xdg.portal = {
#     enable = true;
#     extraPortals = [
#     	pkgs.xdg-desktop-portal-gnome
#     	pkgs.xdg-desktop-portal-gtk
#    	];
#     config.common.default = "gnome";
#   };

  services.dbus.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  # Dev partition configuration
  fileSystems = {
	"/mnt/dev" = {
	    device = "/dev/disk/by-uuid/2c353cef-0699-4a32-978f-8266402ba69b";
	    fsType = "ext4";
	    options = ["nosuid" "nodev" "nofail" "x-gvfs-show"];  # Prevents privilege escalation via SUID binaries
	};

	"/mnt/files" = {
	    device = "/dev/disk/by-uuid/1194E68A2D9ED306";
	    fsType = "ntfs";
	    options = ["nosuid" "nodev" "nofail" "x-gvfs-show"];  # Prevents privilege escalation via SUID binaries
	};
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "server min protocol" = "NT1";
        "ntlm auth" = "yes";
        #"use sendfile" = "yes";
        #"max protocol" = "smb1";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 192.168.1. 127.0.0.1 10.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
      };
      "projects" = {
        "path" = "/mnt/files/Archive";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "valid users" = "jamesislan";
      };
    };
  };
  
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.allowedTCPPorts = [ 22000 ]; # For Syncthing
  networking.firewall.allowedUDPPorts = [ 22000 21027 ]; # For Syncthing

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ "/etc/nixos/secrets.env" ];
    profiles = {
      "JCDA" = {
        connection = {
          id = "JCDA";
          type = "wifi";
          autoconnect = true;
        };
        wifi = {
          ssid = "JCDA";
          mode = "infrastructure";
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$JCDA_PASS";
        };
      };
    "JVL" = {
              connection = {
                id = "JVL";
                type = "wifi";
                autoconnect = true;
              };
              wifi = {
                ssid = "JVL";
                mode = "infrastructure";
              };
              wifi-security = {
                key-mgmt = "wpa-psk";
                psk = "$JVL_PASS";
              };
            };  
    "MPCA" = {
            connection = {
              id = "MPCA";
              type = "wifi";
              autoconnect = false;
            };
            wifi = {
              ssid = "MPCA";
              mode = "infrastructure";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$MPCA_PASS";
            };
          };
      };
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
