{ ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      image_size = 48;
      columns = 3;
      allow_images = true;
      insensitive = true;
      term = "kitty";
      no_actions = true;
    };
  };
}
