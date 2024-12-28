{ pkgs, userConfig, ... }:

{
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userConfig.username} = {
    isNormalUser = true;
    description = userConfig.name;
    useDefaultShell = true;
    extraGroups = [ "wheel" "networkmanager" "input"  "video" "audio" "adbusers" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tdesktop
    ];
  };

  users.users.${userConfig.username2} = {
    isNormalUser = true;
    description = userConfig.name2;
    useDefaultShell = true;
    extraGroups = [ "wheel" "networkmanager" "input"  "video" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      brave # browser
    ];
  };

  # fish
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";

  # user pkgs
  programs = {
    adb.enable = true;
  };
}