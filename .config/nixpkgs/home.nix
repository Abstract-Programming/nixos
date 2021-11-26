{ config, pkgs, lib, ... }: {
  programs.direnv.enable = true;
  programs.zsh.enable = true;
  
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character = {
        success_symbol = "[»](bold green)";
        error_symbol = "[»](bold red)";
        vicmd_symbol = "[«](bold green)";
      };
   };
  };
}
