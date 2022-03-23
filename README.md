```bash
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
$ ansible-playbook ./workstation.yml -K -i localhost, -c local
```
