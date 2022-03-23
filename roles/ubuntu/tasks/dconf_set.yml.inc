---
- name: "check {{ dconf_entry.key }}"
  ansible.builtin.command: "dconf read {{ dconf_entry.key }}"
  changed_when: no
  register: dconf_read

- name: "set {{ dconf_entry.key }}"
  ansible.builtin.command: "dconf write {{ dconf_entry.key }} {{ dconf_entry.value }}"
  when: dconf_read.stdout != dconf_entry.value

