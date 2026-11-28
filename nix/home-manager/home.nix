{
	lib,
	pkgs,
	...
}: {
	imports = [./steamos.nix];

	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "deck";
	home.homeDirectory = "/home/deck";

	# Recommend enable for non-NixOS
	targets.genericLinux.enable = true;

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "26.05"; # Please read the comment before changing.

	fonts.fontconfig.enable = true;

	# The home.packages option allows you to install Nix packages into your
	# environment.
	home.packages = with pkgs; [
		# Utils
		fastfetch
		bat
		lsd
		duf
		ripgrep
		fd
		fzf
		chafa
		# Dev
		gh
		lazygit
		delta
		neovim
		just
		tree-sitter
		gcc
		clang-tools
		cargo
		rustc
		rust-analyzer
		rustfmt
		clippy
		nixd
		alejandra
		gnumake
		ghostty
		# Font
		monaspace
	];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#   org.gradle.console=verbose
		#   org.gradle.daemon.idletimeout=3600000
		# '';
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. These will be explicitly sourced when using a
	# shell provided by Home Manager. If you don't want to manage your shell
	# through Home Manager then you have to manually source 'hm-session-vars.sh'
	# located at either
	#
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/deck/etc/profile.d/hm-session-vars.sh
	#
	home.sessionPath = [
		"$HOME/.local/bin"
	];

	home.sessionVariables = {
		EDITOR = "nvim";
		RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
	};

	programs.gpg.enable = true;
	services.gpg-agent.enable = true;
	programs.git = {
		enable = true;
		settings.user = {
			name = "jsun969";
			email = "i@jsun.lol";
		};
		signing = {
			key = "09BB20230969D665";
			format = "openpgp";
			signByDefault = true;
		};
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		shellAliases = {
			ls = "lsd";
		};
		history.size = 8000;
	};

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.herdr = {
		enable = true;
		mutableSettings = true;
		settings = {
			onboarding = false;
			terminal.default_shell = "zsh";
		};
	};

	i18n.inputMethod = {
		enable = true;
		type = "fcitx5";
		fcitx5 = {
			systemd.enable = false; # KWin starts Fcitx5, not nix
			waylandFrontend = true;
			addons = with pkgs; [
				qt6Packages.fcitx5-chinese-addons
				(fcitx5-rime.override {rimeDataPkgs = [rime-data rime-ice];})
			];
		};
	};
	# Use rime-ice's recommended defaults
	xdg.dataFile."fcitx5/rime/default.custom.yaml".text =
		lib.generators.toYAML {} {
			patch."__include" = "rime_ice_suggestion:/";
		};

	programs.nh = {
		enable = true;
	};

	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
