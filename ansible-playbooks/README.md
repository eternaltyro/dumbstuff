# Running

```
ansible-playbook \
  --ask-become-pass \
  --check \
  --tags onetime \
  --inventory hosts \
  archall.yml
```
