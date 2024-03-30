{ ... }:
{
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 144;
      };
      color = {
        gradient = 1;
        gradient_count = 2;
        gradient_color_2 = "'#2ac3de'";
        gradient_color_1 = "'#f7768e";
      };
      smoothing = {
        gravity = 75;
      };
    };
  };
}
