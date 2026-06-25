Migrating from a Tails-based SecureDrop
=======================================

Pre-install tasks:
~~~~~~~~~~~~~~~~~~

#. Apply BIOS updates and check settings
#. Download and verify Qubes OS
#. Install Qubes OS
#. (Hardware-dependent) Apply USB fixes
#. Apply updates to system templates

Install tasks:
~~~~~~~~~~~~~~

#. Copy the *Submission Key*
#. Copy *Journalist Interface* details
#. Copy SecureDrop login credentials
#. Download and install SecureDrop Workstation
#. Configure SecureDrop Workstation
#. Test the Workstation

.. include:: /admin/installation/prepare_sdw.rst
  :start-after: .. _securedrop_workstation_prerequisites:
  :end-before: .. _securedrop_workstation_preinstall_tasks:

.. include:: /admin/installation/prepare_sdw.rst
  :start-after: .. _securedrop_workstation_preinstall_tasks:
  :end-before: .. _SecureBoot:

.. include:: /admin/installation/prepare_sdw.rst
  :start-after: .. _SecureBoot:
  :end-before: .. _apply_dom0_updates:

.. include:: /admin/installation/prepare_sdw.rst
  :start-after: .. _apply_dom0_updates:
  :end-before: .. _securedrop_workstation_install:

.. include:: /admin/installation/prepare_sdw.rst
  :start-after: .. _securedrop_workstation_install:
  :end-before: .. _download_rpm:

.. include:: /admin/installation/prepare_sdw.rst
  :start-after: .. _download_rpm:
  :end-before: .. _securedrop_workstation_install_securedrop-admin:

Import KeePassXC database
~~~~~~~~~~~~~~~~~~~~~~~~~

If you have a KeePassXC database on your Tails-based *Admin Workstation* USB flash drive, you should copy it to the ``vault`` VM on the new Qubes-based *Admin-Workstation*.

Qubes OS comes with the KeePassXC password manager preinstalled in the ``vault`` VM.  

.. include:: /admin/installation/set_up_keepassxc.rst
  :start-after: .. _keepasscx_template_database:
  :end-before: .. _keepassxc_manual_create_database:


Configure SecureDrop Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now that your new Qubes-based *Admin-Workstation* is prepared, you can proceed with importing the correct SecureDrop server details and *Submission Private Key* from your Tails-based *Journalist Workstation* and *Secure Viewing Station* USB flash drives.

Import *Submission Private Key*
-------------------------------

In order to decrypt submissions, you will need a copy of the
`*Submission Private Key* <https://docs.securedrop.org/en/stable/glossary.html#submission-key>`_
from your SecureDrop instance's *Secure Viewing Station*.

To protect this key and preserve the air gap, you will need to connect the *Secure Viewing Station* USB flash drive to a Qubes VM with no network access, and copy it from there to ``dom0``. You cannot directly copy and paste to the ``dom0`` VM from another VM - instead, follow the steps below:

- First, use the network manager widget in the upper right panel to disable your network connection. These instructions refer to the ``vault`` VM, which has no network access by default, but if the *Secure Viewing Station* is attached to another VM by mistake, this will offer some protection against exfiltration.

- Next, choose |qubes_menu| **▸ Apps ▸ vault ▸ Thunar File Manager** to open the file manager in the ``vault`` VM.

- Connect the *Secure Viewing Station* USB flash drive to a USB port on the Qubes computer, then use the devices widget in the upper right panel to attach it to the ``vault`` VM. There will be three entries for the USB flash drive in the section titled **Data (Block) Devices**. Choose the *unlabeled* entry (*not* the one labeled "TAILS") annotated with a ``sys-usb`` text that ends with a number, like ``sys-usb:sdb2``. That is the persistent volume.

  |Attach TailsData|

- In the the ``vault`` file manager, select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the *Secure Viewing Station* persistent volume passphrase to unlock and mount it. When asked if you would like to forget the password immediately or remember it until you logout, choose the option to **Forget password immediately**.

  .. note::

    You will receive a message that says **Failed to open directory "TailsData"**. This is normal behavior and will not cause any issues with the subsequent steps.

  |Unlock TailsData|

- Open a ``dom0`` terminal via |qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**. Once the terminal window opens, run the following command to import the *Submission Private Key*:

  .. code-block:: sh 

      sdw-admin --configure

  Follow the command prompts to complete *Submission Private Key* import. 

  .. note::
    If there are multiple keys present on the device, ``sdw-admin --configure`` will print the fingerprints of those keys for you to select which to use as the *Submission Private Key*. You can open ``<source interface address>.onion/metadata`` in Tor Browser on another network-connected computer to check the correct key fingerprint used by your SecureDrop instance.

- Once the *Submission Private Key* import is complete, in the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the *Secure Viewing Station* USB flash drive.

- If you were prompted for a passphrase during import, you will now need to remove the passphrase on ``sd-journalist.sec``. See :doc:`/admin/migration/removing_gpg_passphrase`.

.. |Attach TailsData| image:: /admin/migration/images/attach_usb.png
  :width: 100%
.. |Unlock Tailsdata| image:: /admin/migration/images/unlock_tails_usb.png
  :width: 100%

.. _copy_journalist:

Import *Journalist Interface* details
-------------------------------------

SecureDrop Workstation connects to your SecureDrop instance's API via the *Journalist Interface*. In order to do so, it will need the *Journalist Interface* address and authentication info. As the clipboard from another VM cannot be copied into ``dom0`` directly, follow these steps to copy the file into place:

- Locate a Tails-based *Admin Workstation* or *Journalist Workstation* USB flash drive. Both hold the address and authentication info for the *Journalist Interface*; if you also want to copy the *Journalist*'s password database, use the *Journalist Workstation* USB flash drive.

- Connect the USB flash drive to a USB port on the Qubes computer, then use the devices widget in the upper right panel to attach it to the ``vault`` VM. There will be 3 listings for the USB flash drive in the widget: one for the base drive, one for the Tails partition (labeled ``Tails``), and a 3rd unlabeled listing (for the persistent volume). Choose the third listing.

- In the the ``vault`` file manager, select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the persistent volume passphrase to unlock and mount it. When prompted, select the option to **Forget password immediately**.

- In the ``dom0`` terminal, proceed with the next import step of the ``sdw-admin`` command or re-run 

  .. code-block:: sh 

      sdw-admin --configure 

  The command will print out the imported *Journalist Interface* details to confirm before proceeding.

- If you used a Tails-based *Admin Workstation* drive, or you don't intend to copy a password database to this workstation, safely disconnect the USB flash drive now. In the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the USB flash drive.

Copy SecureDrop login credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When launching SecureDrop Inbox must enter their username, passphrase and two-factor code to connect with the SecureDrop server. You can manage these passphrases using the KeePassXC password manager in the ``vault`` VM. If this laptop will be used by more than one *Journalist*, we recommend that you shut down the ``vault`` VM now (using the Qube widget in the upper right panel), skip this section, and use a smartphone password manager instead.

In order to set up KeePassXC for easy use:

- Add KeePassXC to the application menu by selecting it from the list of available apps in |qubes_menu| **▸ Apps ▸ vault ▸ Settings ▸ Applications** and pressing the button labeled **>** (do not press the button labeled **>>**, which will add *all* applications to the menu).

- Launch KeePassXC via |qubes_menu| **▸ Apps ▸ vault ▸ KeePassXC**. When prompted to enable automatic updates, decline. ``vault`` is networkless, so the built-in update check will fail; the app will be updated through system updates instead.

- Close the application.

.. important::

   The password database from the Tails-based *Admin Workstation* contains sensitive credentials not required by *Journalists*. Make sure to copy the credentials from the Tails-based *Journalist Workstation* USB flash drive.

In order to copy a *Journalist*'s login credentials:

- If a Tails-based *Journalist Workstation* USB flash drive is not currently attached, connect it, attach it to the ``vault`` VM, open it in the file manager, and enter its encryption passphrase.

- Locate the password database. It should be in the ``Persistent`` directory, and will typically be named ``keepassx.kdbx`` or similar.

- Open a second ``vault`` file manager window (``Ctrl + N`` in the current window) and navigate to the **Home** directory.

- Drag and drop the password database to copy it.

- In the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the *Journalist Workstation* USB. Close this file manager window.

- In the file manager window that displays the home directory, open the copy you made of the password database by double-clicking it.

- If the database is passwordless, KeePassXC may display a security warning when opening it. To preserve convenient passwordless access, you can protect the database using a key file, via **Database ▸ Database settings ▸ Security ▸ Add additional protection ▸ Add Key File ▸ Generate**. This key file has to be selected when you open the database, but KeePassXC will remember the last selection.

- Inspect each section of the password database to ensure that it contains only the information required by the *Journalist* to log in.

- Close the application window and shut down the ``vault`` VM (using the Qube widget in the upper right panel). At this time, you can also re-enable the network connection using the network manager widget.

Manually importing from Tails drives
------------------------------------

Manually import *Submission Private Key*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If importing the *Submission Private Key*  using ``sdw-admin --configure`` fails, you can also copy the *Submission Private Key* manually.

- Open a ``dom0`` terminal via |qubes_menu| **▸** |qubes_menu_gear| **▸ Other Tools ▸ Xfce Terminal**. Once the terminal window opens, run the following command to list the *Submission Private Key* details, including its fingerprint:

  .. code-block:: sh

    qvm-run --pass-io vault \
      "gpg --homedir /run/media/user/TailsData/gnupg -K --fingerprint"

- Next, run the comand:

  .. code-block:: sh

    qvm-run --pass-io vault \
      "gpg --homedir /run/media/user/TailsData/gnupg --export-secret-keys --armor <SVSFingerprint>" \
      > /tmp/sd-journalist.sec

  where ``<SVSFingerprint>`` is the *Submission Private Key* fingerprint, typed as a single unit without whitespace. This will copy the *Submission Private Key* in ASCII format to a temporary file in dom0, ``/tmp/sd-journalist.sec``.

- Verify the that the file starts with ``-----BEGIN PGP PRIVATE KEY BLOCK-----`` using the command:

  .. code-block:: sh

    head -n 1 /tmp/sd-journalist.sec

- Unmount the *Secure Viewing Station* USB flash drive.

- Run the following command in the ``dom0`` terminal:

  .. code-block:: sh

    sudo cp /tmp/sd-journalist.sec /usr/share/securedrop-workstation-dom0-config/

- You can run ``sdw-admin --configure`` to now import the *Journalist Interface* details and complete configuration. 

  Alternatively, follow the steps below to do so manually. Once both *Submission Private Key* and *Journalist Interface* details are imported, proceed with :ref:`configuring the workstation<manual_configure>`.

.. _manual_copy_journalist: 

Manually import *Journalist Interface* details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If importing the *Journalist Interface* details using ``sdw-admin --configure`` fails, you can copy the configuration file to ``dom0`` manually.

- If your *Journalist Interface* is based on SecureDrop 2.13.0 or later, use the following command:

  .. code-block:: sh

    qvm-run --pass-io vault \
      "cat /run/media/user/TailsData/securedrop-admin/app-journalist.auth_private" \
      > /tmp/journalist.txt

- If your *Journalist Interface* is based on SecureDrop 2.12.10 or earlier, use the following command:

  .. code-block:: sh

    qvm-run --pass-io vault \
            "cat /run/media/user/TailsData/Persistent/securedrop/install_files/ansible-base/app-journalist.auth_private" \
      > /tmp/journalist.txt

- Verify that the ``/tmp/journalist.txt`` file on ``dom0`` contains valid configuration information using the command ``cat /tmp/journalist.txt`` in the ``dom0`` terminal.

- Proceed with :ref:`configuring the workstation<manual_configure>`


If you encounter a validation error due to a password-protected GPG key, see :doc:`/admin/migration/removing_gpg_passphrase`.

.. _manual_configure:

Once the *Journalist Interface* details and *Submission Private Key* have been copied to ``dom0``, you can create the configuration for the SecureDrop Workstation.

- Your *Submission Private Key* has a unique fingerprint required for the configuration. Obtain the fingerprint by using this command:

  .. code-block:: sh

    gpg --with-colons --import-options import-show --dry-run --import /tmp/sd-journalist.sec

  The fingerprint will be on a line that starts with ``fpr``. For example, if the output included the line ``fpr:::::::::65A1B5FF195B56353CC63DFFCC40EF1228271441:``, the fingerprint would be the character sequence ``65A1B5FF195B56353CC63DFFCC40EF1228271441``.

- Next, create the SecureDrop Workstation configuration file:

  .. code-block:: sh

    cd /usr/share/securedrop-workstation-dom0-config
    sudo cp config.json.example config.json

- The ``config.json`` file must be updated with the correct values for your instance. Open it with root privileges in a text editor such as ``vi`` or ``nano`` and update the following fields' values:

  - **submission_key_fpr**: use the value of the *Submission Private Key* fingerprint as displayed above
  - **hidserv.hostname**: use the hostname of the *Journalist Interface*, including the ``.onion`` TLD
  - **hidserv.key**: use the private v3 *Onion Service* authorization key value
  - **environment**: use the value ``prod``

.. note::

   You can find the values for the **hidserv.*** fields in the ``/tmp/journalist.txt`` file that you created in ``dom0`` earlier.
   The file will be formatted as follows:

   .. code-block:: none

     ONIONADDRESS:descriptor:x25519:AUTHTOKEN

- Verify that the configuration is valid using the command below in the ``dom0`` terminal:

  .. code-block:: sh

    sdw-admin --validate

.. include:: /admin/installation/apply_sdw.rst
  :start-after: .. _install_configure_securedrop_app:
  :end-before: .. _Password Management Section:

.. include:: /admin/installation/apply_sdw.rst
  :start-after: .. _Password Management Section: