# Logging in via SSH

## SSH over Tor

By default, SSH access to SecureDrop servers is routed through the Tor network, allowing you to access the servers from anywhere in the world where you have a stable internet connection and are able to access the Tor network.

To do so, simply open a Terminal and run either the `ssh app` or `ssh mon` command, depending on which server you are intending to access.

This is useful for routine maintenance and log investigation tasks, although direct physical access will still be necessary for network-related issues, in situations where SSH access is not available.

For more details about the types of tasks that can be completed via SSH, you can [review the SSH portion of our Admin Guide](#server-ssh-access).

If you'd like to make adjustments to the SSH configuration, or disable SSH access over Tor, you can do so by following the steps here.

In addition to remote SSH access, the web-based Admin Interface is also from any location with a network connection and access to the Tor network.

(server-ssh-access)=

## Server SSH access

Generally, you should avoid directly SSHing into the servers in favor of using the Admin Interface or `securedrop-admin`. However, in some cases, you may need to SSH in order to troubleshoot and fix a problem that cannot be resolved via these tools.

You can access your Application Server and Monitor Server via SSH from an Admin Workstation by using either the `ssh app` or `ssh mon` commands (respectively).

In this section we cover basic commands you may find useful when you SSH into the Application Server and Monitor Server.

:::{tip}
When you SSH into either SecureDrop server, you will be dropped into a `tmux` session. `tmux` is a screen multiplexer - it allows you to tile panes, preserve sessions to keep your session alive if the network connection fails, and more. Check out this [tmux tutorial] to learn how to use `tmux`.
:::

:::{tip}
If you want a refresher of the Linux command line, we recommend [this resource] to cover the fundamentals.
:::

### Shutting Down the Servers

```sh
sudo shutdown now -h
```

### Rebooting the servers

```sh
sudo reboot
```

(investigating_logs)=

## Investigating logs

Consult our [Investigating Logs](../maintenance/logging.md) topic guide for locations of the most relevant log files you may want to examine as part of troubleshooting, and for how to enable error logging for the Source Interface.

```{include} ../../includes/get-logs.md
```

(immediate_update)=

## Immediately apply a SecureDrop update

SecureDrop will update and reboot once per day. However, once a SecureDrop update [is announced], you can opt to fetch the update immediately.

:::{important}
Except where otherwise indicated, make sure to update both your Application Server and your Monitor Server.
:::

To update your servers immediately, you can SSH into each server (via `ssh app` and `ssh mon`) and run the following commands:

```sh
sudo apt update
sudo unattended-upgrades
```

:::{note}
Depending on the nature of the update (e.g., if the `tor` package is upgraded and you are using SSH-over-Tor), your SSH connection may be interrupted, and you may have to reconnect to see the full output.
:::

## Application Server

### Adding users (CLI)

After the provisioning of the first admin account, we recommend using the Admin Interface web application for adding additional journalist and admin accounts.

However, you can also add users via `./manage.py` in `/var/www/securedrop/` as described [during first install](../installation/create_admin_account.md). You can use this command line method if the web application is unavailable.

### Restart the web server

If you make changes to your Apache configuration, you may want to restart the web server to apply the changes:

```sh
sudo systemctl restart apache2
```

(submission-cleanup)=

### Removing files that should have been deleted

When submitted messages or files are deleted, their database records are deleted and the encrypted files are securely wiped. For large files, secure removal can take some time, and it's possible, though unlikely, that it can be interrupted, for example by a server reboot. In older versions of SecureDrop this could leave a files present without a database record.

As of SecureDrop 1.0.0, automated checks send OSSEC alerts when this situation is detected, recommending you run `manage.py list-disconnected-fs-submissions` to see the files affected. As with any `manage.py` usage, you would run the following:

```sh
ssh app
sudo -u www-data bash
cd /var/www/securedrop
./manage.py list-disconnected-fs-submissions
```

You then have the option of running:

```sh
./manage.py delete-disconnected-fs-submissions
```

to clean them up. As with any potentially destructive operation, it's recommended that you [back the system up](../maintenance/backup_and_restore.md) before doing so.

There is also the inverse scenario, where a database record could point to a file that no longer exists. This would usually only have happened as a result of disaster recovery, where perhaps the database was recovered from a failed hard drive, but some messages and files were not. The OSSEC alert in this case would recommend running:

```sh
./manage.py list-disconnected-db-submissions
```

To clean up the affected records you would run (again, preferably after a backup):

```sh
./manage.py delete-disconnected-db-submissions
```

Even when messages and files are completely removed from the Application Server, they may still exist in [backups](/admin/maintenance/backup_and_restore.md) in an encrypted form.

## Monitor Server

### Restart OSSEC

If you make changes to your OSSEC monitoring configuration, you will want to restart OSSEC via [OSSEC's control script], `ossec-control`:

```sh
sudo /var/ossec/bin/ossec-control restart
```

[is announced]: https://securedrop.org/news
[ossec's control script]: https://ossec-docs.readthedocs.io/en/latest/docs/programs/ossec-control.html
[this resource]: https://linuxcommand.org/lc3_learning_the_shell.php
[tmux tutorial]: https://thoughtbot.com/blog/a-tmux-crash-course
