Transfer public keys to Admin Workstation
=========================================

To configure the SecureDrop servers, the Admin Workstation requires copies of the public keys associated with your SecureDrop. Now is a good time to copy these keys onto the Admin Workstation so they will be available when you install the servers at a later step.

.. _import_submission_key:

Import Submission Public Key
----------------------------

.. TODO waiting for commands

Earlier, you generated the Submission Key. The *public* half of this key needs to be imported to the correct location on the Admin Workstation.

Moving the Submission Public Key to ``sd-admin`` for a combined laptop
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the ``dom0`` terminal, run the command:

.. code-block:: sh

  securedrop-manage --configure --target admin

Importing the Submission Public Key to ``sd-admin`` from another SecureDrop Workstation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. TODO

Copy email alert public keys
----------------------------

SecureDrop sends different email alerts which are encrypted to a private key associated with specific recipient email addresses, as outlined :doc:`here<email_alerts>`.

Before proceeding, you will need to transfer the public keys for the email addresses which will receive the OSSEC and optional Daily Journalist Alerts to ``~/.config/securedrop-admin`` in the ``sd-admin`` qube on the Admin Workstation.

.. _copy_email_public_keys_usb:

Copy public keys using a USB flash drive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can request the public keys from keyservers using the known fingerprint or email address, but it's best to copy the key from a trusted and verified source.

If you have your public keys available on another computer, you can follow the these steps to transfer your them to the Admin Workstation. The public keys are not sensitive, so you can use any standard FAT32 formatted USB flash drive that is readable by any operating system.

#. Copy each public key onto the USB drive from your source computer. Note that you will also need the key fingerprints. You may copy these a text files, or determine them from the keys later.
#. Insert the USB drive into your Admin Workstation. 
#. Open the Qubes Devices Widget and find your newly inserted USB flash drive under **USB Storage** at the bottom of the list (indicated by the word **new** in blue). Attach your USB flash drive to the ``sd-admin`` qube.
#. Open the File Manager in ``sd-admin``: (|qubes_menu| **▸ sd-admin ▸ File Manager**), and mount the drive.
#. Copy everything to the ``~/.config/securedrop-manage/`` directory. You can use the copy and paste functionality of the file manager. Use the location bar to easily get to the destination directory.

Import public keys from a keyserver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Instead of manually transferring your email public keys, you can request them from keyservers using the known fingerprint. Looking a key up by email address or a shorter key ID format could cause you to obtain a wrong, malicious, or expired key. Instead, we recommend you type out your fingerprint in groups of four (just like GPG prints it) enclosed by double quotes. The reason we suggest this formatting for the fingerprint is simply because it's easiest to type and verify correctly. In the code below simply replace ``<fingerprint>`` with your full, space-separated fingerprint:

Download your key and import it into the local keyring: ::

    gpg --recv-key "<fingerprint>"

.. note:: It is important you type this out correctly. If you are not copy-pasting this command, we recommend you double-check you have entered it correctly before pressing enter.

Again, when passing the full public key fingerprint to the ``--recv-key`` command, GPG will implicitly verify that the fingerprint of the key received matches the argument passed.

.. caution:: If GPG warns you that the fingerprint of the key received does not match the one requested **do not** proceed with the installation. If this happens, please email us at securedrop@freedom.press.

Next we export the key to a local file. ::

    gpg --export -a "<fingerprint>" > ossec.pub

Copy the key to a directory where it's accessible by the SecureDrop installation: ::

    cp ossec.pub ~/.config/securedrop-admin/

The fingerprint is a unique identifier for an encryption (public) key.  The short and long key ids correspond to the last 8 and 16 hexadecimal digits of the fingerprint, respectively, and are thus a subset of the fingerprint. The full fingerprint must be the entire 40 hexadecimal digit GPG fingerprint for this same key, with all capital letters and no spaces. The following command will retrieve and format the fingerprint per our requirements: ::

    gpg --with-colons --fingerprint "<fingerprint>" | grep "^fpr" | cut -d: -f10

Custom CA certificate
~~~~~~~~~~~~~~~~~~~~~

The Postfix configuration enforces certificate verification, and requires both a valid certificate and STARTTLS support on the SMTP relay. By default the system CAs will be used for validating the relay certificate.

If you need to provide a custom CA to perform the validation, copy the cert file to ``~/.config/securedrop-admin`` using the same procedure :ref:`described above<copy_email_public_keys_usb>`, and add a new variable to ``~/.config/securedrop-admin/site-specific``: ::

    smtp_relay_cert_override_file: MyOrg.crt

where ``MyOrg.crt`` is the filename. The file will be copied to the server in ``/etc/ssl/certs_local`` and the system CAs will be ignored when validating the SMTP relay TLS certificate. Be sure to save ``~/.config/securedrop-admin/site-specific`` when you are finished.


