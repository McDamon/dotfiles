{
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
    };
  };

  users.users."amcmahon".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaAG9JgMqy187z+CrYDOvIlu4MB859NOUw04SMdDpp8aUKnBCHikLsjJCXWgVuaMpRMC69vBduLPukSr82uLwODjD67rZlsGbAdkP/IKvqn5siK3TVkmJGC7b/6nIMckkHcxtcAeibnSvTMS6WCstkyO0cl/wY5xjK7fiNynVVitEovuz/Kra8sOJ4VrCe74kqfwqz7lgYzKbjCBqgsyFNRLLtXvWuPr/X28wf8pGc/dpSYgfKTQ5vHagaVBiWQHeDQ5OUwX8iIkM1qPGHz388IxYKfoP88nPFBVCxZmJ/6UqrYut/AEHy9RfkqB52JHN1M7i0HI8udAuYqgvOK+vd C:/Program Files/Yubico/Yubico PIV Tool/bin/libykcs11.dll"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAOE/dhQjItZKOx4go3MyxyoJ2JyyWt2TE+Aygrw5zG7R6uvjK8VeJJlkvfYFNlgsPw3tj53VzDDpVWwVh3CfTUpzpguvAzkUg3+axeQZM909WFV6o0weHhDJitiLHBZpNsMIahANrFWWJ9WY9LTYy+bw0OMLXtfcuGxXU6JL/A5JywjwccaBBdAhAQMye3pzBnzdArvfta67m6FLNPeNU7PbxGeKPWn/w9xVZwYpYI9Vg1sKYJ1yb+xB4kHzLloRENp48ghm/1rGcNPQOdQ7toOnNcDuLtc9uuSJIESntEKpcazlwGoYJur//EaH78Aa0IJX+xAydOOXR3aTZDxdP C:/Program Files/Yubico/Yubico PIV Tool/bin/libykcs11.dll"
  ];
}
