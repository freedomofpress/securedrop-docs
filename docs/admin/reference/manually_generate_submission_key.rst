Manually Rotate a Submission Key
==================================

It may be necessary to manually generate and a new :ref:`Submission Key<glossary_submission_key>` and install it on your SecureDrop Workstation and Admin Workstation.
.. TODO new screenshots for all steps, showing dom0 Xfce terminal

Create the Submission Key
-------------------------

Generate a SecureDrop Submission Key on a SecureDrop Workstation using the steps below.

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

The Submission Private Key should be moved to a specific location in ``dom0`` where it will be used by SecureDrop. 

#. Enter the follow commands in the same ``dom0`` terminal.
#. To list to list the details of the key you just generated, including its fingerprint run:

   .. code-block:: sh
   
      gpg -K --show-colons --fingerprint
   
#. The key fingerprint is the series of letters and number on the line starting with ``frp::``. Copy this fingerprint (without the colons) and paste it where ``<KeyFingerprint>`` appears in the next command. This will export the Submission Private Key to a temporary file:

   .. code-block:: sh
      
      gpg --export-secret-keys --armor <KeyFingerprint> > /tmp/sd-journalist.sec

#. Verify that the files starts with ``-----BEGIN PGP PRIVATE KEY BLOCK-----`` using the command:

   .. code-block:: sh

      head -n 1 /tmp/sd-journalist.sec

#. If you don't see ``-----BEGIN PGP PRIVATE KEY BLOCK-----`` as the output of the previous command, go back and make sure you've entered the ``<KeyFingerprint>`` correctly.

#. Run the following command to move your new Submission Private Key to its final destination:

   .. code-block:: sh

      sudo mv /tmp/sd-journalist.sec /usr/share/securedrop-workstation-dom0-config/

#. Now that we have moved the Submission Private key we can remove the ``gpg`` keyring by running:

   .. code-block:: sh

      rm -rf ~/.gnupg

Apply configuration with the new key
------------------------------------

To apply the changes to your SecureDrop Workstation, you will need to run:

.. code-block:: sh

   securedrop-manage --configure --target journalist

.. TODO confirm this command

Install key on Admin Workstation, servers, and other SecureDrop Workstations
----------------------------------------------------------------------------

.. TODO 


.. |GPG generate key| image:: ../../images/install/run_gpg_gen_key.png
.. |GPG key options| image:: ../../images/install/key_options.png
.. |OK to generate| image:: ../../images/install/ok_to_generate.png

.. |qubes_menu| image:: ../../images/qubes_menu.png
  :alt: Qubes Application menu
.. |qubes_menu_gear| image:: ../../images/qubes_menu_gear.png
  :alt: System Tools 