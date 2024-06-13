  let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
    pkgs = import nixpkgs { config = {}; overlays = []; };

  in

    pkgs.mkShellNoCC { 
      packages = with pkgs; [
        cowsay
        lolcat
        libgcc
        yarn
        ripgrep
        rustup
        nodePackages.npm
        python3  
      ];

    GREETING = "Welcome to shell env !";

    shellHook = ''
      echo $GREETING | cowsay | lolcat
    '';

    }

