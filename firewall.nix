{ pkgs, options, ... }:
{
   networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
  };
}
