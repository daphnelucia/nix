# personal nixos config

manually needed:
* login to github with `gh auth login` on both user and root accounts
* make librewolf persist cookies
* login to accounts
* install librewolf extensions (ublock, feedbro, web scrobbler, sponsorblock)
* login to yams with `yams` command
* setup obsidian vault (probably replace obsidian with org mode eventually)
* setup spacemacs
* setup default audio devices
* change gmod launch command to `GMOD_ENABLE_LD_PRELOAD=1 LD_PRELOAD=$LD_PRELOAD:/run/current-system/sw/lib/libtcmalloc_minimal.so %command%`

todo:
* move flatpak installation to home-manager (https://github.com/gmodena/nix-flatpak/discussions/195#discussioncomment-17215733)
* setup srcds & figure out libraries needed
* setup playit declaratively
* setup tablet drivers
* setup syncthing and zerotier
* eventually port everything in /config to .nix
* sync rss feeds and bookmarks
* if able to sync librewolf extensions: sync web scrobbler bulk edits with version on gist

