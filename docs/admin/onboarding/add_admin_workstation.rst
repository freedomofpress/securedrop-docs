Provision additional Admin Workstation
======================================

Caveats for managing configuration updates with multiple Admin Workstations
---------------------------------------------------------------------------

Organizations with multiple Admin Workstations should set up a way to synchronize any changes one Administrator makes to the server configuration, as by default those changes are stored only on their individual Admin Workstation.

Configuration changes will be flagged by OSSEC and will generate alerts, but if other Administrators don't regularly review OSSEC alerts they may miss important changes, such as an update to the Submission Public Key. If they subsequently run ``securedrop-admin install`` from their Admin Workstation, they will revert the server configuration to an older version.

The simplest approach to keeping workstations in sync is to inform other Administrators of changes as you make them, for example via a secure Signal group chat. Any such communications should happen over a platform that provides E2EE, as you may need to share sensitive information.

Configuration information is stored on the Admin Workstation in ``sd-admin`` under ``~/.config/securedrop-admin``:

- ``~/.config/securedrop-admin/site-specific`` contains settings written by ``securedrop-admin localconfig`` - if it is changed other Administrators should be notified.
- The Submission Public Key and OSSEC Alert Public Key should be present under ``~/.config/securedrop-admin``. If these keys are rotated, the public keys should be updated on other Admin Workstations.
- Onion Service information is stored in several files in ``sd-app``: ::

    ~/.config/securedrop-admin/app-ssh.auth_private
    ~/.config/securedrop-admin/mon-ssh.auth_private
    ~/.config/securedrop-admin/app-journalist.auth_private
    ~/.config/securedrop-admin/app-sourcev3-ths
    ~/.config/securedrop-admin/tor_v3_keys.json

- If Onion Service addresses are changed, the files listed above should be shared securely with other Administrators - preferably in person using an :doc:`encrypted USB flash drive</admin/onboarding/provisioning_usb>`, as they can be used to access the servers directly via SSH over Tor.

Overview
--------

Provisioning additional Admin Workstations is done using a backup and restore mechanism, in lieu of repeating the :doc:`initial installation instructions</admin/installation/index>`. Qubes OS provides integrated tools for making and restoring backups which are leveraged here to ensure your SecureDrop's secret keys and stored Source messages are safely transferred onto new Workstations.

At a high level, this process entails installing Qubes OS and the SecureDrop packages on a new laptop, making a fresh backup of an existing Admin Workstation, and then restoring that backup onto the new laptop. 

The entire provisioning process will take several hours to complete. You may provision multiple Admin Workstations using a single backup, but keep in mind this backup will contain credentials such as your Server SSH keys. You must take the same care with storing this backup as you would with any Workstation or Workstation backup, and you should :ref:`securely erase<admin_provision_destroy_backup_medium>` it after provisioning is completed. 

.. include:: /includes/workstation-backups.txt

1. Create a backup of an existing Admin Workstation
--------------------------------------------------------

Start with an existing Admin Workstation or combined Admin + Journalist Workstation.

Select qubes to back up
~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _select_qubes_backup:
  :end-before: .. _select_qubes_backup_end:

- ``sd-admin``
- ``sd-admin-vault``
- any customized qubes that you may wish to preserve, and their templates (optional)

Perform the backup
~~~~~~~~~~~~~~~~~~

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _perform_backup_sdw:
  :end-before: .. _backup_admin_workstation:

2. Create Qubes OS installation media
------------------------------------------------

If you have a **Qubes 4.3** installation drive that you recently created and verified, such as during the initial installation of SecureDrop or to provision a Workstation, you can skip to :ref:`admin_install_qubes_securedrop_packages`

Preparing your everyday computer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /admin/installation/prepare_installation_media.rst
  :start-after: .. _prepare_everyday_computer:
  :end-before: .. _prepare_everyday_computer_end:

Preparing the installation media
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /admin/installation/prepare_installation_media.rst
  :start-after: .. _preparing_installation_media:
  :end-before: .. _download_os_installers:

.. include:: /admin/installation/prepare_installation_media.rst
  :start-after: .. _download_verify_qubes:

.. _admin_install_qubes_securedrop_packages:

3. Install Qubes OS and SecureDrop packages
-------------------------------------------

Install Qubes OS and the SecureDrop packages on your new Journalist Workstation.

.. include:: /admin/installation/install_qubes.rst
    :start-after: .. _apply_bios_updates_settings:
    :end-before: .. _install_qubes_end:

Install SecureDrop Workstation packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /admin/installation/install_qubes.rst
    :start-after: .. _install_securedrop_packages:

4. Restore to new Admin Workstation
----------------------------------------

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _rename_delete_redundant_qubes:
    :end-before: .. _restore_backup_qubes:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _restore_backup_qubes:
    :end-before: .. _restore_backup_qubes_note:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _restore_backup_qubes_note:
    :end-before: .. _reapply_journalist_workstation:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _reapply_admin_workstation:
    :end-before: .. _restore_custom_qubes_rpc:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _restore_custom_qubes_rpc:
    :end-before: .. _destroy_backup_medium:

5. Update credentials
-------------------------

.. _new_admin_update_credentials:

Add new Admin credentials in KeePassXC database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Open the KeePassXC vault in ``sd-admin-vault`` on the new Workstation and delete entries that won't be used by the user of this Workstation.

1. Select each entry and hit the :kbd:`delete` key.
2. After you have deleted all the entires, right-click the **Recycle Bin** item under **Root** in the KeePassXC sidebar, and select **Empty**.

Add to the KeePassXC vault the needed credentials for the user of this new Workstation, such as their Admin Interface login. If it is a new user, you may :doc:`create the new user's account from the Admin Interface</admin/onboarding/add_user>` at this time and save the credentials directly into the KeePassXC vault.

Create new SSH key
~~~~~~~~~~~~~~~~~~

Open a terminal in ``sd-admin`` (|qubes_menu| **▸** ``sd-admin```` **▸ Xfce Terminal**) to fun the following commands:

1. Rename the existing SSH keys:

.. code-block::

  mv ~/.ssh/id_rsa /home/user/.ssh/id_rsa.old
  mv ~/.ssh/id_rsa.pub /home/user/.ssh/id_rsa.pub.old

2. Create new SSH key:

.. code-block::

  ssh-keygen -t rsa -b 4096

3. Add old SSH key to ``ssh-agent``:

.. code-block::

  ssh-add ~/.ssh/id_rsa.old

4. Copy new key to Servers:

.. code-block::

  ssh-copy-id app
  ssh-copy-id mon

5. Delete the old key:

.. code-block::

  rm ~/.ssh/*.old

.. _test_new_admin_workstation:

6. Test new Admin Workstation
----------------------------------

.. TODO, this should borrow from test instructions elsewhere. 

.. _admin_provision_destroy_backup_medium:

7. Destory backup medium
------------------------

Wipe (reformat) the LUKS-encrypted storage device that you used to store the SecureDrop configuration material.

.. include:: /includes/destroy_usb.txt
