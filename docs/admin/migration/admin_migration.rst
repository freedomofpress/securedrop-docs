Migrating Admin Workstation from Tails
=======================================

Configure Admin Workstation
---------------------------

These steps will create an Admin Workstation from your existing Tails Admin Workstation UBS flash drive. 

Perform these steps on a laptop where you have freshly :doc:`installed Qubes OS and the SecureDrop packages</admin/migration/migrate_install_qubes>` to create a new standalone Admin Workstation.

Perform these steps on an :doc:`existing SecureDrop Workstation laptop` to turn it into a combined Admin + SecureDrop Workstation.

Import from Tails Admin Workstation
-------------------------------------

1. Locate a Tails Admin Workstation USB flash drive. 

2. Connect the USB flash drive to a USB port on the Qubes computer, then use the Devices Widget in the upper right panel to attach it to the ``vault`` qube. There will be 3 listings for the USB flash drive in the widget: one for the base drive, one for the Tails partition (labeled ``Tails``), and a 3rd unlabeled listing (for the persistent volume). Choose the third listing.

3. In the the ``vault`` file manager, select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the persistent volume passphrase to unlock and mount it. When prompted, select the option to **Forget password immediately**.

4. In a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**), run the ``securedrop-manage`` command to import the Admin Workstation settings and credentials:

.. code-block:: sh 

  securedrop-manage --configure --target admin
  
The command will print out the imported Admin Interface details to confirm before proceeding.

5. Use the ``vault`` file manager to copy your KeePassXC database from the USB drive to the ``sd-admin-vault`` qube. 

6. If you don't intend to Safely disconnect the USB flash drive now. In the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the USB flash drive.

.. TODO add manual steps

Install Admin Workstation
-------------------------

.. include:: /admin/installation/install_admin_workstation.rst
  :start-after: .. _install_admin_workstation:

