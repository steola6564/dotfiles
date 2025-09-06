{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication       = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin              = "no";
    };
  };
}

