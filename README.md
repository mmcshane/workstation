## Not Automated

### Bootstrap With Ansible

```
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
$ ansible-playbook ./workstation.yml -K
```

### fscrypt

```
# mkdir /home/new.tmp
# echo "<login_password>" | fscrypt encrypt /home/new.tmp --source=pam_passphrase --quiet
# cp -a -T /home/mpm /home/new.tmp
# rm -rf /home/mpm
# mv /home/new.tmp /home/mpm
```
