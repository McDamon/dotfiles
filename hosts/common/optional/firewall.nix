{ ... }: {
  networking.firewall = {
    enable = true;
    
    allowedUDPPorts = [ 51820 ];
    
    checkReversePath = "loose"; 
  };
}
