{ pkgs, userConfig, ... }:

{
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userConfig.username} = {
    isNormalUser = true;
    description = userConfig.name;
    useDefaultShell = true;
    extraGroups = [ "wheel" "networkmanager" "input"  "video" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox-wayland
      vscodium
      tdesktop
      ani-cli
    ];
  };

  # zsh
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
