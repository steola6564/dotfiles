{ config, lib, pkgs, ... }:
{
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc fcitx5-gtk libsForQt5.fcitx5-qt qt6Packages.fcitx5-qt
    ];
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Useful for IME on Wayland/X
  environment.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
}
