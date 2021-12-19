{
	allowUnfree = true;
	packageOverrides = pkgs: rec {
    		weechat = pkgs.weechat.override { extraBuildInputs = [ pkgs.xmpppy ]; };
  	};
}
