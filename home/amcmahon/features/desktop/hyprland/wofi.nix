{ ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      image_size = 48;
      columns = 3;
      allow_images = true;
      run-always_parse_args = true;
      run-exec_search = true;
    };
  };
}
