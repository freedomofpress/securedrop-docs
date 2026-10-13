Migrate Admin Workstation from Tails
=========================================

These steps will create a new Admin Workstation from your existing Tails Admin Workstation USB flash drive. 

Perform these steps on a laptop where you have freshly :doc:`installed Qubes OS and the SecureDrop packages</admin/migration/migrate_install_qubes>` to create a new standalone Admin Workstation.

Perform these steps on an existing SecureDrop Workstation laptop to turn it into a combined Admin + SecureDrop Workstation.

Import from Tails Admin Workstation
-------------------------------------

1. Locate a Tails Admin Workstation USB flash drive. 

2. Connect the USB flash drive to a USB port on the Qubes computer, then use the Devices Widget in the upper right panel to attach it to the ``vault`` qube. There will be 3 listings for the USB flash drive in the widget: one for the base drive, one for the Tails partition (labeled ``Tails``), and a 3rd unlabeled listing (for the persistent volume). Choose the third listing.

3. In the the ``vault`` file manager, select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the persistent volume passphrase to unlock and mount it. When prompted, select the option to **Forget password immediately**.

4. In a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**), run the ``securedrop-manage`` command to import the Admin Workstation settings and credentials:

.. code-block:: sh 

  securedrop-manage --configure --target admin
  
The command will print out the imported details to confirm before proceeding.

5. In the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and shut down the ``sd-admin-vault`` qube (using the Qube widget in the upper right panel). 

.. TODO add manual steps

Copy Administrator KeePassXC database
-------------------------------------

1. Use the Devices Widget in the upper right panel to attach the Tails Admin Workstation USB drive to the ``sd-admin-vault`` qube. As before, there will be 3 listings for the USB flash drive in the widget: one for the base drive, one for the Tails partition (labeled ``Tails``), and a 3rd unlabeled listing (for the persistent volume). Choose the third listing.

3. Launch KeePassXC in ``sd-admin-vault`` (|qubes_menu| **▸ Apps ▸ sd-admin-vault ▸ KeePassXC**). Select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the persistent volume passphrase to unlock and mount it. When prompted, select the option to **Forget password immediately**.

4. Locate the KeePassXC password database. It should be in the ``Persistent`` directory, and will typically be named ``keepassx.kdbx`` or similar.

5. Drag and drop the password database to copy it to the Home directory of ``sd-admin-vault``.

8. In the ``sd-admin-vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the Tails Admin Workstation USB.

9. In the file manager window that displays the home directory, open the copy you made of the password database by double-clicking it.

10. If the database is passwordless, KeePassXC may display a security warning when opening it. To preserve convenient passwordless access, you can protect the database using a key file, via **Database ▸ Database settings ▸ Security ▸ Add additional protection ▸ Add Key File ▸ Generate**. This key file has to be selected when you open the database, but KeePassXC will remember the last selection.

11. Inspect each section of the password database to ensure that it contains only the information required by the Administrator to manage your SecureDrop servers.

12. Close the application window and shut down the ``sd-admin-vault`` qube. 

Install Admin Workstation
-------------------------

.. include:: /admin/installation/install_admin_workstation.rst
  :start-after: .. _install_admin_workstation:

