Logging in via SSH
==================

.. _server SSH access:

Server SSH Access
------------------

Generally, you should avoid directly SSHing into the servers in favor of using
the *Admin Interface* or ``securedrop-admin``. However, in some cases,
you may need to SSH in order to troubleshoot and fix a problem that cannot be
resolved via these tools.

You can access your *Application Server* and *Monitor Server* via SSH by
using either the ``ssh app`` or ``ssh mon`` commands (respectively) from an
*Admin Workstation*.

For quick access, use the "SSH into the App Server" and "SSH into the Monitor
Server" options in the *SecureDrop Menu*.

In this section we cover basic commands you may find useful when you SSH into
the *Application Server* and *Monitor Server*.

.. tip:: When you SSH into either SecureDrop server, you will be dropped into a
        ``tmux`` session. ``tmux`` is a screen multiplexer - it allows you to tile
        panes, preserve sessions to keep your session alive if the network
        connection fails, and more. Check out this `tmux tutorial`_ to learn how
        to use ``tmux``.

.. _`tmux tutorial`:
  https://thoughtbot.com/blog/a-tmux-crash-course

.. tip:: If you want a refresher of the Linux command line, we recommend
  `this resource`_ to cover the fundamentals.

.. _`this resource`:
  http://linuxcommand.org/lc3_learning_the_shell.php

Shutting Down the Servers
^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: sh

  sudo shutdown now -h

Rebooting the Servers
^^^^^^^^^^^^^^^^^^^^^

.. code:: sh

  sudo reboot

.. _investigating_logs:

Investigating Logs
------------------

Consult our :doc:`Investigating Logs <../maintenance/logging>` topic guide for locations of the
most relevant log files you may want to examine as part of troubleshooting, and
for how to enable error logging for the *Source Interface*.

.. include:: ../../includes/get-logs.txt

.. _immediate_update:

Immediately Apply a SecureDrop Update
-------------------------------------

SecureDrop will update and reboot once per day. However, once a SecureDrop
update `is announced`_, you can opt to fetch the update immediately.

.. important::

   Except where otherwise indicated, make sure to update both your
   *Application Server* and your *Monitor Server*.


To update your servers immediately, you can SSH
into each server (via ``ssh app`` and ``ssh mon``) and run the following commands:

.. code:: sh
   
  sudo apt update
  sudo unattended-upgrades

.. note::

   Depending on the nature of the update (e.g., if the ``tor`` package is
   upgraded and you are using SSH-over-Tor), your SSH connection may be
   interrupted, and you may have to reconnect to see the full output.

.. _`is announced`:
  https://securedrop.org/news

Application Server
------------------

Adding Users (CLI)
^^^^^^^^^^^^^^^^^^

After the provisioning of the first admin account, we recommend
using the Admin Interface web application for adding additional journalists
and admins.

However, you can also add users via ``./manage.py`` in ``/var/www/securedrop/``
as described :doc:`during first install <../installation/create_admin_account>`. 
You can use this command line method if the web application is unavailable.

Restart the Web Server
^^^^^^^^^^^^^^^^^^^^^^

If you make changes to your Apache configuration, you may want to restart the
web server to apply the changes:

.. code:: sh

  sudo service apache2 restart

.. _submission-cleanup:

Cleaning up deleted submissions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When submissions are deleted through the web interface, their database
records are deleted and their encrypted files are securely wiped. For
large files, secure removal can take some time, and it's possible,
though unlikely, that it can be interrupted, for example by a server
reboot. In older versions of SecureDrop this could leave a submission
file present without a database record.

As of SecureDrop 1.0.0, automated checks send OSSEC alerts when this
situation is detected, recommending you run ``manage.py
list-disconnected-fs-submissions`` to see the files affected. As with
any ``manage.py`` usage, you would run the following on the admin
workstation:

.. code:: sh

   ssh app
   sudo -u www-data bash
   cd /var/www/securedrop
   ./manage.py list-disconnected-fs-submissions

You then have the option of running:

.. code:: sh

   ./manage.py delete-disconnected-fs-submissions

to clean them up. As with any potentially destructive operation, it's
recommended that you :doc:`back the system up <../maintenance/backup_and_restore>`
before doing so.

There is also the inverse scenario, where a database record could
point to a file that no longer exists. This would usually only have
happened as a result of disaster recovery, where perhaps the database
was recovered from a failed hard drive, but some submissions could not
be. The OSSEC alert in this case would recommend running:

.. code:: sh

   ./manage.py list-disconnected-db-submissions


To clean up the affected records you would run (again, preferably
after a backup):

.. code:: sh

   ./manage.py delete-disconnected-db-submissions


Even when submissions are completely removed from the application
server, their encrypted files may still exist in backups. We recommend
that you delete old backup files with ``shred``, which is available on
Tails.

Monitor Server
--------------

Restart OSSEC
^^^^^^^^^^^^^

If you make changes to your OSSEC monitoring configuration, you will want to
restart OSSEC via `OSSEC's control script`_, ``ossec-control``:

.. code:: sh

   sudo /var/ossec/bin/ossec-control restart

.. _`OSSEC's control script`:
  https://ossec-docs.readthedocs.io/en/latest/docs/programs/ossec-control.html