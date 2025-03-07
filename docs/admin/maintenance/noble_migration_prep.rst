Preparing for the Ubuntu 24.04 (Noble) migration
================================================

In 2025, SecureDrops will need to be upgraded to the newer Ubuntu 24.04 (Noble)
operating system. This process will be more straightforward than in the past
as there will be semiautomated and fully automated upgrade processes.

At this time, the current focus is on ensuring all SecureDrop servers are in a good state
to be ready for the migration. SecureDrop will automatically check some conditions, and report
via an alert in the Journalist Interface and OSSEC alerts if there are issues.

Timeline
--------

You should ensure all errors are resolved by January 31, 2025, to ensure your SecureDrop
servers can safely proceed to the next stage of the migration.

Getting more details
--------------------

If you see the alert in the Journalist Interface or receive an OSSEC alert, you'll
need to :doc:`SSH to the Application and Monitor Servers <../installation/test_the_installation>`
to get more information on what specifically is failing.

Once logged in, run:

.. code:: sh

   sudo securedrop-noble-migration-check

It will display a number of checks and whether they are failing.
Steps to address each issue are listed below. If you are unsure what to do,
please :ref:`contact Support <getting_support>`. It is safe to run this command
multiple times, e.g. if you resolved an issue and want to see that it is fixed.

For example:

.. code:: sh

    $ sudo securedrop-noble-migration-check
    ssh OK: group is empty
    ufw ERROR: ufw is still installed
    free space OK: enough free space
    apt OK: all sources are expected
    systemd OK: no failed units

    Some errors were found that will block migration.

    Documentation on how to resolve these errors can be found at:
    <https://docs.securedrop.org/en/stable/admin/maintenance/noble_migration_prep.html>

    If you are unsure what to do, please contact the SecureDrop
    support team: <https://docs.securedrop.org/en/stable/getting_support.html>.

In this case, the "ERROR" indicates that only the ufw check failed.

SSH group
---------

If this fails, it means the migration code in SecureDrop 2.11.0 did not work.

To address it, you can run:

.. code:: sh

   sudo securedrop-migrate-ssh-group.py

If that emits an error, please send it and the output of ``getent group ssh`` to
:ref:`Support <getting_support>`.

ufw package
-----------

If this fails, it means the migration code in SecureDrop 2.11.0 did not work.

To address it, you can run:

.. code:: sh

    sudo apt-get purge ufw --yes

If that emits an error, please send it to :ref:`Support <getting_support>`.

.. note:: You may receive an OSSEC alert that the ``ufw`` package was installed
   and then removed; it is a known bug and safe to ignore unless the check script
   continues to alert you about ``ufw``.

Free space
----------

There needs to be enough free space on the server to both make a backup
and download the software updates.

You can see how much free space is available on your server by running:

.. code:: sh

    df -h

You should be able to safely run ``sudo apt clean`` to free up some disk space.

If you have any old sources/submissions that are no longer needed, they should be deleted as well.

APT sources
-----------

If this fails, it means an unknown source is being used to install software
on your server.

Please run:

.. code:: sh

    sudo apt-get indextargets

and send the output to :ref:`Support <getting_support>` immediately, so we can diagnose
the severity.

Failing systemd units
---------------------

If this fails, it means a process monitored by systemd is failing.

You can see which process is failing by running:

.. code:: sh

    sudo systemctl list-units

Once you know which unit is failing, run:

.. code:: sh

    sudo systemctl status <name>

to get more information about why it failed.

If you are unsure or need help debugging, please :ref:`contact Support <getting_support>`.
