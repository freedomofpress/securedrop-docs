Back Up, Restore, Migrate
=========================

Maintaining regular backups helps guard against data 
loss and hardware failure. Having a recent backup will allow you to redeploy
SecureDrop without changing onion URLs, recreating journalist accounts,
or losing previous submissions from sources.

.. note:: Only the *Application Server* is backed up and restored, including
          historical submissions and both *Source Interface* and *Journalist
          Interface* URLs. The *Monitor Server* needs to be 
          configured from scratch in the event of a hardware migration.

Minimizing Disk Use
-------------------

Since the backup and restore operations both involve transferring *all* of
your SecureDrop's stored submissions over Tor, the process can take a long time.

Encouraging journalists to regularly delete older, unneeded submissions from 
the *Journalist Interface* will save time and improve reliability when 
doing backups.

.. tip:: Although it varies, the average throughput of an onion service is
         about 3 Mbps, or roughly 90 minutes for 2GB. Plan your backup and
         restore accordingly.

You can use the following command to determine the volume of submissions
currently on the *Application Server*: log in over SSH and run
``sudo du -sh /var/lib/securedrop/store``.

Compare the output of this command (which approximates the size of 
a backup archive) to the amount of free space on your Tails persistent volume
via Tails' **Disks** utility to ensure you have sufficient space to perform
a backup.

If you find you cannot perform a backup or restore due to this constraint,
and have already deleted old submissions from the *Journalist Interface*,
contact us through the `SecureDrop Support Portal`_.

.. note:: Submissions are deleted asynchronously and one at a time, so
          if you delete a lot of submissions through the *Journalist
          Interface*, it may take a while for all of the submissions
          to actually be deleted. SecureDrop uses ``shred`` to
          securely erase files, which takes significantly more time
          than normal file deletion. You can monitor the progress of
          queued deletion jobs by logging in to the *Application
          Server* over SSH and running::

            sudo journalctl -u securedrop_rqworker


.. _SecureDrop Support Portal: https://support-docs.securedrop.org/

.. _backing_up:

Backing Up
----------

Open a **Terminal** on the *Admin Workstation* and ``cd`` to 
``~/Persistent/securedrop``.

Run ``git describe --exact-match`` to verify that you have a tagged SecureDrop
release, 0.12.0 or newer, checked out. 

Check Connectivity
''''''''''''''''''

Verify that your *Admin Workstation* is able to run Ansible and connect to
the SecureDrop servers.

.. code:: sh

   ssh app uptime

If this command fails, see 
:ref:`Troubleshooting <troubleshooting_admin_connectivity>`.

Create the Backup
'''''''''''''''''

When you are ready to begin the backup, run

.. code:: sh

   ./securedrop-admin backup

The backup action will display itemized progress as the backup is created.
Run time will vary depending on connectivity and the number of submissions
saved on the *Application Server*.

When the backup action is complete, the backup will be stored as a compressed
archive in ``install_files/ansible-base``. The filename will begin ``sd-backup``
followed by a timestamp of when the backup was initiated, and end with
``.tar.gz``. You can find the full path to the backup archive in the output
of backup action.

.. warning:: The backup file contains sensitive information! It should only
             be stored on the *Admin Workstation*, or on a
             :doc:`dedicated encrypted backup USB <backup_workstations>`.

.. include:: includes/backup-warning.txt

Restoring
---------

Prerequisites
'''''''''''''

To perform a restore, boot into the *Admin Workstation* and
ensure that your ``.tar.gz`` backup archive has been copied to
``~/Persistent/securedrop/install_files/ansible-base``.
(If you are using the same *Admin Workstation* as you did when you took the 
backup, the archive will already be in place).

If you are restoring data onto an existing instance (for example, for data 
recovery purposes), see 
:ref:`Restoring a Backup on an Existing Instance <restore_data>`.

If you are reinstalling SecureDrop and then restoring from a backup (for 
example, for hardware migration or disaster recovery purposes), see 
:ref:`Migrating <migrating>`.

For other data recovery scenarios, see 
:ref:`Additional Information <additional_restore_info>` or `contact Support`_.

.. _contact Support: https://securedrop-support.readthedocs.io/en/latest/

.. _restore_data:

Restoring a Backup on an Existing Instance
'''''''''''''''''''''''''''''''''''''''''' 

To restore an existing instance to a previous state, run the command:

.. code:: sh

   ./securedrop-admin restore sd-backup-2020-07-22--01-06-25.tar.gz

Make sure to replace ``sd-backup-2020-07-22--01-06-25.tar.gz`` with the filename
for your backup archive. The backup archives are located in
``install_files/ansible-base``.

This command restores submissions, source and journalist accounts, and Tor
configuration (*Source* and *Journalist Interface* onion URLs) to their state at the 
time of the backup.

.. _migrating:

Migrating
---------

Moving a SecureDrop installation to new hardware consists of:

  - Backing up the existing installation and preserving credentials from the *Admin Workstation*; 
  - Installing the same version of SecureDrop on the new hardware and copying credentials into place;
  - Restoring the backup to the new installation.

The instructions differ depending on which onion services version 
your instance is using.

* :ref:`Instances using v3 onion services <migrate_v3>`
* :ref:`Instances using v2 + v3 onion services <migrate_v2v3>`
* :ref:`Instances using v2 onion services <migrate_v2>`

.. _migrate_v3:

Hardware Migration for Instances Using v3 Onion Services
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#. :ref:`Back up the existing installation <backing_up>`.

#. **Preserve files and credentials**: Create a folder to
   preserve important files from the old installation: 

   .. code:: sh

       mkdir ~/Persistent/sd-restore-creds

   Copy in the following files from ``~/Persistent/securedrop/install_files/ansible-base``:

   -  ``tor_v3_keys.json``
   - All ``.asc`` files (these correspond to your *Submission Public Key*, your OSSEC alerts public key, and (if configured) your journalist alerts public key)
   - The file ``~/Persistent/securedrop/install_files/ansible-base/group-vars/all/site-specific``

   Once you have preserved those files, rename the 
   SecureDrop project root directory to ``securedrop.old``. 

#. **Reinstall SecureDrop on new hardware:** Re-clone the SecureDrop repository.
  
   Copy the ``.asc`` files and the ``tor_v3_keys.json`` file into
   ``~/Persistent/securedrop/install_files/ansible-base``
   and the ``site-specific`` file to 
   ``~/Persistent/securedrop/install_files/ansible-base/group-vars/all/site-specific``.

   Prepare the new :doc:`servers <servers>`, and 
   :doc:`reinstall SecureDrop <install>`. During the configuration 
   stage (``./securedrop-admin sdconfig``), press 
   "Enter" to use the values that are populated for you. Proceed through the 
   installation, finishing with ``./securedrop-admin tailsconfig.``

   If SSH-over-Tor is configured, run ``ssh app`` and ``ssh mon`` to add the
   new onion URLs to your ``known_hosts`` file. 

#. **Restore the backup**: Copy the backup archive (located in 
   ``securedrop.old/install_files/ansible-base``) into the 
   ``install_files/ansible-base`` directory and run

   .. code:: sh
            
       ./securedrop-admin restore sd-backup-<your_backup_file>.tar.gz

#. **Delete temporary files**: Remove any temporary files or directories
   you created as you performed this migration, including the 
   ``securedrop.old`` directory.

.. _migrate_v2v3:

Hardware Migration for Instances Using v2 + v3 Onion Services
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#. :ref:`Back up the existing installation <backing_up>`.

#. **Preserve files and credentials**: Create a folder to
   preserve important files from the old installation: 

   .. code:: sh

       mkdir ~/Persistent/sd-restore-creds

   Copy in the following files from ``~/Persistent/securedrop/install_files/ansible-base``:

   -  ``tor_v3_keys.json``
   - All ``.asc`` files (these correspond to your *Submission Public Key*, your OSSEC alerts public key, and (if configured) your journalist alerts public key
   - The file ``~/Persistent/securedrop/install_files/ansible-base/group-vars/all/site-specific``
   - (optional) ``app-ssh-aths`` and ``mon-ssh-aths``, if you wish to reinstate the ``app-ssh-legacy`` and ``mon-ssh-legacy`` commands
   
   Once you have preserved those files, rename the 
   SecureDrop project root directory to ``securedrop.old``. 

#. **Reinstall SecureDrop on new hardware.** Re-clone the SecureDrop repository.
   Copy the ``.asc`` files and the ``tor_v3_keys.json`` file into
   ``~/Persistent/securedrop/install_files/ansible-base``
   and the ``site-specific`` file to 
   ``~/Persistent/securedrop/install_files/ansible-base/group-vars/all/site-specific``.

   Prepare the new :doc:`servers <servers>`, and 
   :doc:`reinstall SecureDrop <install>`. During the configuration 
   stage (``./securedrop-admin sdconfig``), press 
   "Enter" to use the values that are populated for you. Proceed through the 
   installation, finishing with ``./securedrop-admin tailsconfig.``

   If SSH-over-Tor is configured, run ``ssh app`` and ``ssh mon`` to add the
   new (temporary) onion URLs to your ``known_hosts`` file. 

#. **Restore the backup**: Copy the backup archive (located in 
   ``securedrop.old/install_files/ansible-base``) into the 
   ``install_files/ansible-base`` directory and run

   .. code:: sh
            
       ./securedrop-admin restore sd-backup-<your_backup_file>.tar.gz

#. **Delete temporary files**: Remove any temporary files or directories
   you created as you performed this migration, including the 
   ``securedrop.old`` directory.


.. _migrate_v2:

Hardware Migration for Instances Using v2 Onion Services
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''

.. note:: Support for v2 onion services will be removed from SecureDrop 
          starting in March 2021. We encourage you to migrate to v3 onion 
          services. To do so, follow our 
          :doc:`migration guidelines <v3_services>`, 
          or reinstall SecureDrop with v3 onion services enabled, and 
          follow :ref:`these restore instructions <restore_preserve_tor_config>`.
        
          The instructions for v2 onion services will be removed
          in a future release.

#. :ref:`Back up the existing installation <backing_up>`.

#. **Preserve files and credentials**: Create a folder to
   preserve important files from the old installation: 

   .. code:: sh

       mkdir ~/Persistent/sd-restore-creds

   Copy in the following files from ``~/Persistent/securedrop/install_files/ansible-base``:

   - ``app-source-ths``
   - ``app-journalist-aths``
   - ``app-ssh-aths``
   - your SecureDrop instance's public key (``SecureDrop.asc``, or as named by you)
   - your SecureDrop instance's OSSEC alerts key (``ossec.asc``, or as named by you)
   - your SecureDrop instance's journalist alerts key (``journalist-alerts.asc``, or as named by you)
   - The file ``~/Persistent/securedrop/install_files/ansible-base/group-vars/all/site-specific``

   Once you have preserved those files, rename the 
   SecureDrop project root directory to ``securedrop.old``. 

#. **Reinstall SecureDrop on new hardware.** Re-clone the SecureDrop repository.
   Copy the ``.asc`` files into ``~/Persistent/securedrop/install_files/ansible-base``
   and the ``site-specific`` file to 
   ``~/Persistent/securedrop/install_files/ansible-base/group-vars/all/site-specific``.

   Prepare the new :doc:`servers <servers>`, and 
   :doc:`reinstall SecureDrop <install>`. During the configuration 
   stage (``./securedrop-admin sdconfig``), press 
   "Enter" to use the values that are populated for you. Proceed through the 
   installation, finishing with ``./securedrop-admin tailsconfig.``

   If SSH-over-Tor is configured, run ``ssh app`` and ``ssh mon`` to add the
   new (temporary) onion URLs to your ``known_hosts`` file. 

#. **Restore the backup**: Copy the backup archive (located in 
   ``securedrop.old/install_files/ansible-base``) into the 
   ``install_files/ansible-base`` directory and run

   .. code:: sh
            
       ./securedrop-admin restore sd-backup-<your_backup_file>.tar.gz
    
   The restore task will proceed for some time, and then will fail with the
   message ``ssh_exchange_identification: Connection closed by remote host``   
   during the ``Wait for Tor to reload`` task. This is expected; during the 
   restoration process, the *Application Server*'s onion URL changed, causing it
   to be unreachable.

   Reboot the *Application Server*, or log in via the console and issue the
   command ``sudo service tor reload`` to restart the Tor service.

#. **Obtain Application Server SSH .onion address**: If you are using 
   SSH-over-Tor and are re-using the *Admin Workstation* 
   from your previous installation, you will need to remove the SSH 
   alias created during re-installation, or you will see a host key 
   verification failure warning in the next section.  

   First, obtain the SSH service onion address for the *Application Server.*

   Inspect the ``app-ssh-aths`` file: 

   .. code:: sh

      cat install_files/ansible-base/app-ssh-aths

   This file is in the format ``HidServAuth app_ssh_url Secret # client: admin``.
   The ``app_ssh_url`` portion is your SSH service .onion address for the
   *Application Server*.

#. **Fix Tor Credentials:**
   Type the following command, replacing ``<app_ssh_url>``: with the .onion
   URL you obtained in the previous step.

   .. code:: sh

      ssh-keygen -f "/home/amnesia/.ssh/known_hosts" -R "<app_ssh_url>"

#. **Replace original Tor credentials**: Copy the following files preserved 
   from the old installation into
   ``install_files/ansible-base``, overwriting the existing files of the 
   same name. (If you wish, you may temporarily save the existing files
   to another location outside of the SecureDrop directory before overwriting 
   them).  

   * ``app-source-ths``
   * ``app-journalist-aths``
   * ``app-ssh-aths``

#. **Reconfigure Tor connections**: 
   Run ``./securedrop-admin tailsconfig`` to update the *Admin Workstation*
   to use the restored Onion URLs again, and verify connectivity to the 
   servers and the *Source* and *Journalist Interfaces*. 
   See :doc:`configure_admin_workstation_post_install`
   for further instructions.

#. **Delete temporary files**: Remove any temporary files or directories
   you created as you performed this migration, including the 
   ``securedrop.old`` directory.

.. _additional_restore_info:

Additional Information
----------------------

.. _restore_preserve_tor_config:

Restore Data Without Restoring Tor Configuation 
''''''''''''''''''''''''''''''''''''''''''''''''

The ``restore`` command normally restores both the data and the Tor 
configuration of an instance, including the .onion URLs for your instance.

You may, however, restore data, such as submissions and journalist 
and source accounts, without altering an instance's Tor configuration, with 
the following command:

.. code:: sh

   ./securedrop-admin restore --preserve-tor-config sd-backup-2020-07-22--01-06-25.tar.gz

This is a suitable option if you have a backup archive taken from an instance
with v2 onion services, and wish to restore it to an instance that is now using
v3 onion services. 

If you require any assistance with migration or data recovery, please
`contact Support`_.

.. _contact Support: https://securedrop-support.readthedocs.io/en/latest/


