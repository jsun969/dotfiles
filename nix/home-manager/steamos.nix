# Workarounds for running Home Manager on SteamOS (non-NixOS, KDE Plasma,
# single-user Nix) so Nix-installed apps integrate with the desktop.
{
	config,
	lib,
	pkgs,
	...
}: {
	# systemd --user starts before XDG_DATA_DIRS includes the Nix profile, so it never
	# sees units shipped by packages (e.g. Ghostty's D-Bus-activated app unit).
	# Link them into ~/.local/share/systemd/user, which systemd always searches.
	xdg.dataFile."systemd/user" = {
		source = "${config.home.path}/share/systemd/user";
		recursive = true;
	};

	# KDE refuses to launch .desktop files that resolve outside its applications dirs
	# unless they're executable or root-owned; Nix store files are neither. Ship
	# executable copies of every package's entries in ~/.local/share/applications.
	xdg.dataFile."applications" = {
		source = pkgs.runCommandLocal "kde-desktop-entries" {} ''
			mkdir -p $out
			for f in ${config.home.path}/share/applications/*.desktop; do
				install -m755 "$(readlink -f "$f")" "$out/$(basename "$f")"
			done
		'';
		recursive = true;
	};

	# Refresh KDE's app cache and systemd user units after each switch, so Plasma
	# launchers and D-Bus-activated units don't point at stale /nix/store paths.
	# The ksycoca cache file name is a hash of XDG_DATA_DIRS plus the locale, and
	# entries whose TryExec isn't on PATH are dropped, so rebuild it with the
	# graphical session's values (what plasmashell uses), not the activation env.
	# plasmashell keeps parts of the old cache mapped, so restart it (only if it's
	# running) to make the app menu and panel launchers pick up the new entries.
	home.activation.refreshDesktop = lib.hm.dag.entryAfter ["writeBoundary"] ''
		sessionEnv=()
		while IFS= read -r line; do
			case "$line" in
				XDG_DATA_DIRS=*|PATH=*|LANG=*|LANGUAGE=*|LC_ALL=*|LC_MESSAGES=*) sessionEnv+=("$line") ;;
			esac
		done < <(${pkgs.systemd}/bin/systemctl --user show-environment)
		run env -u LANG -u LANGUAGE -u LC_ALL -u LC_MESSAGES "''${sessionEnv[@]}" /usr/bin/kbuildsycoca6 --noincremental || true
		run ${pkgs.systemd}/bin/systemctl --user daemon-reload || true
		run ${pkgs.systemd}/bin/systemctl --user try-restart plasma-plasmashell.service || true
	'';
}
