{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Media Players
    kodi
    vlc

    # Image & Video Tools
    ffmpeg
    gthumb
    imagemagick
    simplescreenrecorder

    # Gaming
    lutris

    # Document Readers
    xreader
  ];
}
