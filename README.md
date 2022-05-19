## Not Automated

### fscrypt

```bash
# apt install fscrypt libpam-fscrypt
# tune2fs -O encrypt "$(findmnt --mountpoint / --output source --noheadings)"
# fscrypt setup --quit --force --all-users
# cd /home
# mkdir new.tmp
# echo "<login_password>" | fscrypt encrypt new.tmp --source=pam_passphrase --quiet
# cp -a -T mpm new.tmp
# rm -rf mpm
# mv new.tmp mpm
```

### Sound Input & Output Device Chooser

```bash
$ mkdir -p "$XDG_DATA_HOME/gnome-shell/extensions/sound-output-device-chooser@kgshank.net"
$ wget https://extensions.gnome.org/extension-data/sound-output-device-chooserkgshank.net.v43.shell-extension.zip
$ unzip unzip -d .local/share/gnome-shell/extensions/sound-output-device-chooser@kgshank.net/ sound-output-device-chooserkgshank.net.v43.shell-extension.zip 
$ # restart gnome
$ gnome-extensions enable sound-output-device-chooser@kgshank.net
```

## Bootstrap With Ansible

```bash
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
$ ansible-playbook ./workstation.yml -K -i localhost, -c local
```
