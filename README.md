## Not Automated

### fscrypt

```
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

## Bootstrap With Ansible

```
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
$ ansible-playbook ./workstation.yml -K -i localhost, -c local
```
