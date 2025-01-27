  let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
    pkgs = import nixpkgs { config = {}; overlays = []; };

  in

    pkgs.mkShellNoCC { 
      packages = with pkgs; [
        figlet
        lolcat
        libgcc
        gcc
        yarn
        ripgrep
        rustup
        cargo
        cmake
        nodePackages.nodejs
        nodePackages.npm
        python3
        gnumake
      ];

    GREETING = "shell env !";

    shellHook = ''
      echo $GREETING | figlet | lolcat
    '';

    }

