Migrate Journalist Workstation from Tails
=============================================

These steps will create a new Journalist Workstation from your existing Tails Journalist Workstation USB flash drive. 

- Typically you will perform these steps on a laptop where you have freshly :doc:`installed Qubes OS and the SecureDrop packages</admin/migration/migrate_install_qubes>` to create a new standalone Journalist Workstation.

- Alternatively, you may perform these steps on an :doc:`existing Admin Workstation</admin/migration/admin_migration>` laptop to turn it into a combined Admin + Journalist Workstation.

Import Submission Private Key
-----------------------------

In order to decrypt submissions, you will need a copy of the `Submission Private Key <https://docs.securedrop.org/en/stable/glossary.html#submission-key>`_ from your SecureDrop instance's Secure Viewing Station (SVS).

To protect this key and preserve the air gap, you will need to connect the SVS USB to a qube with no network access, and copy it from there to ``dom0``. You cannot directly copy and paste to ``dom0`` - instead, follow the steps below:

1. Use the Network Manager widget in the upper right panel to disable your network connection. These instructions refer to the ``vault`` qube, which has no network access by default, but if the SVS USB is attached to another qube by mistake, this will offer some protection against exfiltration.

2. Choose |qubes_menu| **▸ Apps ▸ vault ▸ Thunar File Manager** to open the file manager in the ``vault`` qube.

3. Connect the SVS USB to a USB port, then use the Devices Widget in the upper right panel to attach it to the ``vault`` qube. There will be three entries for the USB in the section titled **Data (Block) Devices**. Choose the *unlabeled* entry (*not* the one labeled "TAILS") annotated with a ``sys-usb`` text that ends with a number, like ``sys-usb:sdb2``. That is the persistent volume.

|Attach TailsData|

4. In the the ``vault`` file manager, select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the SVS persistent volume passphrase to unlock and mount it. When asked if you would like to forget the password immediately or remember it until you logout, choose the option to **Forget password immediately**.

.. note::

  You will receive a message that says **Failed to open directory "TailsData"**. This is normal behavior and will not cause any issues with the subsequent steps.

|Unlock TailsData|

5. Open a ``dom0`` terminal via |qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**. Once the terminal window opens, run the following command to import the submission key:

.. code-block:: sh 

    securedrop-manage --configure --target journalist

Follow the command prompts to complete submission key import. 

.. note::
  If there are multiple keys present on the device, ``sdw-admin --configure`` will print the fingerprints of those keys for you to select which to use as the submission private key. You can open ``<source interface address>.onion/metadata`` in Tor Browser on another network-connected computer to check the correct key fingerprint used by your SecureDrop instance.

6. Once the submission key import is complete, in the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the SVS USB.

7. If you were prompted for a passphrase during import, you will now need to remove the passphrase on ``sd-journalist.sec``. See :doc:`/admin/migration/removing_gpg_passphrase`.

.. _copy_journalist:

Import Onion Service details
-----------------------------

SecureDrop Inbox connects to your SecureDrop's authenticated :ref:`Onion Service<glossary_onion_service>` to sync messages and files from Sources and Journalist replies. In order to do so, it will need the Onion Service address and authentication info. As the clipboard from another qube cannot be copied into ``dom0`` directly, follow these steps to copy the file into place:

1. Locate an Tails Admin Workstation or Tails Journalist Workstation USB drive. Both hold the Onion Service address and authentication token; if you also want to copy the journalist user's password database, use the Tails Journalist Workstation USB drive.

2. Connect the USB drive to a USB port on the Qubes computer, then use the Devices Widget in the upper right panel to attach it to the ``vault`` qube. There will be 3 listings for the USB in the widget: one for the base USB, one for the Tails partition on the USB, labeled ``Tails``, and a 3rd unlabeled listing, for the persistent volume. Choose the third listing.

3. In the the ``vault`` file manager, select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the persistent volume passphrase to unlock and mount it. When prompted, select the option to **Forget password immediately**.

4. In a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**), run the ``securedrop-manage`` command to import the Onion Service address and authentication token:

.. code-block:: sh 

    securedrop-manage --configure --target journalist

The command will print out the imported details to confirm before proceeding.

5. If you used an Tails Admin Workstation USB drive, or you don't intend to copy a password database to this workstation (below), safely disconnect the USB drive now. In the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the USB drive.

Copy Journalist KeePassXC database
----------------------------------

Journalists must enter their SecureDrop username, passphrase and two-factor code to log in to SecureDrop Inbox. You can manage these passphrases using the KeePassXC password manager in the ``vault`` qube. If this laptop will be used by more than one journalist, we recommend that you shut down the ``vault`` qube now (using the Qube widget in the upper right panel), skip this section, and use a smartphone password manager instead.

In order to set up KeePassXC for easy use:

1. Add KeePassXC to the application menu by selecting it from the list of available apps in |qubes_menu| **▸ Apps ▸ vault ▸ Settings ▸ Applications** and pressing the button labeled **>** (do not press the button labeled **>>**, which will add *all* applications to the menu).

2. Launch KeePassXC (|qubes_menu| **▸ Apps ▸ vault ▸ KeePassXC**). When prompted to enable automatic updates, decline. ``vault`` is networkless, so the built-in update check will fail; the app will be updated through system updates instead.

3. Close the application.

.. important::

   The Tails Admin Workstation password database contains sensitive credentials not required by journalist users. Make sure to copy the credentials from the Tails Journalist Workstation USB.

4. If a Tails Journalist Workstation USB is not currently attached, connect it, attach it to the ``vault`` qube, open it in the file manager, and enter its encryption passphrase.

5. Locate the password database. It should be in the ``Persistent`` directory, and will typically be named ``keepassx.kdbx`` or similar.

6. Open a second ``vault`` file manager window (:kbd:`Ctrl + N` in the current window) and navigate to the **Home** directory.

7. Drag and drop the password database to copy it.

8. In the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the Tails Journalist Workstation USB. Close this file manager window.

9. In the file manager window that displays the home directory, open the copy you made of the password database by double-clicking it.

10. If the database is passwordless, KeePassXC may display a security warning when opening it. To preserve convenient passwordless access, you can protect the database using a key file, via **Database ▸ Database settings ▸ Security ▸ Add additional protection ▸ Add Key File ▸ Generate**. This key file has to be selected when you open the database, but KeePassXC will remember the last selection.

11. Inspect each section of the password database to ensure that it contains only the information required by the journalist user to log in.

12. Close the application window and shut down the ``vault`` qube (using the Qube widget in the upper right panel). At this time, you can also re-enable the network connection using the network manager widget.

.. include:: /admin/installation/install_journalist.rst
  :start-after: .. _install_securedrop_workstation:
  :end-before: .. _end_install_securedrop_workstation:

Test new Journalist Workstation
--------------------------------

.. TODO

Decommission Tails Journalist Workstation
-----------------------------------------

.. TODO

.. include:: /includes/destroy_usb.txt

.. |Attach TailsData| image:: images/attach_usb.png
  :width: 100%
.. |Unlock Tailsdata| image:: images/unlock_tails_usb.png
  :width: 100%