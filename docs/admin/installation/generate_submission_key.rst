Generate the Submission Key
=============================

When a Source sends a message or file via SecureDrop, it is automatically encrypted with the instance's :ref:`Submission Key<glossary_submission_key>`. The private part of this key is only stored in an isolated `sd-gpg` qube on the SecureDrop Workstation used by Journalists. Messages and files sent through SecureDrop can only be decrypted on a SecureDrop Workstation using this key.

You only need to generate the Submission Key once. If you set up additional SecureDrop Workstations, you will securely copy the Submission Private Key from an existing Workstation to the new one. 

.. TODO new screenshots for all steps, showing dom0 Xfce terminal

Create the Submission Key
-------------------------

If you have installed Qubes OS on a number of laptops, select the one destined to become the first SecureDrop Workstation for Journalists to use. Create the Submission Key on this laptop with the steps below.

#. If not already, boot and log into Qubes OS.
#. Open a ``dom0`` terminal (|qubes_menu| **▸** |qubes_menu_gear| **▸ Other ▸ Xfce Terminal**).
#. Run the following command:

   .. code-block:: sh
   
      gpg --full-generate-key

   
   |GPG generate key|

#. When it says **Please select what kind of key you want**, choose "*(1) RSA and RSA (default)*".
#. When it asks **What keysize do you want?**, type ``4096``.
#. When it asks **Key is valid for?**, press Enter. This means your key does not expire.
#. It will let you know that this means the key does not expire at all and ask for confirmation. Type **y** and hit Enter to confirm.

   |GPG key options|

#. Next it will prompt you for user ID setup. Use the following options: - **Real name**: "SecureDrop" - **Email address**: leave this field blank - **Comment**: ``[Your Organization's Name] SecureDrop Submission Key``

#. GPG will confirm these options. Verify that everything is written correctly. Then type ``O`` for ``(O)kay`` and hit enter to continue:

   |OK to generate|

#. A box will pop up asking you to type a passphrase. Since the key is protected by the Qubes's full disk encryption, it is safe to simply click **OK** without entering a passphrase.
#. The software will ask you if you are sure. Click **Yes, protection is not needed**.
#. The prompt for a passphrase will appear again. Repeat the last two steps, cliecking **OK** and then **Yes, protection is not needed**.
#. Wait for the key to finish generating.

Move the Submission Keypair
----------------------------

The two private and public parts of your Submission Key should be moved to a specific location in ``dom0`` where they be needed later in the installation process. 

#. Enter the follow commands in the same ``dom0`` terminal.
#. To list to list the details of the key you just generated, including its fingerprint run:

   .. code-block:: sh
   
      gpg -K --fingerprint
   
#. The key fingerprint is the series of letters and number in 10 batches of 4. Enter this fingerprint *without spaces* as the ``<KeyFingerprint>`` in the next command to export the Submission Private Key to a temporary file:

   .. code-block:: sh
      
      gpg --export-secret-keys --armor <KeyFingerprint> > /tmp/sd-journalist.sec

#. Verify that the files starts with ``-----BEGIN PGP PRIVATE KEY BLOCK-----`` using the command:

   .. code-block:: sh

      head -n 1 /tmp/sd-journalist.sec

#. If you don't see ``-----BEGIN PGP PRIVATE KEY BLOCK-----`` as the output of the previous command, go back and make sure you've entered the ``<KeyFingerprint>`` correctly.

#. Run the following command using the same ``<KeyFingerprint>`` to export the Submission Public Key to a temporary file:

   .. note:: Use the ``--export`` flag this time instead of ``export-secret-keys``, as you did before.

   .. code-block:: sh
      
      gpg --export --armor <KeyFingerprint> > /tmp/sd-public.sec

#. Verify that the files starts with ``-----BEGIN PGP PUBLIC KEY BLOCK-----`` using the command:

   .. code-block:: sh

      head -n 1 /tmp/sd-public.sec

#. If you don't see ``-----BEGIN PGP PUBLIC KEY BLOCK-----`` as the output of the previous command, go back and make sure you've entered the ``<KeyFingerprint>`` correctly.

#. Run the following command to move both parts of your Submission key to their final destination:

   .. code-block:: sh

      sudo mv /tmp/sd-journalist.sec /tmp/sd-public.sec /usr/share/securedrop-workstation-dom0-config/

.. |GPG generate key| image:: ../../images/install/run_gpg_gen_key.png
.. |GPG key options| image:: ../../images/install/key_options.png
.. |OK to generate| image:: ../../images/install/ok_to_generate.png

