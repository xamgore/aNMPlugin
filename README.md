aNMPlugin/mpd
-------------

`systemd --user` configuration for Music Player Daemon to broadcast music on [annimon.com](https://annimon.com) website using aNMusic API.

* To use this, replace the values of `USER_LOGIN` and `ACCESS_TOKEN` variables on 41 line of [plugin/systemd-tree/scripts/anmusic](https://github.com/xamgore/aNMPlugin/blob/mpd/master/plugin/systemd-tree/scripts/anmusic#L41) file;
* To install this, copy all files from [plugin/systemd-tree](https://github.com/xamgore/aNMPlugin/blob/mpd/master/plugin/systemd-tree) folder to any of your systemd trees (preferably `~/.config/systemd`, change the `ExecStart=` option in the systemd-service file overwise) and type `systemctl enable anmusic && systemctl start anmusic` in your console.

ToDo:

1. Take/store a login and its data from/in GNOME Keyring or similar;
2. Write a PKGBUILD.
