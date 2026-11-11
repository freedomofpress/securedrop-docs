Provision additional Journalist Workstation
===========================================

Overview
--------

Provisioning additional Journalist Workstations is done using a backup and restore mechanism, in lieu of repeating the :doc:`initial installation instructions</admin/installation/index>`. Qubes OS provides integrated tools for making and restoring backups which are leveraged here to ensure your SecureDrop's secret keys and stored Source messages are safely transferred onto new Workstations.

At a high level, this process entails installing Qubes OS and the SecureDrop packages on a new laptop, making a fresh backup of an existing Journalist Workstation, and then restoring that backup onto the new laptop. 

The entire provisioning process will take several hours to complete. You may provision multiple Journalist Workstations using a single backup, but keep in mind this backup will contain credentials wuch as your SecureDrop's :ref:`Submission Secret Key<glossary_submission_key>` and unencrypted messages and files (depending on how you proceed). You must take the same care with storing this backup as you would with any Workstation or Workstation backup, and you should :ref:`securely erase<journalist_provision_destroy_backup_medium>` it after provisioning is completed. 


.. include:: /includes/workstation-backups.txt

1. Create a backup of an existing Journalist Workstation
--------------------------------------------------------

Start with an existing Journalist Workstation or combined Admin + Journalist Workstation.

Select qubes to back up
~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _select_qubes_backup:
  :end-before: .. _select_qubes_backup_end:

- ``dom0``
- ``sd-journalist-vault``
- the ``sd-app`` qube (optional, but :ref:`recommended for provisioning a new Journalist Workstation<backup_journalist_workstation>`)
- any customized qubes that you may wish to preserve, and their templates (optional)

Perform the backup
~~~~~~~~~~~~~~~~~~

.. include:: /admin/maintenance/workstation/backup_workstations.rst
  :start-after: .. _perform_backup_sdw:
  :end-before: .. _backup_admin_workstation:

2. Create Qubes OS installation media
------------------------------------------------

If you have a **Qubes 4.3** installation drive that you recently created and verified, such as during the initial installation of SecureDrop or to provision a Workstation, you can skip to :ref:`journalist_install_qubes_securedrop_packages`

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

.. _journalist_install_qubes_securedrop_packages:

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

4. Restore to new Journalist Workstation
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
    :start-after: .. _reapply_journalist_workstation:
    :end-before: .. _reapply_admin_workstation:

.. include:: /admin/maintenance/workstation/backup_workstations.rst
    :start-after: .. _restore_custom_qubes_rpc:
    :end-before: .. _destroy_backup_medium:

5. Test new Journalist Workstation
----------------------------------

.. TODO, this should borrow from test instructions elsewhere. 

.. _journalist_provision_destroy_backup_medium:

6. Destory backup medium
------------------------

Wipe (reformat) the LUKS-encrypted storage device that you used to store the SecureDrop configuration material.

.. include:: /includes/destroy_usb.txt
