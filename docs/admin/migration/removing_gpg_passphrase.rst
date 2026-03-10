Removing the Passphrase from a GPG Key
======================================

GPG key files should not be passphrase-protected for use with SecureDrop Workstation.

In a ``dom0`` terminal on your Qubes workstation
(|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**), assuming a
passphrase-protected secret key file ``/tmp/sd-journalist.sec``,
import the key into a new temporary GnuPG directory, entering the passphrase 
when prompted:

.. code-block:: sh

  export GPGTMP=`mktemp -d`    # create a tempdir
  gpg --homedir=${GPGTMP} --pinentry=loopback --import /tmp/sd-journalist.sec

Next, check the key id:

.. code-block:: sh

  gpg --homedir=${GPGTMP} --list-secret-keys --keyid-format=long

The output should list the key with a line similar to:

.. code-block:: sh

  sec   rsa4096/XXXXXXXXXX <creation date>

The ``XXXXXXXXXX`` value is the key id, which you can use to open the key in edit mode with the following command:

.. code-block:: sh

  gpg --homedir=${GPGTMP} --pinentry=loopback --edit-key XXXXXXXXXX

In the GPG interactive prompt, enter the command ``passwd`` to change the passphrase.
You will first be prompted for the current passphrase. Then, on the next
prompt, press Enter for a new blank passphrase, and Enter again when prompted to
repeat it. Then exit with the command ``quit``.

You should now have a passphrase-less version of the key in the $GPGTMP keyring. To
export it, use the following command with the same key id as above:

.. code-block:: sh

  gpg --homedir=${GPGTMP} --export-secret-key --armor XXXXXXXXXX > /tmp/nopassphrase.sec

Verify that the new keyfile ``/tmp/nopassphrase.sec`` starts with the
``-----BEGIN PGP PRIVATE KEY BLOCK-----`` line. Copy the key into place:

.. code-block:: sh

  sudo cp /tmp/nopassphrase.sec /usr/share/securedrop-workstation-dom0-config/sd-journalist.sec

If you are provisioning SecureDrop Workstation for the first time, continue
with the installation instructions. Or, to re-check an existing configuration:

.. code-block:: sh

  sdw-admin --validate

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 
