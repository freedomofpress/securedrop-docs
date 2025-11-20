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

1. Boot AW1, `unlock its persistent volume <https://tails.net/doc/persistent_storage/use/index.en.html>`__,
   and `set an admin password on the welcome screen <https://tails.net/doc/first_steps/welcome_screen/administration_password/>`__
2. Ensure that Tails and the SecureDrop version on AW1 are up-to-date.
   If not, update now by following the :ref:`most recent upgrade guide <latest_upgrade_guide>`.
3. Log into the *Journalist Interface* using your admin credentials, and create
    a new user account with admin rights. Record its passphrase securely;
    you will add it to the password manager on AW2 in step 11.

    (You will need to on-board the new admin's 2FA device to complete this step.
    If this is not possible yet, you can defer it until later.)
4. Insert the empty AW2 USB drive.
5. Launch the Tails Cloner (**Apps ▸ Tails ▸ Tails Cloner**).
   Select the option to **Clone the current Tails.** This will delete all data on the AW2 USB drive.
6. Check the box marked **Clone the current Persistent Storage.**
7. Click **Install**.
8. Choose a unique passphrase for the new Persistent Storage Volume on AW2
   (a 6-word Diceware passphrase is recommended) and record it securely.
9. Shut down AW1.
10. Boot AW2 and unlock the Persistent Storage.
11. Open the KeePassXC database, delete unneeded credentials from AW1, 
    right-click the **Recycle Bin** item under **Root** in the KeePassXC sidebar,
    and select **Empty recycle bin**. Then, store the new account credentials you
    created in step 3.
12. Generate a new keypair on AW2 using the following command:

    ``ssh-keygen -t rsa -b 4096``

    When prompted, store the keypair in the default location.
13. Run the command ``securedrop-admin localconfig``.

    This will set up the *SecureDrop Menu* and SSH access.
14. 

    a. Insert AW1. It should show up in the list of storage devices in the file manager under
       a label like "7.0 GB Encrypted". Click the label and enter the drive
       password when prompted to unlock it.
    b. In a terminal, type the following commands to authorize the newly created SSH keypair
       on your servers:

       * ``ssh-add``
       * ``ssh-add /media/amnesia/TailsData/openssh-client/id_rsa``
       * ``ssh-copy-id app``
       * ``ssh-copy-id mon``
       * ``ssh-add -D``
    c. From the file manager (**Apps ▸ Accessories ▸ Files**), eject AW1.

15. Confirm that you are able to access ``mon`` and ``app`` via SSH. The
    following commands should produce the following output::

        amnesia@amnesia:~$ ssh app hostname
        app
        amnesia@amnesia:~$ ssh mon hostname
        mon
        
16. Confirm that you are able to access the *Source Interface* and the *Journalist
    Interface* using the *SecureDrop Menu*.
17. :ref:`Initialize a passphrase database <keepassxc_setup>` on AW2.
    Store the admin account details using KeePassXC, and other account
    information this admin will need in the course of administering this
    system.
18. Shut down AW2.
19. :doc:`Back up AW2 <../maintenance/backup_workstations>`.

You can now provide AW2 to the new administrator. Ensure that they store the
disk encryption passphrase in a secure manner: in most configurations, it is the
only passphrase that is required to SSH into your servers for anyone who obtains
access to the USB drive.

The SSH keypair on AW2 is unique to that workstation. When offboarding the
administrator, you can manually remove the SSH public key from your admin user's
``~/.ssh/authorized_keys`` on ``app`` and ``mon``. Alternatively, if only a single
*Admin Workstation* is in active use, you can use the ``securedrop-admin reset_admin_access``
command to revoke access to all other SSH keys.
See our :doc:`offboarding guide <offboarding>` for more information.
