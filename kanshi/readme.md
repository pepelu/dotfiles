Kanshi is automatically managed using systemd.

This expects the user `sway-session.target` to exist (it does in Fedora Sway spin).
You can check this with:
```
systemctl --user list-units --type target
```

If it does, you just need to `stow kanshi` and enable and start the systemd module:
```
systemctl --user enable kanshi.service
systemctl --user start kanshi.service
```

As for the config, you can get information about the outputs with

```
swaymsg -t get_outputs
```
