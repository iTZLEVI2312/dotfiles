{
  description = "Levi's nixos configuration";

  outputs = {
              self,
              nixpkgs,
              nixpkgs-stable,
              chaotic,
              home-manager,
              home-manager-stable,
              hyprland,
              ...
            }@inputs:
  
  let

    # ---- SYSTEM Configuration ---- #
    systemConfig = {
      system = "x86_64-linux"; # system arch
      hostname = "nix"; # hostname
      timezone = "Asia/Kolkata"; # select timezone
      locale = "en_US.UTF-8"; # select locale
      bootMode = "uefi"; # uefi or bios
      bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
      grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
    };

    # ----- USER Configuration ----- #
    userConfig = {
      username = "itz_levi_404"; # username
      name = "Levi"; # name/identifier
      email = "exmaple@gmail.com"; # email (used for certain configurations)
      dotfilesDir = "~/dotfiles"; # absolute path of the local repo
      dotfilesDirName = "dotfiles"; # name for dotfiles dir
      
      themeConfig = {
        cursorPkg = pkgs.bibata-cursors;
        cursor = "Bibata-Modern-Ice";

        themePkg = pkgs.adw-gtk3;
        theme = "adw-gtk3-dark";

        iconPkg = pkgs.tela-circle-icon-theme;
        icon = "Tela-circle";
      };

    };

    system = systemConfig.system;
    lib = nixpkgs.lib;

    # from nixpkgs channel
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    # from nixpkgs-stable channel
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

  in
  {

    nixosConfigurations =

    let
      systemModules = [
        # define nix modules
        ./system/configuration.nix # Your system configuration.
        chaotic.nixosModules.default # chaotic default module
        {
          nixpkgs.overlays = [
            # example.overlay
            # inputs.example-overlay.overlay
          ];
        }
      ];
    in
    {
      ${systemConfig.hostname} = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-stable;
          inherit systemConfig;
          inherit userConfig;
          inherit inputs;
        };
        modules = systemModules ++ [
          # ./system/hardware/hardware-configuration.nix # other nix modules
        ];
      };
    };

    homeConfigurations = {
      ${userConfig.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit systemConfig;
          inherit userConfig;
          inherit inputs;
        };
        modules = [
          ./user/home.nix
          hyprland.homeManagerModules.default # hyprland hm module
        ];
      };
    };

  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      # home-manager follows nixpkgs channel
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      # home-manager follows nixpkgs-stable channel
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

  };

}
