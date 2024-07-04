# Running

```
ansible-playbook --ask-become-pass --check --tags onetime \
  --inventory inventory.ini archall.yml
```

## Force handlers

Handlers run at the end of the play. They do not run if the play itself
fails. Handlers can be forced to run even if the play fails to run by
using `--force-handlers` when invoking ansible-playbook.

If we want the handlers to run immediately after a task, we can use the
`flush_handlers` meta task to force it to run.

## Deliberately failing

add `- fail:` task

## TODO:

- DNS over TLS in systemd-resolved
- Networkmanager uses systemd-resolved
