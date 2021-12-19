{ config, pkgs, lib, ... }: {
  programs.direnv.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      nupdate = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };
  programs.starship = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      character = {
        success_symbol = "[»](bold green)";
        error_symbol = "[»](bold red)";
        vicmd_symbol = "[«](bold green)";
      };
   };
  };
  nixpkgs.overlays = [ (self: super: {
  	weechat = super.weechat.override {
    		configure = { availablePlugins, ... }: {
      			scripts = with super.weechatScripts; [
        			weechat-otr
        			wee-slack
 	     			];
 	   		};
 	 	};
  	}
  )];
}
