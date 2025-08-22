# Enable GNOME keyring and ssh-agent
# Should already be set by the systemd module but that doesn't work
export SSH_AUTH_SOCK=$(ss -a | grep gcr/ssh | awk '{print $5}')
