{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    font-awesome # for waybar icons
    jetbrains-mono
    geist-font
    fantasque-sans-mono
    fira-code-nerdfont
    nerd-font-patcher
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    powerline-fonts
    powerline-symbols
  ];
}
