Provision additional combined Workstation
=========================================

Overview
--------

Provisioning additional combined Admin+ Journalist Workstations is done using a backup and restore mechanism, in lieu of repeating the :doc:`initial installation instructions</admin/installation/index>`. Qubes OS provides integrated tools for making and restoring backups which are leveraged here to ensure your SecureDrop's secret keys and stored Source messages are safely transferred onto new Workstations.

At a high level, this process entails installing Qubes OS and the SecureDrop packages on a new laptop, making fresh backups from existing Workstations, and then restoring that backup onto the new laptop. 

The entire provisioning process will take several hours to complete. You may provision multiple combined Workstations using a single backup, but keep in mind this backup will contain credentials such as your SecureDrop's :ref:`Submission Secret Key<glossary_submission_key>`, Server SSH keys, unencrypted messages and files (depending on how you proceed). You must take the same care with storing this backup as you would with any Workstation or Workstation backup, and you should :ref:`securely erase<combined_provision_destroy_backup_medium>` it after provisioning is completed. 

.. include:: /includes/workstation-backups.txt

If you are starting from a combined Admin + Journalist Workstations, start at :ref:`provision_backup_combined_workstation` and skip :ref:`provision_backup_discrete_workstations`.

Otherwise, if you are starting from *discrete* Admin and Journalist Workstations, start at :ref:`provision_backup_discrete_workstations`.

.. _provision_backup_combined_workstation:

1-A. Create a backup of an existing combined Admin + Journalist Workstation
-----------------------------------------------------------------------------

Grab your combined Admin + Journalist Workstation, start it, and log in to Qubes OS.

Select qubes to back up
~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _select_qubes_backup:
  :end-before: .. _select_qubes_backup_end:

- ``dom0``
- ``sd-journalist-vault``
- the ``sd-app`` qube (optional, but :ref:`recommended for provisioning a new Journalist Workstation<backup_journalist_workstation>`)
- ``sd-admin``
- ``sd-admin-vault``
- any customized qubes that you may wish to preserve, and their templates (optional)

Perform the backup
~~~~~~~~~~~~~~~~~~

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _perform_backup_sdw:
  :end-before: .. _backup_admin_workstation:

Now that you have your backup, skip to :ref:`provision_combined_qubes_install_media`.

.. _provision_backup_discrete_workstations:

1-B. Create backups of existing Admin and Journalist Workstations
------------------------------------------------------------------

You will repeat similar steps to back up both Admin and Journalist Workstations. We recommend using the same LUKS-encrypted backup medium to store the backups from both Workstations.

Back up Admin Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~

Start with the Admin Workstation. Start it and log in to Qubes OS.

Select qubes to back up
^^^^^^^^^^^^^^^^^^^^^^^

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _select_qubes_backup:
  :end-before: .. _select_qubes_backup_end:

- ``sd-admin``
- ``sd-admin-vault``
- any customized qubes that you may wish to preserve, and their templates (optional)

Perform the backup
^^^^^^^^^^^^^^^^^^

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _perform_backup_sdw:
  :end-before: .. _backup_admin_workstation:

Back up Journalist Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now switch to your existing Journalist Workstation. Start it and log in to Qubes OS.

Select qubes to back up
^^^^^^^^^^^^^^^^^^^^^^^

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _select_qubes_backup:
  :end-before: .. _select_qubes_backup_end:

- ``dom0``
- ``sd-journalist-vault``
- the ``sd-app`` qube (optional, but :ref:`recommended for provisioning a new Journalist Workstation<backup_journalist_workstation>`)
- any customized qubes that you may wish to preserve, and their templates (optional)

Perform the backup
^^^^^^^^^^^^^^^^^^^

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _perform_backup_sdw:
  :end-before: .. _backup_admin_workstation:

.. _provision_combined_qubes_install_media:

2. Create Qubes OS installation media
------------------------------------------------

If you have a **Qubes 4.3** installation drive that you recently created and verified, such as during the initial installation of SecureDrop or to provision a Workstation, you can skip to :ref:`combined_install_qubes_securedrop_packages`

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

.. _combined_install_qubes_securedrop_packages:

3. Install Qubes OS and SecureDrop packages
-------------------------------------------

Install Qubes OS and the SecureDrop packages on your new combined Admin + Journalist Workstation.

.. include:: /admin/installation/install_qubes.rst
    :start-after: .. _apply_bios_updates_settings:
    :end-before: .. _install_qubes_end:

Install SecureDrop Workstation packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /admin/installation/install_qubes.rst
    :start-after: .. _install_securedrop_packages:


4. Restore backup to new combined Workstation
---------------------------------------------------------------

You must now restore the following qubes onto your new combined Admin + Journalist Workstation from the backup or backups you created earlier:

1. ``dom0``
2. ``sd-journalist-vault``
3. ``sd-app`` (if opted to included it)
4. ``sd-admin``
5. ``sd--admin-vault``

If you have a single backup from an existing combined Admin + Journalist Workstation, you will restore all of the above qubes from that backup.

If, instead, you have backups from discrete Admin and Journalist Workstations, you will restore qubes 1-3 from the Journalist Workstation and qubes 4-5 from the Admin Workstation in two phases. 

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _restore_backup_qubes_note:
    :end-before: .. _reapply_journalist_workstation:

Restore qubes from a backup
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Repeat these steps to restore qubes from discrete Admin and Journalist Workstation backups if that situation applies to you.

1. Plug in your backup medium, attach it to the ``sys-usb`` qube, and unlock it using the same process as during the backup.
2. Navigate to |qubes_menu| **▸** |qubes_menu_gear| **▸ Qubes Tools ▸ Restore Backup**, and enter the location of the backup file. You do not need to adjust the default Restore options, unless you have made customizations to the backup. 
3. Enter the decryption/verification passphrase, and proceed to restoring the available qubes.

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _rename_delete_redundant_qubes:
    :end-before: .. _restore_backup_qubes:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _reapply_journalist_workstation:
    :end-before: .. _reapply_admin_workstation:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _reapply_admin_workstation:
    :end-before: .. _restore_custom_qubes_rpc:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _restore_custom_qubes_rpc:
    :end-before: .. _destroy_backup_medium:

5. Test new combined Workstation
----------------------------------

.. TODO, this should borrow from test instructions elsewhere. 

.. _combined_provision_destroy_backup_medium:

6. Destory backup medium
------------------------

Wipe (reformat) the LUKS-encrypted storage device that you used to store the SecureDrop configuration material.

.. include:: /includes/destroy_usb.txt
