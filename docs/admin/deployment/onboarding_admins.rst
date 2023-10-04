Onboard Additional Admins
=========================

If you are the only admin for your SecureDrop, you can skip this chapter.
It instructs you how to create additional *Admin Workstation* USB drives.
Each *Admin Workstation* will have its own SSH keypair.

This chapter assumes that you have one working *Admin Workstation*. If you've
not completed that part of the setup yet, see
:doc:`../installation/set_up_admin_tails`.  If your *Admin Workstation* is
corrupted or lost, and you don't have a
:doc:`backup <../maintenance/backup_workstations>`,
see :doc:`../maintenance/rebuild_admin`.

.. important::

   If you make configuration changes on your servers using one
   *Admin Workstation*, they may be overwritten by another *Admin Workstation*
   if its local copy of the configuration is not identical. When working
   with multiple admins, it is therefore important to establish protocols
   for coordinating configuration changes. See :ref:`multiple_admins`.

To onboard an additional administrator, you will need:

- your existing *Admin Workstation* USB drive (referred to as **AW1** below)
- an additional empty USB drive (referred to as **AW2** below)

To set up AW2, follow these steps:

1. Boot AW1, `unlock its persistent volume <https://tails.boum.org/doc/persistent_storage/use/index.en.html>`__,
   and `set an admin password on the welcome screen <https://tails.boum.org/doc/first_steps/welcome_screen/administration_password/>`__
2. Ensure that Tails and the SecureDrop version on AW1 are up-to-date.
   If not, update now by following the :ref:`most recent upgrade guide <latest_upgrade_guide>`.
3. Log into the *Journalist Interface* using your admin credentials, and create
   a new user account with admin rights. Record its passphrase securely;
   you will add it to the password manager on AW2.

   (You will need to on-board the new admin's 2FA device to complete this step.
   If this is not possible yet, you can defer it until later.)
4. Insert the empty AW2 USB drive.
5. Launch the Tails installer (**Applications ▸ Tails ▸ Tails Installer**) and install Tails on AW2.
   This will delete all data on the AW2 USB drive.
6. Shut down AW1.
7. Boot AW2.
8. Configure its persistent volume (**Applications ▸ Tails ▸ Configure persistent volume**).
   Set a unique passphrase for AW2 and record it securely. Enable all persistence options.
9. Reboot AW2, unlock its persistent volume, and set an admin password on the welcome screen.
10. Connect to the Internet.
11. Open the file manager (**Applications ▸ Accessories ▸ Files**).
12. Insert AW1. It should show up in the list of storage devices in the file manager under
    a label like "7.0 GB Encrypted". Click the label and enter the drive
    password when prompted to unlock it.
13. In a terminal, type the following command:

    ``rsync -a --info=progress2 /media/amnesia/TailsData/Persistent/securedrop ~/Persistent``

    This will copy *only* the ``securedrop`` directory from AW1 to AW2.
14. Generate a new keypair on AW2 using the following command:

    ``ssh-keygen -t rsa -b 4096``

    When prompted, store the keypair in the default location.
15. Run the command ``./securedrop-admin tailsconfig`` in ``~/Persistent/securedrop``.

    This will set up desktop shortcuts and SSH access.
16. In a terminal, type the following commands to authorize the newly created SSH keypair
    on your servers:
    
    * ``ssh-add``
    * ``ssh-add /media/amnesia/TailsData/openssh-client/id_rsa``
    * ``ssh-copy-id app``
    * ``ssh-copy-id mon``
    * ``ssh-add -D``
17. From the file manager (**Applications ▸ Accessories ▸ Files**), eject AW1.
18. Confirm that you are able to access ``mon`` and ``app`` via SSH.  The
    following commands should produce the following output::

        amnesia@amnesia:~$ ssh app hostname
        app
        amnesia@amnesia:~$ ssh mon hostname
        mon

19. Confirm that you are able to access the *Source Interface* and the *Journalist
    Interface* using the desktop shortcuts.
20. :ref:`Initialize a passphrase database <keepassxc_setup>` on AW2.
    Store the admin account details using KeePassXC, and other account
    information this admin will need in the course of administering this
    system.
21. Shut down AW2.
22. :doc:`Back up AW2 <../maintenance/backup_workstations>`.

You can now provide AW2 to the new administrator. Ensure that they store the
disk encryption passphrase in a secure manner: in most configurations, it is the
only passphrase that is required to SSH into your servers for anyone who obtains
access to the USB drive.

The SSH keypair on AW2 is unique to that workstation. When offboarding the
administrator, you can manually remove the SSH public key from your admin user's
``~/.ssh/authorized_keys`` on ``app`` and ``mon``. Alternatively, if only a single
*Admin Workstation* is in active use, you can use the ``./securedrop-admin reset_admin_access``
command in ``~/Persistent/securedrop`` to revoke access to all other SSH keys.
See our :doc:`offboarding guide <offboarding>` for more information.
