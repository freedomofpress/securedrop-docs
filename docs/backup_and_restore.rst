Backing Up and Restoring Servers
================================

Maintaining regular backups helps guard against data
loss and hardware failure. Having a recent backup will allow you to redeploy
SecureDrop without changing onion URLs, recreating journalist accounts,
or losing previous submissions from sources.

.. note:: Only the *Application Server* is backed up and restored, including
          historical submissions and both *Source Interface* and *Journalist
          Interface* URLs. The *Monitor Server* needs to be configured from
          scratch in the event of a hardware migration.

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

On the *Application Server*, open a Terminal on the Admin Workstation and run

.. code:: sh

       ssh app sudo du -sh /var/lib/securedrop/store

Compare the output of this command (which approximates the size of a backup
archive) to the amount of free space on your Tails persistent volume
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

Run ``git describe --exact-match`` to verify that your workstation is running
the latest version of  SecureDrop, |version|. If not, you should update it
before proceeding.

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

The backup command will display updates on its progress as the backup is created.
Run time will vary depending on connectivity and the number of submissions
saved on the *Application Server*.

When the backup action is complete, the backup will be stored as a compressed
archive in ``~/Persistent/securedrop/install_files/ansible-base``. The filename
will begin ``sd-backup``, followed by a timestamp of when the backup was
initiated, and ending with ``.tar.gz``. You can find the full path to the backup
archive in the output of the backup command.

.. warning:: The backup file contains sensitive information! It should only
             be stored on the *Admin Workstation*, or on a
             :doc:`dedicated encrypted backup USB <backup_workstations>`.

.. include:: includes/backup-warning.txt

.. _backing_up_logos:

Backing up your custom logo
'''''''''''''''''''''''''''

The backup will not include any custom logo file that you have configured
for your SecureDrop instance. To back up your logo:

1. Open a terminal via **Applications ▸ System Tools ▸ Terminal**.
2. Change into the persistent storage directory: ``cd ~/Persistent``
3. Run the following command:

.. code:: sh

  wget $(grep Exec ~/source.desktop | awk '{print $2}')/org-logo -O logo-backup.png

This will save your current logo file as ``logo-backup.png``.

Restoring from a Backup
-----------------------

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
example, for hardware migration, operating system upgrade, or disaster
recovery purposes), see :ref:`Migrating Using a Backup <migrating>`.

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
for your backup archive.

This command attempts to restore submissions, source and journalist accounts,
and configuration details for the onion services used by the web interfaces and
SSH (if configured).

.. note:: You cannot restore v2 onion service configurations to a v3-only server
   (this includes any SecureDrop installation based on Ubuntu 20.04). If a
   restore operation would leave you without a valid onion service configuration,
   the restore script will fail with an error. In this case, you can still perform
   a data-only restore. See :ref:`Data-only Restores <additional_restore_info>` for more information.

.. _migrating:

Migrating Using a Backup
-------------------------

Moving a SecureDrop instance to new hardware involves:

  - Backing up the old instance and preserving configuration and credentials from the *Admin Workstation*;
  - Installing SecureDrop on new hardware;
  - Restoring the backup to the new instance and repairing credentials.

All new SecureDrop instances must use v3 onion services only, so the final
configuration will only include v3 onion services regardless of the backup state.

The restore process differs based on the onion services that were configured on
the old instance and preserved in the backup:

  - :ref:`Migrating using a v2+v3 or v3-only backup <migrate_v3>`
  - :ref:`Migrating using a v2-only backup <migrate_v2>`

.. _migrate_v3:

Migrating Using a V2+V3 or V3-Only Backup
'''''''''''''''''''''''''''''''''''''''''

.. note::  The instructions below assume that you are using the same *Admin Workstation*
   that was used to manage your old instance. If you are using a new *Admin
   Workstation* you will need to copy the directory ``~amnesia/Persistent/securedrop``
   from the old workstation to the new workstation (using a *Transfer Device*)
   before proceeding.

#. If you have not already done so, :ref:`back up the existing installation <backing_up>`.
   The instructions below assume that the backup has been created
   and renamed ``sd-backup-old.tar.gz``.

#. Move the existing *Admin Workstation* SecureDrop code out of the way, by
   opening a Terminal via **Applications ▸ System Tools ▸ Terminal** and
   running the command:

   .. code:: sh

      mv ~/Persistent/securedrop ~/Persistent/sd.bak

#. Move the existing *Admin Workstation* SSH configuration out of the way via
   the Terminal, using the command:

   .. code:: sh

      find ~/.ssh/ -type f -exec mv {} {}.bak \;

   .. note::
      You will be generating fresh SSH credentials for the servers, and any
      other *Admin Workstation* USBs will have to be
      :ref:`provisioned with updated credentials <repair_admin_usbs>`.

#. Re-clone the SecureDrop repository to the *Admin Workstation* using the following
   Terminal commands:

   .. code:: sh

      cd ~/Persistent
      git clone https://github.com/freedomofpress/securedrop

#. Verify that the current release tag was signed with the release signing key:

   .. code:: sh

      cd ~/Persistent/securedrop/
      git fetch --tags
      git tag -v 1.8.0

   The output should include the following two lines:

   .. code:: sh

      gpg:                using RSA key 22245C81E3BAEB4138B36061310F561200F4AD77
      gpg: Good signature from "SecureDrop Release Signing Key"


   .. important::
      If you do not see the message above, signature verification has failed
      and you should **not** proceed with the installation. If this happens,
      please contact us at securedrop@freedom.press.


   Verify that each character of the fingerprint matches what is on the
   screen of your workstation. If it does, you can check out the new release:

   .. code:: sh

      git checkout 1.8.0

   .. important::
      If you see the warning ``refname '1.8.0' is ambiguous`` in the
      output, we recommend that you contact us immediately at
      securedrop@freedom.press
      (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__).

#. Copy the old instance's configuration files and backup from
   ``~/Persistent/sd.bak`` into ``~/Persistent/securedrop`` using the following
   Terminal commands:

   .. code:: sh

      cd ~/Persistent/securedrop
      export SD_OLD=~/Persistent/sd.bak/install_files/ansible-base
      export SD_NEW=~/Persistent/securedrop/install_files/ansible-base
      cp $SD_OLD/group_vars/all/site-specific $SD_NEW/group_vars/all/
      cp $SD_OLD/tor_v3_keys.json $SD_NEW/
      cp $SD_OLD/sd-backup-old.tar.gz $SD_NEW/

   You will also need to copy the old instance's *Submission Public Key*,
   *OSSEC Alert Public Key*, and, if configured, the *Journalist Alert Public Key*.
   Assuming that these are named ``SecureDrop.asc``, ``ossec.asc``, and
   ``journalist.asc`` respectively, run the following commands:

   .. code:: sh

      cp $SD_OLD/SecureDrop.asc $SD_NEW/
      cp $SD_OLD/ossec.asc $SD_NEW/
      cp $SD_OLD/journalist.asc $SD_NEW/

#. *(Optional):* If your old instance was configured to provide the *Source
   Interface* via HTTPS, you should also copy across the certificate, certificate
   key, and chain file. Assuming that these are named ``sd.crt``, ``sd.key``, and
   ``ca.crt`` respectively, run the following commands:

   .. code:: sh

      cp $SD_OLD/sd.{crt,key} $SD_NEW/
      cp $SD_OLD/ca.crt $SD_NEW/

#. Ensure your *Admin Workstation* is connected to a LAN port on your
   network firewall, and
   :ref:`configure the Admin Workstation's IP address <assign_static_ip_to_workstation>`.

#. Install Ubuntu 20.04 on the *Application* and *Monitor Servers*, following
   the :doc:`server setup instructions<servers>` to install with the correct
   settings, test connectivity, and set up SSH keys to allow for
   *Admin Workstation* access.

#. Reinstall SecureDrop on the servers, following the :doc:`installation
   instructions <install>`. During the configuration stage
   (``./securedrop-admin sdconfig``), the values will be prepopulated based on
   the old instance's configuration. Press **Enter** to accept each value,
   except when you are asked if you want to enable v2 onion services: there,
   ensure the answer is ``no``.

   Proceed through the installation, finishing with
   ``./securedrop-admin tailsconfig``. If SSH-over-Tor is configured, run
   ``ssh app uptime`` and ``ssh mon uptime``  in the Terminal to verify SSH
   connectivity.

#. Restore from the old instance's backup (e.g. ``sd-backup-old.tar.gz``) using
   the Terminal command:

   .. code:: sh

       ./securedrop-admin restore sd-backup-old.tar.gz

   The restore task will proceed for some time, removing v2 services if a v2+v3
   backup was used, and then will fail with the message:

   .. code-block:: none

     ssh_exchange_identification: Connection closed by remote host

   during the ``Wait for Tor to reload`` task. This is expected; the
   *Application Server*'s SSH onion service address was updated to the old
   instance's address during the restore process, leaving it temporarily
   unreachable.

#. Copy the old instance's v3 onion service details into place on the
   *Admin Workstation* and repair SSH access using the Terminal commands:

   .. code:: sh

      cd ~/Persistent/securedrop
      cp $SD_OLD/app-{journalist,ssh}.auth_private $SD_NEW/
      cp $SD_OLD/app-sourcev3-ths $SD_NEW/
      ./securedrop-admin tailsconfig

#. :doc:`Test the new instance <test_the_installation>` to verify that the
   web interfaces are available and the servers can be reached via SSH.

#. If you had previously configured a custom logo for your SecureDrop instance,
   :ref:`upload it again <Updating Logo Image>` using the *Admin Interface*.

#. If you have migrated to new hardware, ensure your old servers have been
   decommissioned and/or destroyed by following the relevant sections of
   :doc:`our decommissioning documentation <decommission>`.

.. _repair_admin_usbs:

Repair Additional Admin Workstations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you have additional *Admin Workstation* USBs, they will no longer have
valid SSH credentials and will need to be repaired. In these steps, the "primary
*Admin Workstation*" is the one which you used to complete the above migration
process.

#. Prepare a fresh
   :doc:`LUKS-encrypted USB <set_up_transfer_and_export_device>`.
   You may record the passphrase in your primary *Admin Workstation*
   KeePassXC password manager.

#. Copy the following files from your primary *Admin Workstation* onto the
   LUKS-encrypted USB:

   - ``~/Persistent/securedrop/install_files/ansible-base/tor_v3_keys.json``
   - ``~/Persistent/securedrop/install_files/ansible-base/mon-ssh.auth_private``
   - ``~/.ssh/id_rsa.pub``
   - ``~/.ssh/id_rsa`` |br| |br|

   .. note::
      Alternatively, if you wish to use different SSH credentials for each
      *Admin Workstation*, you may do so. In this case, copy only the first two
      files above to your additional *Admin Workstations*.

      Generate per-machine SSH keys and use a clean LUKS-encrypted USB drive
      to transfer the public portions of those keys to your primary
      *Admin Workstation*, where you will then add them to the servers'
      ``authorized_keys`` files, as described :ref:`here <ssh_add_pubkey>`.
      You may also `contact Support`_ for assistance.

#. Boot into each additional *Admin Workstation*. Set
   `an administration password`_
   and unlock the persistent volume on the Tails welcome screen.
   Once logged in, attach the LUKS-encrypted USB
   and unlock it.

#. Ensure that this *Admin Workstation* is using an up-to-date version of Tails
   and is running the latest SecureDrop application code, |version|.

#. As you did with the primary *Admin Workstation*, archive the existing
   SSH configuration:

   .. code:: sh

       find ~/.ssh/ -type f -exec mv {} {}.bak \;

#. From the LUKS-encrypted USB, copy ``~/.ssh/id_rsa`` and
   ``~/.ssh/id_rsa.pub`` to the ``~/.ssh/`` directory.

#. From the LUKS-encrypted USB, copy ``tor_v3_keys.json`` and
   ``mon-ssh.auth_private`` to the
   ``~/Persistent/securedrop/install_files/ansible-base`` directory.

#. In the Terminal, type the following commands:

   .. code:: sh

      cd ~/Persistent/securedrop
      ./securedrop-admin tailsconfig

#. Test connectivity to each server by running ``ssh app uptime``
   and ``ssh mon uptime``.

#. Once all *Admin Workstations* have been updated, securely wipe the files on
   the LUKS-encrypted USB, by right-clicking them in the file manager and selecting
   **Wipe**. Then, reformat the device using the
   **Disks** utility.

.. _contact Support: https://securedrop-support.readthedocs.io/en/latest/
.. _an administration password: https://tails.boum.org/doc/first_steps/welcome_screen/administration_password

.. _migrate_v2:

Migrating Using a V2-Only Backup
''''''''''''''''''''''''''''''''

V2 onion services are no longer supported for new SecureDrop installs, so
*Source* and *Journalist Interface* addresses will change when you perform a
migration using a v2-only backup. However, it is possible to migrate submissions,
source accounts, and journalist accounts. To do so, follow the steps below:

.. note:: The instructions below assume that you are using the same
  *Admin Workstation*
  that was used to manage your old instance. If you are using a new
  *Admin Workstation* you will need to copy the directory
  ``~amnesia/Persistent/securedrop``
  from the old workstation to the new workstation (using a *Transfer Device*)
  before proceeding.

#. If you have not already done so,
   :ref:`back up the existing installation <backing_up>`.
   The instructions below assume that the backup has been created and
   renamed ``sd-backup-old.tar.gz``.

#. Move the existing *Admin Workstation* SecureDrop code out of the way, by
   opening a Terminal via **Applications ▸ System Tools ▸ Terminal** and
   running the command:

   .. code:: sh

      mv ~/Persistent/securedrop ~/Persistent/sd.bak

#. Move the existing *Admin Workstation* SSH configuration out of the way via
   the Terminal, using the commands:

   .. code:: sh

       find ~/.ssh/ -type f -exec mv {} {}.bak \;

#. Reinstall SecureDrop on the *Admin Workstation* using the following Terminal
   commands:

   .. code:: sh

      cd ~/Persistent
      git clone https://github.com/freedomofpress/securedrop

#. Verify that the current release tag was signed with the release signing key:

   .. code:: sh

      cd ~/Persistent/securedrop/
      git fetch --tags
      git tag -v 1.8.0

   The output should include the following two lines:

   .. code:: sh

      gpg:                using RSA key 22245C81E3BAEB4138B36061310F561200F4AD77
      gpg: Good signature from "SecureDrop Release Signing Key"


   .. important::
       If you do not see the message above, signature verification has failed
       and you should **not** proceed with the installation. If this happens,
       please contact us at securedrop@freedom.press.

   Verify that each character of the fingerprint matches what is on the
   screen of your workstation. If it does, you can check out the new release:

   .. code:: sh

      git checkout 1.8.0


   .. important::
      If you see the warning ``refname '1.8.0' is ambiguous`` in the
      output, we recommend that you contact us immediately at
      securedrop@freedom.press (`GPG encrypted <https://securedrop.org/sites/default/files/fpf-email.asc>`__).

#. Copy the old instance's configuration files and backup from ``~/Persistent/sd.bak`` into ``~/Persistent/securedrop`` using the following Terminal commands:

   .. code:: sh

      cd ~/Persistent/securedrop
      export SD_OLD=~/Persistent/sd.bak/install_files/ansible-base
      export SD_NEW=~/Persistent/securedrop/install_files/ansible-base
      cp $SD_OLD/group_vars/all/site-specific $SD_NEW/group_vars/all/
      cp $SD_OLD/sd-backup-old.tar.gz $SD_NEW/

   You will also need to copy the old instance's *Submission Public Key*,
   *OSSEC Alert Public Key*, and, if configured, the *Journalist Alert Public Key*.
   Assuming that these are named ``SecureDrop.asc``, ``ossec.asc``, and
   ``journalist.asc`` respectively, run the following commands:

   .. code:: sh

      cp $SD_OLD/SecureDrop.asc $SD_NEW/
      cp $SD_OLD/ossec.asc $SD_NEW/

#. Ensure your *Admin Workstation* is connected to a LAN port on your
   network firewall, and
   :ref:`configure the Admin Workstation's IP address <assign_static_ip_to_workstation>`.

#. Install Ubuntu 20.04 on the *Application* and *Monitor Servers*, following
   the :doc:`server setup instructions<servers>` to install with the correct
   settings, test connectivity, and set up SSH keys to allow for
   *Admin Workstation* access.

#. Reinstall SecureDrop on the servers, following the :doc:`installation
   instructions <../install>`. During the configuration stage
   (``./securedrop-admin sdconfig``), the values will be prepopulated based on
   the old instance's configuration. Press **Enter** to accept each value,
   except for the the v2 and v3 onion service options - type ``no`` for v2 and
   ``yes`` for v3.

   .. note:: if your old instance served the *Source Interface* over HTTPS,
      you will need to set up your new instance using HTTP instead, and update
      it to use HTTPS after the initial migration. The web interface addresses
      change as part of the process, and so your certificate is no longer valid.

   Proceed through the installation, finishing with
   ``./securedrop-admin tailsconfig``. If SSH-over-Tor is configured, run
   ``ssh app uptime`` and ``ssh mon uptime``  in the Terminal to verify SSH
   connectivity and add the new onion URLs to your ``known_hosts`` file.

#. Restore from the old instance's backup (e.g. ``sd-backup-old.tar.gz``) using
   the Terminal command:

   .. code:: sh

       ./securedrop-admin restore --preserve-tor-config sd-backup-old.tar.gz

   The new instance's onion service addresses will be unchanged, but the
   old instance's data and accounts will now be available.

#. As part of this process, your .onion URLs have changed, and *Journalist* and
   *Admin Workstations* will be out of date, and will need to be
   :ref:`updated <update_tails_v3>`.

#. If you had previously configured a custom logo for your SecureDrop instance,
   :ref:`upload it again <Updating Logo Image>` using the *Admin Interface*.

#. If you have migrated to new hardware, ensure your old servers have been
   decommissioned and/or destroyed by following the relevant sections of
   :doc:`our decommissioning documentation <decommission>`.

.. _additional_restore_info:

Additional Information
----------------------

.. _restore_preserve_tor_config:

Data-Only Restores
''''''''''''''''''

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
.. |br| raw:: html

    <br>
