# Ansible: Infrastructure as Code (configuration)

This playbook configures an Ubuntu server from scratch and deploys the app.
It replaces the manual steps we did earlier (installing Docker, cloning the
repo, building and running the container) with one repeatable command.

## Why this matters

- **Repeatable:** run it against any fresh Ubuntu server to get an identical setup.
- **Idempotent:** safe to run many times. It only changes what isn't already correct.
- **Documented:** the playbook IS the documentation of how the server is set up.

## Files

| File            | Purpose                                             |
|-----------------|-----------------------------------------------------|
| `inventory.ini` | Lists the servers to manage and shared variables    |
| `playbook.yml`  | The desired state: install Docker, deploy the app   |

## Prerequisites (on the control node)

Install Ansible once:

```bash
sudo apt-get update
sudo apt-get install -y ansible
ansible --version
```

## Running the playbook

From inside the `ansible/` directory:

```bash
# Dry run: show what WOULD change, without changing anything (highly recommended first)
ansible-playbook -i inventory.ini playbook.yml --check

# Real run: apply the configuration
ansible-playbook -i inventory.ini playbook.yml
```

## Reading the output

Ansible prints a colored result per task:

- **ok** (green): already in the desired state, nothing changed
- **changed** (yellow): Ansible made a change
- **failed** (red): something went wrong

At the end, the **PLAY RECAP** summarizes counts of ok / changed / failed.
Run it a second time and most tasks should say **ok**, that's idempotency in action.

## Managing a second server later

Add a line to `inventory.ini` under `[appservers]`:

```ini
app2 ansible_host=<second-server-ip> ansible_user=ubuntu
```

Remove `ansible_connection=local` from that host so Ansible connects over SSH,
then run the same playbook. One command configures the new server identically.
