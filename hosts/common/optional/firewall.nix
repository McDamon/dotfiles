{ ... }: {
  networking.firewall = {
    enable = true;
    
    logRefusedConnections = true;
  };
}
