{ pkgs, pkgs-unstable, ... }:

{

  # Enable display manager
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };

  # Enable hyprland and related stuff
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Dbus
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  # security
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Hint Electon apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # mouse/touchpad cursor
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # cross desktop grouping (sandbox apps)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # Some system packages
  environment.systemPackages = (with pkgs; [

    # Window Manager --------------------------------------------------- #
    hyprland                           # wlroots-based wayland compositor
    xwayland                           # interface X11 apps with Wayland protocol
    kdePackages.dolphin                # kde file manager
    kdePackages.ark                    # kde file archiver
    dunst                              # notification daemon
    rofi-wayland                       # application launcher
    waybar                             # system bar
    swww                               # wallpaper
    swaylock-effects                   # lock screen
    wlogout                            # logout menu
    grimblast                          # screenshot tool
    hyprpicker                         # color picker
    slurp                              # region select for screenshot/screenshare
    swappy                             # screenshot editor
    cliphist                           # clipboard manager

    # Dependencies ----------------------------------------------------- #
    polkit_gnome                       # authentication agent
    gnome.gnome-keyring                # store pass, keys, etc
    xdg-desktop-portal-hyprland        # xdg desktop portal for hyprland
    xdg-desktop-portal-gtk             # xdg desktop portal for gtk
    parallel                           # for parallel processing
    jq                                 # for json processing
    imagemagick                        # for image processing
    libsForQt5.qt5.qtimageformats      # for dolphin image thumbnails
    kdePackages.ffmpegthumbs           # for dolphin video thumbnails
    kde-cli-tools                      # for dolphin file type defaults
    libnotify                          # for notifications
    notify-desktop                     # for sending desktop notifications

    # Theming ---------------------------------------------------------- #
    nwg-look                           # gtk configuration tool
    libsForQt5.qt5ct                   # qt5 configuration tool
    kdePackages.qt6ct                  # qt6 configuration tool
    libsForQt5.qtstyleplugin-kvantum   # svg based qt5 theme engine
    kdePackages.qtstyleplugin-kvantum  # svg based qt6 theme engine
    libsForQt5.qt5.qtwayland           # wayland support in qt5
    kdePackages.qtwayland              # wayland support in qt6
    adw-gtk3                           # adwaita gtk3 theme

  ]) ++ (with pkgs-unstable; [

    # pkgs from unstable branch
    hyprpaper
    hyprlock
    hypridle
    hyprcursor

    wl-clipboard
    wl-clip-persist

  ]);

}
