Migrating Admin Workstation from Tails
=======================================

Install Qubes OS and SecureDrop packages
----------------------------------------
.. TODO Overview and summary?

.. Include installing Qubes and securedrop-manage
.. include:: /admin/installation/install_qubes.rst
  :start-after: .. _qubes_prerequisites:

Configure Admin Workstation
--------------------------------

Now that your new Qubes-based Admin Workstation is prepared, you can proceed with importing the correct SecureDrop server details and Submission Private Key from your Tails-based Journalist Workstation and Secure Viewing Station USB flash drives.

Import Admin Interface details
-------------------------------------

An Admin Workstation connects to your SecureDrop instance's API via the Admin Interface. In order to do so, it will need the Admin Interface address and authentication info. As the clipboard from another qube cannot be copied into ``dom0`` directly, follow these steps to copy the file into place:

- Locate a Tails-based Admin Workstation or Journalist Workstation USB flash drive. Both hold the address and authentication info for the Admin Interface.

- Connect the USB flash drive to a USB port on the Qubes computer, then use the devices widget in the upper right panel to attach it to the ``vault`` qube. There will be 3 listings for the USB flash drive in the widget: one for the base drive, one for the Tails partition (labeled ``Tails``), and a 3rd unlabeled listing (for the persistent volume). Choose the third listing.

- In the the ``vault`` file manager, select the persistent volume's listing in the lower left sidebar. It will be named ``N GB encrypted``, where N is the size of the persistent volume. Enter the persistent volume passphrase to unlock and mount it. When prompted, select the option to **Forget password immediately**.

- In the ``dom0`` terminal, proceed with the next import step of the ``sdw-admin`` command or re-run

  .. code-block:: sh 

      sdw-admin --configure 

  The command will print out the imported Admin Interface details to confirm before proceeding.

- If you used a Tails-based Admin Workstation drive, or you don't intend to copy a password database to this workstation, safely disconnect the USB flash drive now. In the ``vault`` file manager, right-click on the **TailsData** sidebar entry, then select **Unmount** and disconnect the USB flash drive.

Manually import Admin Interface details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If importing the Admin Interface details using ``sdw-admin --configure`` fails, you can copy the configuration file to ``dom0`` manually.

- If your Admin Interface is based on SecureDrop 2.13.0 or later, use the following command:

  .. code-block:: sh

    qvm-run --pass-io vault \
      "cat /run/media/user/TailsData/securedrop-admin/app-journalist.auth_private" \
      > /tmp/journalist.txt

- If your Admin Interface is based on SecureDrop 2.12.10 or earlier, use the following command:

  .. code-block:: sh

    qvm-run --pass-io vault \
            "cat /run/media/user/TailsData/Persistent/securedrop/install_files/ansible-base/app-journalist.auth_private" \
      > /tmp/journalist.txt

- Verify that the ``/tmp/journalist.txt`` file on ``dom0`` contains valid configuration information using the command ``cat /tmp/journalist.txt`` in the ``dom0`` terminal.

- Proceed with :ref:`configuring the workstation<manual_configure>`

If you encounter a validation error due to a password-protected GPG key, see :doc:`/admin/migration/removing_gpg_passphrase`.

.. _manual_configure:

Once the Admin Interface details and Submission Private Key have been copied to ``dom0``, you can create the configuration for the SecureDrop Workstation.

- Your Submission Private Key has a unique fingerprint required for the configuration. Obtain the fingerprint by using this command:

  .. code-block:: sh

    gpg --with-colons --import-options import-show --dry-run --import /tmp/sd-journalist.sec

  The fingerprint will be on a line that starts with ``fpr``. For example, if the output included the line ``fpr:::::::::65A1B5FF195B56353CC63DFFCC40EF1228271441:``, the fingerprint would be the character sequence ``65A1B5FF195B56353CC63DFFCC40EF1228271441``.

- Next, create the SecureDrop Workstation configuration file:

  .. code-block:: sh

    cd /usr/share/securedrop-workstation-dom0-config
    sudo cp config.json.example config.json

- The ``config.json`` file must be updated with the correct values for your instance. Open it with root privileges in a text editor such as ``vi`` or ``nano`` and update the following fields' values:

  - **submission_key_fpr**: use the value of the Submission Private Key fingerprint as displayed above
  - **hidserv.hostname**: use the hostname of the Admin Interface, including the ``.onion`` TLD
  - **hidserv.key**: use the private v3 Onion Service authorization key value
  - **environment**: use the value ``prod``

.. note::

   You can find the values for the **hidserv.*** fields in the ``/tmp/journalist.txt`` file that you created in ``dom0`` earlier. The file will be formatted as follows:

   .. code-block:: none

     ONIONADDRESS:descriptor:x25519:AUTHTOKEN

- Verify that the configuration is valid using the command below in the ``dom0`` terminal:

  .. code-block:: sh

    sdw-admin --validate

Import KeePassXC database
-------------------------

If you have a KeePassXC database on your Tails-based Admin Workstation USB flash drive, you should copy it to the ``sd-vault`` qube on the new Qubes-based Admin Workstation.

Qubes OS comes with the KeePassXC password manager preinstalled in the ``sd-vault`` qube.

.. include:: /admin/installation/set_up_keepassxc.rst
  :start-after: .. _keepasscx_template_database:
  :end-before: .. _keepassxc_manual_create_database:

.. include:: /admin/installation/prepare_admin_workstation.rst
  :start-after: .. _install_admin_workstation:
  :end-before: .. _import_submission_key: