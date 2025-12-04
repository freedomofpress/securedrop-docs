Frequently Asked Questions
==========================

Some initial troubleshooting steps for common scenarios follow.
If you continue to have trouble after following these steps, you can contact the
SecureDrop team for further assistance.

Generic Troubleshooting Tips
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When troubleshooting, ensure you are on the latest version of SecureDrop
in your *Admin Workstation*. This is done by accepting the update
when prompted at boot in the GUI that appears.

.. _troubleshooting_admin_connectivity:

I can't SSH into my servers over Tor from my Admin Workstation. What do I do?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At any point after the successful installation of SecureDrop, if you cannot SSH
into your Admin Workstation, you should first perform the following troubleshooting steps:

#. **Ensure that you are connected to Tor.** You can do this by browsing to any site
   in Tor Browser in your *Admin Workstation*.

#. **Ensure your servers are online.** Visit the *Admin Interface* to check
   your *Application Server* is online, and you can trigger a 
   :ref:`test OSSEC alert <test-OSSEC-alert>` to verify your *Monitor Server* is online.

#. **Ensure that SSH aliases and onion service authentication are configured:**

   - First, ensure that the correct configuration files are present in
     ``~/.config/securedrop-admin``:

     - ``app-ssh.auth_private``
     - ``mon-ssh.auth_private``
     - ``app-journalist.auth_private``
     - ``app-sourcev3-ths``
     - ``tor_v3_keys.json``

   - Then, run  ``securedrop-admin localconfig``.
     This will ensure your local Tails environment is configured properly.

#. **Confirm that your SSH key is available**: During the install, you
   configured SSH public key authentication using ``ssh-copy-id``.
   Ensure this key is available using ``ssh-add -L``. If you see the output
   "This agent has no identities." then you need to add the key via ``ssh-add``
   prior to SSHing into the servers.


I got a unusual error when running ``securedrop-admin install``. What do I do?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the error message is not informative, try running it again. The Tor
connection can be flaky and can cause apparent errors, but there is no negative
impact of re-rerunning ``securedrop-admin install`` more than once. The
command will simply check which tasks have been completed, and pick up where it
left off. However, if the same issue persists, you will need to investigate
further.

.. |Reset Passphrase| image:: ../../images/manual/screenshots/journalist-edit_account_user.png
   :alt: The account editing form allows admins to change name, reset passphrase, and reset two-factor authentication.
.. |Test Alert| image:: ../../images/manual/screenshots/journalist-admin_ossec_alert_button.png
   :alt: The Instance Configuration form displays 'Test alert sent' after a test OSSEC alert was sent successfully.
.. |SecureDrop main page| image:: ../../images/manual/screenshots/journalist-admin_index_no_documents.png
   :alt: The top navigation of the Journalist Interface says 'Logged on as Journalist' and displays an 'Admin' link.
.. |SecureDrop admin home| image:: ../../images/manual/screenshots/journalist-admin_interface_index.png
   :alt: The Admin Interface displays an 'Add User' button.
.. |Add a new user| image:: ../../images/manual/screenshots/journalist-admin_add_user_totp.png
   :alt: The form used to create new users displays a pre-generated Diceware passphrase.
.. |Enable FreeOTP| image:: ../../images/manual/screenshots/journalist-admin_new_user_two_factor_totp.png
   :alt: The form used to enable FreeOTP displays a barcode and a two-factor secret.
.. |Enable YubiKey| image:: ../../images/manual/screenshots/journalist-admin_add_user_hotp.png
   :alt: The form used to create new users, filled with the 40-character HOTP secret key of a Yubikey.
.. |Verify YubiKey| image:: ../../images/manual/screenshots/journalist-admin_new_user_two_factor_hotp.png
   :alt: The form used to verify the setup of the Yubikey requests a 6-digit verification code.
.. |Logo Update| image:: ../../images/manual/screenshots/journalist-admin_changes_logo_image.png
   :alt: The Instance Configuration form displays 'Image updated' after the logo was updated successfully.
